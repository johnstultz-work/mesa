mkdir -p prebuilt-intermediates/{glsl,ir3,main,nir,spirv}

python src/compiler/glsl/ir_expression_operation.py strings > prebuilt-intermediates/glsl/ir_expression_operation_strings.h 
python src/compiler/glsl/ir_expression_operation.py constant > prebuilt-intermediates/glsl/ir_expression_operation_constant.h
python src/compiler/glsl/ir_expression_operation.py enum > prebuilt-intermediates/glsl/ir_expression_operation.h

python src/freedreno/ir3/ir3_nir_trig.py -p src/compiler/nir > prebuilt-intermediates/ir3/ir3_nir_trig.c

python src/mesa/main/format_pack.py  src/mesa/main/formats.csv  > prebuilt-intermediates/main/format_pack.c
python src/mesa/main/format_unpack.py  src/mesa/main/formats.csv  > prebuilt-intermediates/main/format_unpack.c
python src/mesa/main/format_fallback.py  src/mesa/main/formats.csv /dev/stdout  > prebuilt-intermediates/main/format_fallback.c

python src/compiler/nir/nir_builder_opcodes_h.py src/compiler/nir/nir_opcodes.py > prebuilt-intermediates/nir/nir_builder_opcodes.h 
python src/compiler/nir/nir_constant_expressions.py src/compiler/nir/nir_opcodes.py > prebuilt-intermediates/nir/nir_constant_expressions.c 
python src/compiler/nir/nir_opcodes_c.py src/compiler/nir/nir_opcodes.py > prebuilt-intermediates/nir/nir_opcodes.c 
python src/compiler/nir/nir_opcodes_h.py src/compiler/nir/nir_opcodes.py > prebuilt-intermediates/nir/nir_opcodes.h
python src/compiler/nir/nir_opt_algebraic.py src/compiler/nir/nir_opt_algebraic.py > prebuilt-intermediates/nir/nir_opt_algebraic.c 
python src/compiler/nir/nir_intrinsics_c.py --outdir prebuilt-intermediates/nir/ || ( prebuilt-intermediates/nir/nir_intrinsics.c; false)
python src/compiler/nir/nir_intrinsics_h.py --outdir prebuilt-intermediates/nir/ || ( prebuilt-intermediates/nir/nir_intrinsics.h; false)

python src/compiler/spirv/spirv_info_c.py src/compiler/spirv/spirv.core.grammar.json prebuilt-intermediates/spirv/spirv_info.c || ( prebuilt-intermediates/spirv/spirv_info.c; false)
python src/compiler/spirv/vtn_gather_types_c.py src/compiler/spirv/spirv.core.grammar.json prebuilt-intermediates/spirv/vtn_gather_types.c || ( prebuilt-intermediates/spirv/vtn_gather_types.c; false)

