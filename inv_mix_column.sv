module inv_mix_column #(parameter DATA_WIDTH=8) 
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

function bit [7:0] mult;
    input [7:0] mult_ip;
    input [2:0] mult_rot;

    begin
        for(int i=0; i<mult_rot; i++)
        begin
            mult_ip={mult_ip<<1} ^ (8'h1B & {8{mult_ip[7]}});
            //if(mult_ip[7] == 1) 
            //    mult_ip = ((mult_ip << 1) ^ 8'h1b);
            //else mult_ip = mult_ip << 1; 
        end
        mult = mult_ip;
    
    end
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


//assign op0 =  mult(ip0,'d3) ^ mult(ip0,'d2)^ mult(ip0,'d1); //*0E
//assign op1 = mult(ip1,'d3) ^ mult(ip1, 'd1) ^ ip1; //*0B
//assign op2 = mult(ip2,'d3) ^ mult(ip2, 'd2) ^ ip2; //*0D
//assign op3 = mult(ip3,'d3) ^ ip3 ; //*09
//initial begin
//    $monitor($time,"op0 = %h, %h, %h \n op1 = %h, %h \n op2 = %h, %h, %h \n op3 = %h, %h", mult(ip0, 'd3), mult(ip0, 'd2), mult(ip0, 'd1), mult(ip1, 'd3), mult(ip1, 'd1), mult(ip2, 'd3), mult(ip2, 'd2), ip2,mult(ip3, 'd3), ip3);
//end


//assign data_out[31:24] =op0^ op1^ op2^op3; 
                         //0E.s0 ^ 0B.s1 ^ oD.s2 ^ 09.s3
assign data_out[31:24] = (mult(ip0,'d3) ^ mult(ip0,'d2)^ mult(ip0,'d1)) ^ (mult(ip1,'d3) ^ mult(ip1, 'd1) ^ ip1) ^ (mult(ip2,'d3) ^ mult(ip2, 'd2) ^ ip2) ^ (mult(ip3,'d3) ^ ip3)   ;
                         //09.s0 ^ 0E.s1 ^ 0B.s2 ^ 0D.s3
assign data_out[23:16] = (mult(ip0,'d3) ^ ip0) ^ (mult(ip1,'d3) ^ mult(ip1,'d2)^ mult(ip1,'d1)) ^ (mult(ip2,'d3) ^ mult(ip2, 'd1) ^ ip2) ^ (mult(ip3,'d3) ^ mult(ip3, 'd2) ^ ip3);
//                        //0D.s0 ^ 09.s1^ 0E.s2^ 0B.s3
assign data_out[15:8] =  (mult(ip0,'d3) ^ mult(ip0, 'd2) ^ ip0) ^ (mult(ip1,'d3) ^ ip1) ^ (mult(ip2,'d3) ^ mult(ip2,'d2)^ mult(ip2,'d1)) ^ (mult(ip3,'d3) ^ mult(ip3, 'd1) ^ ip3) ;
//                        //0B.s0 ^ 0D.s1^ 09.s2 ^ 0E.s3
assign data_out[7:0] = (mult(ip0,'d3) ^ mult(ip0, 'd1) ^ ip0) ^ (mult(ip1,'d3) ^ mult(ip1, 'd2) ^ ip1) ^ (mult(ip2,'d3) ^ ip2) ^ (mult(ip3,'d3) ^ mult(ip3,'d2)^ mult(ip3,'d1));

endmodule


