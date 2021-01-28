(module
  (type (;0;) (func))
  (type (;1;) (func (param i32 i32) (result i32)))
  (type (;2;) (func (result i32)))
  (func $__wasm_call_ctors (type 0))
  (func $f_int__int_ (type 1) (param i32 i32) (result i32)
    (local i32)
    global.get 0
    i32.const 16
    i32.sub
    local.tee 2
    local.get 0
    i32.store offset=12
    local.get 2
    local.get 1
    i32.store offset=8
    local.get 2
    i32.load offset=12
    local.get 2
    i32.load offset=8
    i32.const 31
    i32.and
    i32.shl
    local.get 2
    i32.load offset=12
    i32.const 0
    local.get 2
    i32.load offset=8
    i32.sub
    i32.const 31
    i32.and
    i32.shr_s
    i32.or)
  (func $g_int__int_ (type 1) (param i32 i32) (result i32)
    (local i32)
    global.get 0
    i32.const 16
    i32.sub
    local.tee 2
    local.get 0
    i32.store offset=12
    local.get 2
    local.get 1
    i32.store offset=8
    local.get 2
    i32.load offset=12
    local.get 2
    i32.load offset=8
    i32.const 31
    i32.and
    i32.shr_s
    local.get 2
    i32.load offset=12
    i32.const 0
    local.get 2
    i32.load offset=8
    i32.sub
    i32.const 31
    i32.and
    i32.shl
    i32.or)
  (func $i_int__int_ (type 1) (param i32 i32) (result i32)
    (local i32)
    global.get 0
    i32.const 16
    i32.sub
    local.tee 2
    local.get 0
    i32.store offset=12
    local.get 2
    local.get 1
    i32.store offset=8
    i32.const 1024
    local.get 2
    i32.load offset=12
    i32.const 2
    i32.shl
    i32.add
    local.get 2
    i32.load offset=8
    i32.store
    i32.const 0)
  (func $j__ (type 2) (result i32)
    i32.const 0)
  (func $ga__ (type 2) (result i32)
    i32.const 0)
  (table (;0;) 1 1 funcref)
  (memory (;0;) 2)
  (global (;0;) (mut i32) (i32.const 66960))
  (global (;1;) i32 (i32.const 1024))
  (global (;2;) i32 (i32.const 1024))
  (global (;3;) i32 (i32.const 1424))
  (global (;4;) i32 (i32.const 1024))
  (global (;5;) i32 (i32.const 66960))
  (global (;6;) i32 (i32.const 0))
  (global (;7;) i32 (i32.const 1))
  (export "memory" (memory 0))
  (export "__wasm_call_ctors" (func $__wasm_call_ctors))
  (export "_Z1fii" (func $f_int__int_))
  (export "_Z1gii" (func $g_int__int_))
  (export "_Z1iii" (func $i_int__int_))
  (export "_Z1jv" (func $j__))
  (export "_Z2gav" (func $ga__))
  (export "linear_mem" (global 1))
  (export "__dso_handle" (global 2))
  (export "__data_end" (global 3))
  (export "__global_base" (global 4))
  (export "__heap_base" (global 5))
  (export "__memory_base" (global 6))
  (export "__table_base" (global 7)))
