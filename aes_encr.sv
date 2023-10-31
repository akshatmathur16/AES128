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


bit [127:0] round_1_key_reg1,  round_1_key_reg2;
bit [127:0] round_2_key_reg1,  round_2_key_reg2,  round_2_key_reg3,  round_2_key_reg4;
bit [127:0] round_3_key_reg1,  round_3_key_reg2,  round_3_key_reg3,  round_3_key_reg4,   round_3_key_reg5,  round_3_key_reg6;
bit [127:0] round_4_key_reg1,  round_4_key_reg2,  round_4_key_reg3,  round_4_key_reg4,   round_4_key_reg5,  round_4_key_reg6,  round_4_key_reg7,  round_4_key_reg8;
bit [127:0] round_5_key_reg1,  round_5_key_reg2,  round_5_key_reg3,  round_5_key_reg4,   round_5_key_reg5,  round_5_key_reg6,  round_5_key_reg7,  round_5_key_reg8,  round_5_key_reg9,  round_5_key_reg10;
bit [127:0] round_6_key_reg1,  round_6_key_reg2,  round_6_key_reg3,  round_6_key_reg4,   round_6_key_reg5,  round_6_key_reg6,  round_6_key_reg7,  round_6_key_reg8,  round_6_key_reg9,  round_6_key_reg10,  round_6_key_reg11,  round_6_key_reg12;
bit [127:0] round_7_key_reg1,  round_7_key_reg2,  round_7_key_reg3,  round_7_key_reg4,   round_7_key_reg5,  round_7_key_reg6,  round_7_key_reg7,  round_7_key_reg8,  round_7_key_reg9,  round_7_key_reg10,  round_7_key_reg11,  round_7_key_reg12,  round_7_key_reg13,  round_7_key_reg14;
bit [127:0] round_8_key_reg1,  round_8_key_reg2,  round_8_key_reg3,  round_8_key_reg4,   round_8_key_reg5,  round_8_key_reg6,  round_8_key_reg7,  round_8_key_reg8,  round_8_key_reg9,  round_8_key_reg10,  round_8_key_reg11,  round_8_key_reg12,  round_8_key_reg13,  round_8_key_reg14,  round_8_key_reg15,  round_8_key_reg16;
bit [127:0] round_9_key_reg1,  round_9_key_reg2,  round_9_key_reg3,  round_9_key_reg4,   round_9_key_reg5,  round_9_key_reg6,  round_9_key_reg7,  round_9_key_reg8,  round_9_key_reg9,  round_9_key_reg10,  round_9_key_reg11,  round_9_key_reg12,  round_9_key_reg13,  round_9_key_reg14,  round_9_key_reg15,  round_9_key_reg16,  round_9_key_reg17,  round_9_key_reg18;
bit [127:0] round_10_key_reg1,  round_10_key_reg2,  round_10_key_reg3,  round_10_key_reg4,   round_10_key_reg5,  round_10_key_reg6,  round_10_key_reg7,  round_10_key_reg8,  round_10_key_reg9,  round_10_key_reg10,  round_10_key_reg11,  round_10_key_reg12,  round_10_key_reg13,  round_10_key_reg14,  round_10_key_reg15,  round_10_key_reg16,  round_10_key_reg17,  round_10_key_reg18,  round_10_key_reg19,  round_10_key_reg20;


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
    .ip_key(round_1_key_reg2),
    .round_data_out(round1_data_out)
);
step_round inst_round2
(
    .clk(clk),
    .ip_data(round1_data_out),
    .ip_key(round_2_key_reg4),
    .round_data_out(round2_data_out)
);
step_round inst_round3
(
    .clk(clk),
    .ip_data(round2_data_out),
    .ip_key(round_3_key_reg6),
    .round_data_out(round3_data_out)
);
step_round inst_round4
(
    .clk(clk),
    .ip_data(round3_data_out),
    .ip_key(round_4_key_reg8),
    .round_data_out(round4_data_out)
);
step_round inst_round5
(
    .clk(clk),
    .ip_data(round4_data_out),
    .ip_key(round_5_key_reg10),
    .round_data_out(round5_data_out)
);
step_round inst_round6
(
    .clk(clk),
    .ip_data(round5_data_out),
    .ip_key(round_6_key_reg12),
    .round_data_out(round6_data_out)
);

