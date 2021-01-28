
P=$1
shift
#echo -n $P $@
wat2wasm $P --enable-all -o $P.wasm

$SILVERFISH $@  $P.wasm --target=wasm32-unknown-unknown --layout="e-m:e-p:32:32-i64:64-n32:64-S128" -o $P.bc
llvm-dis $P.bc -o $P.ll
$WASMLD -lto-O0 -O0 $P.bc --export-all --allow-undefined --no-entry -o $P.mirror.wasm 
wasm2wat -o $P.mirror.wat $P.mirror.wasm
wasm2wat  $P.wasm -o $P.vv.wat
