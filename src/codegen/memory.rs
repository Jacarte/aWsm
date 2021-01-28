use llvm::{Builder, Context, GlobalValue, GlobalVariable};
use llvm::Compile;
use llvm::FunctionType;
use llvm::PointerType;
use llvm::Sub;
use llvm::Value;
use llvm::Module as LLVMModule;

use wasmparser::ResizableLimits;

use crate::wasm::DataInitializer;
use crate::wasm::ImplementedFunction;
use crate::wasm::Instruction;

use crate::codegen::ModuleCtx;
use crate::codegen::function::compile_function;
use crate::codegen::type_conversions::wasm_func_type_to_llvm_type;

// We add in globals to tell the runtime how much memory to allocate and startup
// (And what the max amount of allocated memory should be)
pub fn add_memory_size_globals(ctx: &ModuleCtx, limits: &ResizableLimits) {
    info!("memory limits {:?}", limits);
    let starting_pages_global = ctx
        .llvm_module
        .add_global_variable("starting_pages", limits.initial.compile(ctx.llvm_ctx));
    starting_pages_global.set_constant(true);

    let maximum: u32 = limits.maximum.unwrap_or(0);
    let max_pages_global = ctx
        .llvm_module
        .add_global_variable("max_pages", maximum.compile(ctx.llvm_ctx));
    max_pages_global.set_constant(true);
}

pub fn generate_linear_memory_simulation<'a>(ctx: &'a Context, module: &'a LLVMModule, initializers: Vec<DataInitializer>) -> &'a GlobalVariable {
    //let mut linear_mem: Vec<(&llvm::Function, Vec<u8>)> = Vec::new();
    let mut initialization_data: Vec<(i32, Vec<u8>)> = Vec::new();
    let mut total = 0;
    for (n, i) in initializers.into_iter().enumerate() {

        let mut full_data = Vec::new();
        assert_eq!(1, i.offset_expression.len());

        let offset = match &i.offset_expression[0] {
            Instruction::I32Const(v) => *v as i32,
            Instruction::I64Const(v) => *v as i32,
            _ => panic!("Data initializer should be a constant instruction")
        };

        for mut d in i.body {
            full_data.append(&mut d);
        }
        total += full_data.len();
        initialization_data.push((offset, full_data));
    }

    // get tentative static size of the memory (1024 * 64)
    let pages = ((total as u32/(1024*64) + 1) as f64).round() as u32;
    info!("Static memory size in pages count {}", pages);

    let mut data_vec: Vec<&Value> = (0..pages*(1024*64)).map(|_| 0.compile(ctx)).collect();

    // FIX: this is rough, try to do it in one pass
    for (offset, vec) in initialization_data {
        for i in offset..(offset + vec.len() as i32) {
            let val = vec.get((i - offset) as usize).unwrap().compile(ctx);
            data_vec[i as usize] = val;
        }
    }

    (*module).add_global_variable(&"linear_memory", Value::new_vector(&data_vec))
}

pub fn generate_memory_initialization_stub(ctx: &ModuleCtx, initializers: Vec<DataInitializer>) {
    let mut initialization_data: Vec<(&llvm::Function, Vec<u8>)> = Vec::new();

    for (n, i) in initializers.into_iter().enumerate() {
        // We need to translate the offset expression into a usable value
        // So we compile a function that evaluates the expression, and use that
        let offset_func = generate_offset_function(ctx, "memory", n, i.offset_expression);

        let mut full_data = Vec::new();
        for mut d in i.body {
            full_data.append(&mut d);
        }
        initialization_data.push((&*offset_func, full_data));
    }

    // The runtime assumes the existence of a setup_memory function that sets up the memory
    // We provide this, by compiling it here
    let setup_function = ctx.llvm_module.add_function(
        "populate_memory",
        FunctionType::new(<()>::get_type(ctx.llvm_ctx), &[]).to_super(),
    );
    let bb = setup_function.append("entry");
    let b = Builder::new(ctx.llvm_ctx);
    b.position_at_end(bb);
    for (i, (offset_func, data)) in initialization_data.into_iter().enumerate() {
        let offset = b.build_call(offset_func, &[]);
        let data_vec: Vec<&Value> = data.iter().map(|byte| byte.compile(ctx.llvm_ctx)).collect();

        let data_value = Value::new_vector(&data_vec);
        let data_global = ctx
            .llvm_module
            .add_global_variable(&format!("init_vector_{}", i), data_value);
        data_global.set_constant(true);

        let data_ptr = data_global.to_super();

        let data_raw_ptr =
            b.build_bit_cast(data_ptr, PointerType::new(<i8>::get_type(ctx.llvm_ctx)));

        /*b.build_call(
            ctx.llvm_module.get_function("initialize_region").unwrap(),
            &[
                offset,
                (data.len() as i32).compile(ctx.llvm_ctx),
                data_raw_ptr,
            ],
        );*/
    }
    b.build_ret_void();
}

pub fn generate_offset_function<'a>(
    ctx: &'a ModuleCtx,
    prefix: &str,
    n: usize,
    mut offset_expression: Vec<Instruction>,
) -> &'a llvm::Function {
    let offset_func_name = format!("init_{}_offset_{}", prefix, n);
    let offset_func_type = wasmparser::FuncType {
        form: wasmparser::Type::Func,
        params: Box::new([]),
        returns: Box::new([wasmparser::Type::I32]),
    };

    offset_expression.push(Instruction::End);

    // Compile function assumes the function is already prototyped
    let offset_func = ctx.llvm_module.add_function(
        &offset_func_name,
        wasm_func_type_to_llvm_type(ctx.llvm_ctx, &offset_func_type),
    );

    compile_function(
        ctx,
        &ImplementedFunction {
            generated_name: offset_func_name.clone(),
            ty: Some(offset_func_type),
            ty_index: None,
            locals: Vec::new(),
            code: offset_expression,
        },
    );

    offset_func
}
