module step_round10 #(parameter DATA_WIDTH=8)
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



sub_bytes inst_sub_bytes
(
    .in(ip_data),
    .out_sub_matrix(out_sub_matrix) 
);

shift_rows inst_shift_rows
(

    .clk(clk),
    .ip_matrix(out_sub_matrix),
    .out_shift_matrix(out_shift_matrix)
);


assign temp_ip_data0 = {out_shift_matrix[0][0], out_shift_matrix[1][0], out_shift_matrix[2][0], out_shift_matrix[3][0]};
assign temp_ip_data1= {out_shift_matrix[0][1], out_shift_matrix[1][1], out_shift_matrix[2][1], out_shift_matrix[3][1]};
assign temp_ip_data2 = {out_shift_matrix[0][2], out_shift_matrix[1][2], out_shift_matrix[2][2], out_shift_matrix[3][2]};
assign temp_ip_data3 = {out_shift_matrix[0][3], out_shift_matrix[1][3], out_shift_matrix[2][3], out_shift_matrix[3][3]};

assign ip_add_round_key_data = {temp_ip_data0, temp_ip_data1, temp_ip_data2, temp_ip_data3};

add_round_key inst_add_round_key
(
    .clk(clk),
    .ip_data(ip_add_round_key_data),
    .ip_key(ip_key),
    .out(round_data_out)
);




endmodule
