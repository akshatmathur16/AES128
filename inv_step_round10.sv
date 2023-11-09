// as per protocol round 10 is different from other rounds
module inv_step_round10 #(parameter DATA_WIDTH=8)
(
    input clk,
    input bit [DATA_WIDTH-1:0] ip_data[0:3][0:3],
    input bit [127:0] ip_key,
    output bit [DATA_WIDTH-1:0] round_data_out_reg [0:3][0:3]
);

bit [DATA_WIDTH-1:0] out_sub_matrix [0:3][0:3];
bit [DATA_WIDTH-1:0] out_shift_matrix [0:3][0:3];
bit [31:0] temp_ip_data0, temp_ip_data1, temp_ip_data2, temp_ip_data3; 
bit [127:0] ip_add_round_key_data;
bit [DATA_WIDTH-1:0]  op_add_round_key_data [0:3][0:3];
bit [127:0] mix_col_out_data;
bit [DATA_WIDTH-1:0] round_data_out[0:3][0:3];

always @(posedge clk)
begin
    temp_ip_data0 <= {out_sub_matrix[0][0], out_sub_matrix[1][0], out_sub_matrix[2][0], out_sub_matrix[3][0]};
    temp_ip_data1 <= {out_sub_matrix[0][1], out_sub_matrix[1][1], out_sub_matrix[2][1], out_sub_matrix[3][1]};
    temp_ip_data2 <= {out_sub_matrix[0][2], out_sub_matrix[1][2], out_sub_matrix[2][2], out_sub_matrix[3][2]};
    temp_ip_data3 <= {out_sub_matrix[0][3], out_sub_matrix[1][3], out_sub_matrix[2][3], out_sub_matrix[3][3]};
end

//AM assign ip_add_round_key_data = {temp_ip_data0, temp_ip_data1, temp_ip_data2, temp_ip_data3};
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
    .out(round_data_out)
);

//AM always @(posedge clk)
//AM begin
//AM     round_data_out_reg <= round_data_out;
//AM end
assign     round_data_out_reg = round_data_out;

endmodule
