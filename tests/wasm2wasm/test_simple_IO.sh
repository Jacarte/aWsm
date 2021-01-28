
P=$1
wat2wasm $P.wat -o $P.wasm
$SILVERFISH $P.wasm --target=wasm32-unknown-wasi --layout="e-m:e-p:32:32-i64:64-n32:64-S128" -o $P.mirror.bc
llvm-dis $P.mirror.bc -o $P.mirror.ll
$WASMLD -lto-O0 -O0 $P.mirror.bc --export-all --no-entry -o $P.mirror.wasm --allow-undefined
wasm2wat -o $P.mirror.wat $P.mirror.wasm
