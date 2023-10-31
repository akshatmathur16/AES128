#vlog key_expand.sv add_round_key.sv aes_s_table.sv sub_bytes.sv shift_rows.sv mix_column.sv step_round.sv step_round10.sv aes_encr.sv tb_add_round_key.sv
#vsim work.tb_add_round_key -novopt
project addfile key_expand.sv
project addfile add_round_key.sv
project addfile inv_aes_s_table.sv
project addfile inv_sub_bytes.sv
project addfile inv_shift_rows.sv
project addfile inv_mix_column.sv
project addfile inv_step_round.sv
project addfile inv_step_round10.sv
project addfile aes_decr.sv
project addfile tb_aes_decr.sv
vlog key_expand.sv add_round_key.sv inv_aes_s_table.sv inv_sub_bytes.sv inv_shift_rows.sv inv_mix_column.sv inv_step_round.sv inv_step_round10.sv aes_decr.sv tb_aes_decr.sv
vsim work.tb_aes_decr -novopt

