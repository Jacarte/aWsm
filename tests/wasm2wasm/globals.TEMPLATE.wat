(module
  (type (;0;) (func (param i32 i32) (result i32)))
  (func $main (type 0) (param i32 i32) (result i32)
    global.get 0
	)
  (table (;0;) 1 1 funcref)
  (memory (;0;) 2)
  (global (;0;) (mut i32) (i32.const 128))
  (export "main" (func $main))
)