step_round inst_round7
(
    .clk(clk),
    .ip_data(round6_data_out),
    .ip_key(round_7_key_reg14),
    .round_data_out(round7_data_out)
);
step_round inst_round8
(
    .clk(clk),
    .ip_data(round7_data_out),
    .ip_key(round_8_key_reg16),
    .round_data_out(round8_data_out)
);
step_round inst_round9
(
    .clk(clk),
    .ip_data(round8_data_out),
    .ip_key(round_9_key_reg18),
    .round_data_out(round9_data_out)
);
step_round10 inst_round10
(
    .clk(clk),
    .ip_data(round9_data_out),
    .ip_key(round_10_key_reg20),
    .round_data_out(round10_data_out)
);




always@(posedge clk)
begin
    if(rst)
    begin
        round_1_key_reg1<='b0;
        round_1_key_reg2<='b0;
        round_2_key_reg1<='b0;
        round_2_key_reg2<='b0;
        round_2_key_reg3<='b0;
        round_2_key_reg4<='b0;
        round_3_key_reg1<='b0;
        round_3_key_reg2<='b0;
        round_3_key_reg3<='b0;
        round_3_key_reg4<='b0;
        round_3_key_reg5<='b0;
        round_3_key_reg6<='b0;
        round_4_key_reg1<='b0;
        round_4_key_reg2<='b0;
        round_4_key_reg3<='b0;
        round_4_key_reg4<='b0;
        round_4_key_reg5<='b0;
        round_4_key_reg6<='b0;
        round_4_key_reg7<='b0;
        round_4_key_reg8<='b0;
        round_5_key_reg1<='b0;
        round_5_key_reg2<='b0;
        round_5_key_reg3<='b0;
        round_5_key_reg4<='b0;
        round_5_key_reg5<='b0;
        round_5_key_reg6<='b0;
        round_5_key_reg7<='b0;
        round_5_key_reg8<='b0;
        round_5_key_reg9<='b0;
        round_5_key_reg10<='b0;
        round_6_key_reg1<='b0;
        round_6_key_reg2<='b0;
        round_6_key_reg3<='b0;
        round_6_key_reg4<='b0;
        round_6_key_reg5<='b0;
        round_6_key_reg6<='b0;
        round_6_key_reg7<='b0;
        round_6_key_reg8<='b0;
        round_6_key_reg9<='b0;
        round_6_key_reg10<='b0;
        round_6_key_reg11<='b0;
        round_6_key_reg12<='b0;
        round_7_key_reg1<='b0;
        round_7_key_reg2<='b0;
        round_7_key_reg3<='b0;
        round_7_key_reg4<='b0;
        round_7_key_reg5<='b0;
        round_7_key_reg6<='b0;
        round_7_key_reg7<='b0;
        round_7_key_reg8<='b0;
        round_7_key_reg9<='b0;
        round_7_key_reg10<='b0;
        round_7_key_reg11<='b0;
        round_7_key_reg12<='b0;
        round_7_key_reg13<='b0;
        round_7_key_reg14<='b0;
        round_8_key_reg1<='b0;
        round_8_key_reg2<='b0;
        round_8_key_reg3<='b0;
        round_8_key_reg4<='b0;
        round_8_key_reg5<='b0;
        round_8_key_reg6<='b0;
        round_8_key_reg7<='b0;
        round_8_key_reg8<='b0;
        round_8_key_reg9<='b0;
        round_8_key_reg10<='b0;
        round_8_key_reg11<='b0;
        round_8_key_reg12<='b0;
        round_8_key_reg13<='b0;
        round_8_key_reg14<='b0;
        round_8_key_reg15<='b0;
        round_8_key_reg16<='b0;
        round_9_key_reg1<='b0;
        round_9_key_reg2<='b0;
        round_9_key_reg3<='b0;
        round_9_key_reg4<='b0;
        round_9_key_reg5<='b0;
        round_9_key_reg6<='b0;
        round_9_key_reg7<='b0;
        round_9_key_reg8<='b0;
        round_9_key_reg9<='b0;
        round_9_key_reg10<='b0;
        round_9_key_reg11<='b0;
        round_9_key_reg12<='b0;
        round_9_key_reg13<='b0;
        round_9_key_reg14<='b0;
        round_9_key_reg15<='b0;
        round_9_key_reg16<='b0;
        round_9_key_reg17<='b0;
        round_9_key_reg18<='b0;
        round_10_key_reg1<='b0;
        round_10_key_reg2<='b0;
        round_10_key_reg3<='b0;
        round_10_key_reg4<='b0;
        round_10_key_reg5<='b0;
        round_10_key_reg6<='b0;
        round_10_key_reg7<='b0;
        round_10_key_reg8<='b0;
        round_10_key_reg9<='b0;
        round_10_key_reg10<='b0;
        round_10_key_reg11<='b0;
        round_10_key_reg12<='b0;
        round_10_key_reg13<='b0;
        round_10_key_reg14<='b0;
        round_10_key_reg15<='b0;
        round_10_key_reg16<='b0;
        round_10_key_reg17<='b0;
        round_10_key_reg18<='b0;
        round_10_key_reg19<='b0;
        round_10_key_reg20<='b0;
    end
    else
    begin
        //Round 1
        round_1_key_reg1 <= expanded_key_matrix[1];
        round_1_key_reg2 <= round_1_key_reg1; 

        //Round 2
        round_2_key_reg1 <= expanded_key_matrix[2];
        round_2_key_reg2 <= round_2_key_reg1; 
        round_2_key_reg3 <= round_2_key_reg2; 
        round_2_key_reg4 <= round_2_key_reg3; 


        //Round 3
        round_3_key_reg1 <= expanded_key_matrix[3];
        round_3_key_reg2 <= round_3_key_reg1; 
        round_3_key_reg3 <= round_3_key_reg2; 
        round_3_key_reg4 <= round_3_key_reg3; 
        round_3_key_reg5 <= round_3_key_reg4; 
        round_3_key_reg6 <= round_3_key_reg5; 


        //Round 4
        round_4_key_reg1 <= expanded_key_matrix[4];
        round_4_key_reg2 <= round_4_key_reg1; 
        round_4_key_reg3 <= round_4_key_reg2; 
        round_4_key_reg4 <= round_4_key_reg3; 
        round_4_key_reg5 <= round_4_key_reg4; 
        round_4_key_reg6 <= round_4_key_reg5; 
        round_4_key_reg7 <= round_4_key_reg6; 
        round_4_key_reg8 <= round_4_key_reg7; 

        //Round 5
        round_5_key_reg1 <= expanded_key_matrix[5];
        round_5_key_reg2 <= round_5_key_reg1; 
        round_5_key_reg3 <= round_5_key_reg2; 
        round_5_key_reg4 <= round_5_key_reg3; 
        round_5_key_reg5 <= round_5_key_reg4; 
        round_5_key_reg6 <= round_5_key_reg5; 
        round_5_key_reg7 <= round_5_key_reg6; 
        round_5_key_reg8 <= round_5_key_reg7; 
        round_5_key_reg9 <= round_5_key_reg8; 
        round_5_key_reg10 <= round_5_key_reg9; 

        //Round 6
        round_6_key_reg1 <= expanded_key_matrix[6];
        round_6_key_reg2 <= round_6_key_reg1; 
        round_6_key_reg3 <= round_6_key_reg2; 
        round_6_key_reg4 <= round_6_key_reg3; 
        round_6_key_reg5 <= round_6_key_reg4; 
        round_6_key_reg6 <= round_6_key_reg5; 
        round_6_key_reg7 <= round_6_key_reg6; 
        round_6_key_reg8 <= round_6_key_reg7; 
        round_6_key_reg9 <= round_6_key_reg8; 
        round_6_key_reg10 <= round_6_key_reg9; 
        round_6_key_reg11 <= round_6_key_reg10; 
        round_6_key_reg12 <= round_6_key_reg11; 

        //Round 7
        round_7_key_reg1 <= expanded_key_matrix[7];
        round_7_key_reg2 <= round_7_key_reg1; 
        round_7_key_reg3 <= round_7_key_reg2; 
        round_7_key_reg4 <= round_7_key_reg3; 
        round_7_key_reg5 <= round_7_key_reg4; 
        round_7_key_reg6 <= round_7_key_reg5; 
        round_7_key_reg7 <= round_7_key_reg6; 
        round_7_key_reg8 <= round_7_key_reg7; 
        round_7_key_reg9 <= round_7_key_reg8; 
        round_7_key_reg10 <= round_7_key_reg9; 
        round_7_key_reg11 <= round_7_key_reg10; 
        round_7_key_reg12 <= round_7_key_reg11; 
        round_7_key_reg13 <= round_7_key_reg12; 
        round_7_key_reg14 <= round_7_key_reg13; 

        //Round 8
        round_8_key_reg1 <= expanded_key_matrix[8];
        round_8_key_reg2 <= round_8_key_reg1; 
        round_8_key_reg3 <= round_8_key_reg2; 
        round_8_key_reg4 <= round_8_key_reg3; 
        round_8_key_reg5 <= round_8_key_reg4; 
        round_8_key_reg6 <= round_8_key_reg5; 
        round_8_key_reg7 <= round_8_key_reg6; 
        round_8_key_reg8 <= round_8_key_reg7; 
        round_8_key_reg9 <= round_8_key_reg8; 
        round_8_key_reg10 <= round_8_key_reg9; 
        round_8_key_reg11 <= round_8_key_reg10; 
        round_8_key_reg12 <= round_8_key_reg11; 
        round_8_key_reg13 <= round_8_key_reg12; 
        round_8_key_reg14 <= round_8_key_reg13; 
        round_8_key_reg15 <= round_8_key_reg14; 
        round_8_key_reg16 <= round_8_key_reg15; 

        //Round 9
        round_9_key_reg1 <= expanded_key_matrix[9];
        round_9_key_reg2 <= round_9_key_reg1; 
        round_9_key_reg3 <= round_9_key_reg2; 
        round_9_key_reg4 <= round_9_key_reg3; 
        round_9_key_reg5 <= round_9_key_reg4; 
        round_9_key_reg6 <= round_9_key_reg5; 
        round_9_key_reg7 <= round_9_key_reg6; 
        round_9_key_reg8 <= round_9_key_reg7; 
        round_9_key_reg9 <= round_9_key_reg8; 
        round_9_key_reg10 <= round_9_key_reg9; 
        round_9_key_reg11 <= round_9_key_reg10; 
        round_9_key_reg12 <= round_9_key_reg11; 
        round_9_key_reg13 <= round_9_key_reg12; 
        round_9_key_reg14 <= round_9_key_reg13; 
        round_9_key_reg15 <= round_9_key_reg14; 
        round_9_key_reg16 <= round_9_key_reg15; 
        round_9_key_reg17 <= round_9_key_reg16; 
        round_9_key_reg18 <= round_9_key_reg17; 

        //Round 10
        round_10_key_reg1 <= expanded_key_matrix[10];
        round_10_key_reg2 <= round_10_key_reg1; 
        round_10_key_reg3 <= round_10_key_reg2; 
        round_10_key_reg4 <= round_10_key_reg3; 
        round_10_key_reg5 <= round_10_key_reg4; 
        round_10_key_reg6 <= round_10_key_reg5; 
        round_10_key_reg7 <= round_10_key_reg6; 
        round_10_key_reg8 <= round_10_key_reg7; 
        round_10_key_reg9 <= round_10_key_reg8; 
        round_10_key_reg10 <= round_10_key_reg9; 
        round_10_key_reg11 <= round_10_key_reg10; 
        round_10_key_reg12 <= round_10_key_reg11; 
        round_10_key_reg13 <= round_10_key_reg12; 
        round_10_key_reg14 <= round_10_key_reg13; 
        round_10_key_reg15 <= round_10_key_reg14; 
        round_10_key_reg16 <= round_10_key_reg15; 
        round_10_key_reg17 <= round_10_key_reg16; 
        round_10_key_reg18 <= round_10_key_reg17; 
        round_10_key_reg19 <= round_10_key_reg18; 
        round_10_key_reg20 <= round_10_key_reg19; 

    end
end



endmodule
