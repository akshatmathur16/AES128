module aes_encr
(
    input clk, rst,
    input [127:0] ip_data,
    input [127:0] ip_key,
    output bit [127:0] encr_data_out
);

localparam DATA_WIDTH=8;
localparam ROW_SIZE=4;
localparam COL_SIZE=4;

bit [127:0] expanded_key_matrix [0:10];
bit [DATA_WIDTH-1:0] init_data_out [0:3][0:3];
bit [DATA_WIDTH-1:0] round1_data_out [0:3][0:3];
bit [DATA_WIDTH-1:0] round2_data_out [0:3][0:3];
bit [DATA_WIDTH-1:0] round3_data_out [0:3][0:3];
bit [DATA_WIDTH-1:0] round4_data_out [0:3][0:3];
bit [DATA_WIDTH-1:0] round5_data_out [0:3][0:3];
bit [DATA_WIDTH-1:0] round6_data_out [0:3][0:3];
bit [DATA_WIDTH-1:0] round7_data_out [0:3][0:3];
bit [DATA_WIDTH-1:0] round8_data_out [0:3][0:3];
bit [DATA_WIDTH-1:0] round9_data_out [0:3][0:3];
bit [DATA_WIDTH-1:0] round10_data_out [0:3][0:3];


bit [31:0] temp_encr_data0, temp_encr_data1, temp_encr_data2, temp_encr_data3; 


assign temp_encr_data0 = {round10_data_out[0][0], round10_data_out[1][0], round10_data_out[2][0], round10_data_out[3][0]};
assign temp_encr_data1 = {round10_data_out[0][1], round10_data_out[1][1], round10_data_out[2][1], round10_data_out[3][1]};
assign temp_encr_data2 = {round10_data_out[0][2], round10_data_out[1][2], round10_data_out[2][2], round10_data_out[3][2]};
assign temp_encr_data3 = {round10_data_out[0][3], round10_data_out[1][3], round10_data_out[2][3], round10_data_out[3][3]};

assign encr_data_out = {temp_encr_data0, temp_encr_data1, temp_encr_data2, temp_encr_data3};


key_expand inst_key_expand
(
    .key(ip_key),
    .key_out(expanded_key_matrix)
);


add_round_key inst_add_round_key0
(
    .clk(clk),
    .ip_data(ip_data),
    .ip_key(expanded_key_matrix[0]),
    .out(init_data_out)
);

step_round inst_round1
(
    .clk(clk),
    .ip_data(init_data_out),
    .ip_key(expanded_key_matrix[1]),
    .round_data_out(round1_data_out)
);
step_round inst_round2
(
    .clk(clk),
    .ip_data(round1_data_out),
    .ip_key(expanded_key_matrix[2]),
    .round_data_out(round2_data_out)
);
step_round inst_round3
(
    .clk(clk),
    .ip_data(round2_data_out),
    .ip_key(expanded_key_matrix[3]),
    .round_data_out(round3_data_out)
);
step_round inst_round4
(
    .clk(clk),
    .ip_data(round3_data_out),
    .ip_key(expanded_key_matrix[4]),
    .round_data_out(round4_data_out)
);
step_round inst_round5
(
    .clk(clk),
    .ip_data(round4_data_out),
    .ip_key(expanded_key_matrix[5]),
    .round_data_out(round5_data_out)
);
step_round inst_round6
(
    .clk(clk),
    .ip_data(round5_data_out),
    .ip_key(expanded_key_matrix[6]),
    .round_data_out(round6_data_out)
);

step_round inst_round7
(
    .clk(clk),
    .ip_data(round6_data_out),
    .ip_key(expanded_key_matrix[7]),
    .round_data_out(round7_data_out)
);
step_round inst_round8
(
    .clk(clk),
    .ip_data(round7_data_out),
    .ip_key(expanded_key_matrix[8]),
    .round_data_out(round8_data_out)
);
step_round inst_round9
(
    .clk(clk),
    .ip_data(round8_data_out),
    .ip_key(expanded_key_matrix[9]),
    .round_data_out(round9_data_out)
);
step_round10 inst_round10
(
    .clk(clk),
    .ip_data(round9_data_out),
    .ip_key(expanded_key_matrix[10]),
    .round_data_out(round10_data_out)
);




////creating input data 4x4 matrix
//
//assign ip_data_arr[0] = {ip_data[7:0], ip_data[39:32], ip_data[71:64], ip_data[103:96]};
//assign ip_data_arr[1] = {ip_data[15:8],ip_data[47:40],ip_data[79:72],ip_data[111:104]};
//assign ip_data_arr[2] = {ip_data[23:16], ip_data[55:48],ip_data[87:80],ip_data[119:112]};
//assign ip_data_arr[3] = {ip_data[31:24], ip_data[63:56],ip_data[95:88],ip_data[127:120]};

//Only to display input matrix
//bit [127:0] ip_data_temp;
//initial begin
//    ip_data_temp = 128'hFABCDEBFAEBDABFEF897AB7583957432; 
//    $display("ip_data_temp=%h", ip_data_temp);
//
//    ip_data_arr[0] = {ip_data_temp[7:0], ip_data_temp[39:32], ip_data_temp[71:64], ip_data_temp[103:96]};
//    ip_data_arr[1] = {ip_data_temp[15:8],ip_data_temp[47:40],ip_data_temp[79:72],ip_data_temp[111:104]};
//    ip_data_arr[2] = {ip_data_temp[23:16], ip_data_temp[55:48],ip_data_temp[87:80],ip_data_temp[119:112]};
//    ip_data_arr[3] = {ip_data_temp[31:24], ip_data_temp[63:56],ip_data_temp[95:88],ip_data_temp[127:120]};
//
//    for(int i=0; i<ROW_SIZE; i++)
//    begin
//        $display("ip_data_arr[%d] = %p",i, ip_data_arr[i]);
//    end
//end


endmodule
