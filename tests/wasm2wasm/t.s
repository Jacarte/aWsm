	.text
	.file	"main.cpp"
	.section	.text._Z1fii,"",@
	.hidden	_Z1fii                  # -- Begin function _Z1fii
	.globl	_Z1fii
	.type	_Z1fii,@function
_Z1fii:                                 # @_Z1fii
	.functype	_Z1fii (i32, i32) -> (i32)
	.local  	i32
# %bb.0:                                # %entry
	global.get	__stack_pointer
	i32.const	16
	i32.sub 
	local.tee	2
	local.get	0
	i32.store	12
	local.get	2
	local.get	1
	i32.store	8
	local.get	2
	i32.load	12
	local.get	2
	i32.load	8
	i32.const	31
	i32.and 
	i32.shl 
	local.get	2
	i32.load	12
	i32.const	0
	local.get	2
	i32.load	8
	i32.sub 
	i32.const	31
	i32.and 
	i32.shr_s
	i32.or  
                                        # fallthrough-return
	end_function
.Lfunc_end0:
	.size	_Z1fii, .Lfunc_end0-_Z1fii
                                        # -- End function
	.section	.text._Z1gii,"",@
	.hidden	_Z1gii                  # -- Begin function _Z1gii
	.globl	_Z1gii
	.type	_Z1gii,@function
_Z1gii:                                 # @_Z1gii
	.functype	_Z1gii (i32, i32) -> (i32)
	.local  	i32
# %bb.0:                                # %entry
	global.get	__stack_pointer
	i32.const	16
	i32.sub 
	local.tee	2
	local.get	0
	i32.store	12
	local.get	2
	local.get	1
	i32.store	8
	local.get	2
	i32.load	12
	local.get	2
	i32.load	8
	i32.const	31
	i32.and 
	i32.shr_s
	local.get	2
	i32.load	12
	i32.const	0
	local.get	2
	i32.load	8
	i32.sub 
	i32.const	31
	i32.and 
	i32.shl 
	i32.or  
                                        # fallthrough-return
	end_function
.Lfunc_end1:
	.size	_Z1gii, .Lfunc_end1-_Z1gii
                                        # -- End function
	.section	.text._Z1iii,"",@
	.hidden	_Z1iii                  # -- Begin function _Z1iii
	.globl	_Z1iii
	.type	_Z1iii,@function
_Z1iii:                                 # @_Z1iii
	.functype	_Z1iii (i32, i32) -> (i32)
	.local  	i32
# %bb.0:                                # %entry
	global.get	__stack_pointer
	i32.const	16
	i32.sub 
	local.tee	2
	local.get	0
	i32.store	12
	local.get	2
	local.get	1
	i32.store	8
	i32.const	linear_mem
	local.get	2
	i32.load	12
	i32.const	2
	i32.shl 
	i32.add 
	local.get	2
	i32.load	8
	i32.store	0
	i32.const	0
                                        # fallthrough-return
	end_function
.Lfunc_end2:
	.size	_Z1iii, .Lfunc_end2-_Z1iii
                                        # -- End function
	.section	.text._Z1jv,"",@
	.hidden	_Z1jv                   # -- Begin function _Z1jv
	.globl	_Z1jv
	.type	_Z1jv,@function
_Z1jv:                                  # @_Z1jv
	.functype	_Z1jv () -> (i32)
# %bb.0:                                # %entry
	i32.const	0
	i32.load	_ZL10__global_1
                                        # fallthrough-return
	end_function
.Lfunc_end3:
	.size	_Z1jv, .Lfunc_end3-_Z1jv
                                        # -- End function
	.section	.text._Z2gav,"",@
	.hidden	_Z2gav                  # -- Begin function _Z2gav
	.globl	_Z2gav
	.type	_Z2gav,@function
_Z2gav:                                 # @_Z2gav
	.functype	_Z2gav () -> (i32)
# %bb.0:                                # %entry
	i32.const	0
	i32.load	global2
                                        # fallthrough-return
	end_function
.Lfunc_end4:
	.size	_Z2gav, .Lfunc_end4-_Z2gav
                                        # -- End function
	.hidden	linear_mem              # @linear_mem
	.type	linear_mem,@object
	.section	.bss.linear_mem,"",@
	.globl	linear_mem
	.p2align	4
linear_mem:
	.skip	400
	.size	linear_mem, 400

	.type	_ZL10__global_1,@object # @_ZL10__global_1
	.section	.bss._ZL10__global_1,"",@
	.p2align	2
_ZL10__global_1:
	.int32	0                       # 0x0
	.size	_ZL10__global_1, 4

	.ident	"clang version 12.0.0 (https://github.com/Jacarte/llvm-project.git b4f6be84dff4c817ca7de248d0fd1ce16504a2c0)"
	.globaltype	__stack_pointer, i32
	.size	global2, 4
	.section	.custom_section.producers,"",@
	.int8	1
	.int8	12
	.ascii	"processed-by"
	.int8	1
	.int8	5
	.ascii	"clang"
	.int8	93
	.ascii	"12.0.0 (https://github.com/Jacarte/llvm-project.git b4f6be84dff4c817ca7de248d0fd1ce16504a2c0)"
	.section	.bss._ZL10__global_1,"",@
