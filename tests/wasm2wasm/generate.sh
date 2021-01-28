$CLANGO -c main.c --target=wasm32-wasi -emit-llvm -o t.bc
#$CLANGO -S main.c --target=wasm32-wasi -emit-llvm -o t.ll

#llc -asm-verbose -relocation-model=static -o t.s t.bc
#$CLANGO -c main.c --target=wasm32-wasi -emit-llvm -S -o t.ll
llvm-as t.ll -o t.1.bc
llc  -asm-verbose -o t.1s t.1.bc
$WASMLD t.1.bc --allow-undefined --no-entry -o t.1.wasm --export-all
wasm2wat t.1.wasm -o t.1.wat