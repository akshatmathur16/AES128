module mix_column #(parameter DATA_WIDTH=8) 
(
    input bit [DATA_WIDTH-1:0] ip_data [0:3][0:3],
    output bit [127:0] out_data
);

bit [31:0] temp_ip_data0, temp_ip_data1, temp_ip_data2, temp_ip_data3; 
bit [31:0] temp_op_data0, temp_op_data1, temp_op_data2, temp_op_data3; 

assign temp_ip_data0 = {ip_data[0][0], ip_data[1][0], ip_data[2][0], ip_data[3][0]};
assign temp_ip_data1 = {ip_data[0][1], ip_data[1][1], ip_data[2][1], ip_data[3][1]};
assign temp_ip_data2 = {ip_data[0][2], ip_data[1][2], ip_data[2][2], ip_data[3][2]};
assign temp_ip_data3 = {ip_data[0][3], ip_data[1][3], ip_data[2][3], ip_data[3][3]};

mult_col m0
(
    .data_in(temp_ip_data0),
    .data_out(temp_op_data0)
);
mult_col m1
(
    .data_in(temp_ip_data1),
    .data_out(temp_op_data1)
);
mult_col m2
(
    .data_in(temp_ip_data2),
    .data_out(temp_op_data2)
);
mult_col m3
(
    .data_in(temp_ip_data3),
    .data_out(temp_op_data3)
);

assign out_data = {temp_op_data0, temp_op_data1, temp_op_data2, temp_op_data3};


endmodule

function bit [7:0] mul2;
    input [7:0] mul2_ip;

    //bit [7:0] mul2_temp;

    mul2={mul2_ip[6:0],1'b0} ^ (8'h1B & {8{mul2_ip[7]}});


endfunction

module mult_col
(
      input [31:0] data_in,
      output [31:0] data_out
);

bit [7:0] ip0, ip1, ip2, ip3;
bit [7:0] op0, op1, op2, op3;

assign ip0=data_in[31:24];
assign ip1=data_in[23:16];
assign ip2=data_in[15:8];
assign ip3=data_in[7:0];


//assign op0 = ip0;
//assign op1 = ip1;
//assign op2 = mul2(ip2);
//assign op3 = mul2(ip3)^ip3;
//
//
//assign data_out[15:8] =op0^ op1^ op2^op3; 

assign data_out[31:24] = mul2(ip0) ^ (mul2(ip1)^ip1) ^ ip2 ^ ip3;
assign data_out[23:16] = ip0 ^ mul2(ip1) ^ (mul2(ip2)^ip2) ^ ip3;
assign data_out[15:8] = ip0 ^ ip1 ^ mul2(ip2) ^ (mul2(ip3)^ip3);
assign data_out[7:0] = (mul2(ip0)^ip0) ^ ip1 ^ ip2 ^ mul2(ip3);

endmodule


