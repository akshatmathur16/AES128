module inv_step_round #(parameter DATA_WIDTH=8)
(
    input clk,
    input bit [DATA_WIDTH-1:0] ip_data[0:3][0:3],
    input bit [127:0] ip_key,
    output bit [DATA_WIDTH-1:0] round_data_out [0:3][0:3]
);

bit [DATA_WIDTH-1:0] out_sub_matrix [0:3][0:3];
bit [DATA_WIDTH-1:0] out_shift_matrix [0:3][0:3];
bit [31:0] temp_ip_data0, temp_ip_data1, temp_ip_data2, temp_ip_data3; 
bit [127:0] ip_add_round_key_data;
bit [DATA_WIDTH-1:0]  op_add_round_key_data [0:3][0:3];
bit [127:0] mix_col_out_data;

assign temp_ip_data0 = {out_sub_matrix[0][0], out_sub_matrix[1][0], out_sub_matrix[2][0], out_sub_matrix[3][0]};
assign temp_ip_data1 = {out_sub_matrix[0][1], out_sub_matrix[1][1], out_sub_matrix[2][1], out_sub_matrix[3][1]};
assign temp_ip_data2 = {out_sub_matrix[0][2], out_sub_matrix[1][2], out_sub_matrix[2][2], out_sub_matrix[3][2]};
assign temp_ip_data3 = {out_sub_matrix[0][3], out_sub_matrix[1][3], out_sub_matrix[2][3], out_sub_matrix[3][3]};

assign ip_add_round_key_data = {temp_ip_data0, temp_ip_data1, temp_ip_data2, temp_ip_data3};

inv_shift_rows inst_inv_shift_rows
(

    .ip_matrix(ip_data),
    .out_shift_matrix(out_shift_matrix)
);

inv_sub_bytes inst_inv_sub_bytes
(
    .in(out_shift_matrix),
    .out_sub_matrix(out_sub_matrix) 
);

add_round_key inst_add_round_key
(
    .clk(clk),
    .ip_data(ip_add_round_key_data),
    .ip_key(ip_key),
    .out(op_add_round_key_data)
);

inv_mix_column inst_inv_mix_column
(
    .ip_data(op_add_round_key_data),
    .out_data(mix_col_out_data)
);

genvar i,j;

generate
    for(i=0; i< 4; i++)
    begin
        for(j=0; j<4; j++)
        begin
            always@(posedge clk)
            begin
                round_data_out[j][i] <= mix_col_out_data[127- 32*i -8*j -: 8];
            end
        end
    end
endgenerate

endmodule
