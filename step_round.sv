module step_round #(parameter DATA_WIDTH=8)
(
    input clk,
    input bit [DATA_WIDTH-1:0] ip_data[0:3][0:3],
    input bit [127:0] ip_key,
    output bit [DATA_WIDTH-1:0] round_data_out [0:3][0:3]
);

bit [DATA_WIDTH-1:0] out_sub_matrix [0:3][0:3];
bit [DATA_WIDTH-1:0] out_shift_matrix [0:3][0:3];
bit [127:0] mix_col_out_data;



sub_bytes inst_sub_bytes
(
    .in(ip_data),
    .out_sub_matrix(out_sub_matrix) 
);

shift_rows inst_shift_rows
(

    .ip_matrix(out_sub_matrix),
    .out_shift_matrix(out_shift_matrix)
);

mix_column inst_mix_column
(
    .ip_data(out_shift_matrix),
    .out_data(mix_col_out_data)
);

add_round_key inst_add_round_key
(
    .clk(clk),
    .ip_data(mix_col_out_data),
    .ip_key(ip_key),
    .out(round_data_out)
);




endmodule
