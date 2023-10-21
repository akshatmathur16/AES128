module key_expand
(
    input bit [127:0] key,
    output bit [127:0] key_out[0:10] 
);

bit [31:0] word [0:43];
bit [7:0] aes_table_out[3:0];

// words for initializtion step of add round key
assign     word[0] = key[127:96];
assign     word[1] = key[95:64];
assign     word[2] = key[63:32];
assign     word[3] = key[31:0];

xor_module inst_xor_module_1(.inp(word[0:3]),   .rot_val(4'd1), .outp(word[4:7]));
xor_module inst_xor_module_2(.inp(word[4:7]),   .rot_val(4'd2), .outp(word[8:11]));
xor_module inst_xor_module_3(.inp(word[8:11]),  .rot_val(4'd3), .outp(word[12:15]));
xor_module inst_xor_module_4(.inp(word[12:15]), .rot_val(4'd4), .outp(word[16:19]));
xor_module inst_xor_module_5(.inp(word[16:19]), .rot_val(4'd5), .outp(word[20:23]));
xor_module inst_xor_module_6(.inp(word[20:23]), .rot_val(4'd6), .outp(word[24:27]));
xor_module inst_xor_module_7(.inp(word[24:27]), .rot_val(4'd7), .outp(word[28:31]));
xor_module inst_xor_module_8(.inp(word[28:31]), .rot_val(4'd8), .outp(word[32:35]));
xor_module inst_xor_module_9(.inp(word[32:35]), .rot_val(4'd9), .outp(word[36:39]));
xor_module inst_xor_module_10(.inp(word[36:39]),.rot_val(4'd10), .outp(word[40:43]));



assign key_out[0] = {word[0], word[1], word[2], word[3]};
assign key_out[1] = {word[4], word[5], word[6], word[7]};
assign key_out[2] = {word[8], word[9], word[10], word[11]};
assign key_out[3] = {word[12], word[13], word[14], word[15]};
assign key_out[4] = {word[16], word[17], word[18], word[19]};
assign key_out[5] = {word[20], word[21], word[22], word[23]};
assign key_out[6] = {word[24], word[25], word[26], word[27]};
assign key_out[7] = {word[28], word[29], word[30], word[31]};
assign key_out[8] = {word[32], word[33], word[34], word[35]};
assign key_out[9] = {word[36], word[37], word[38], word[39]};
assign key_out[10] = {word[40], word[41], word[42], word[43]};


endmodule




module xor_module
(
    input bit [31:0] inp[0:3],
    input bit [3:0] rot_val,
    output bit [31:0] outp[0:3]
);

bit [31:0] wOutTemp[0:3];
bit [31:0] wTemp;

g g_inst
(
    .w_in(inp[3]),
    .rot_val(rot_val),
    .w_out(wTemp)
);


    assign wOutTemp[0] = wTemp ^ inp[0];
    assign wOutTemp[1] = inp[1] ^ wOutTemp[0];
    assign wOutTemp[2] = inp[2] ^ wOutTemp[1];
    assign wOutTemp[3] = inp[3] ^ wOutTemp[2]; 

    assign outp = wOutTemp;

endmodule

module g
    (
        input bit [31:0] w_in,
        input bit [3:0] rot_val,
        output bit[31:0] w_out
    );

    bit [31:0] aes_table_out;
    bit [7:0] rc_val_out;



    assign rc_val_out =  rc_val(rot_val);

    //32b = 32b ^ 32b 
    assign w_out = aes_table_out ^ {rc_val_out,24'b0};


    //w_in = {B[31:24], B[23:16], B{15:8}, B[7:0]}

    //circular shifting w_in
    //circ_shift_reg = {w_in[23:16], w_in[15:8], w_in[7:0], w_in[31:24]};

    initial begin

    $monitor($time,"w_in[23:20] =row_num = %h,w_in[19:16] =col_num = %h ", w_in[23:20], w_in[19:16]);
end

    //Byte wise access
    //w_inp[23:16]
    aes_s_table inst_aes_table_1
    (
        .row_num(w_in[23:20]),
        .col_num(w_in[19:16]),
        .aes_table_out(aes_table_out[31:24])
    );
    //w_in[15:8]
    aes_s_table inst_aes_table_2
    (
        .row_num(w_in[15:12]),
        .col_num(w_in[11:8]),
        .aes_table_out(aes_table_out[23:16])
    );
    //w_in[7:0]
    aes_s_table inst_aes_table_3
    (
        .row_num(w_in[7:4]), 
        .col_num(w_in[3:0]),
        .aes_table_out(aes_table_out[15:8])
    );
    //w_in[31:24]
    aes_s_table inst_aes_table_4
    (
        .row_num(w_in[31:28]), 
        .col_num(w_in[27:24]),
        .aes_table_out(aes_table_out[7:0])
    );

    



    function bit [7:0] rc_val(bit [3:0] rot_num);

        case(rot_num)
            4'd1: rc_val=8'h01;
            4'd2: rc_val=8'h02;
            4'd3: rc_val=8'h04;
            4'd4: rc_val=8'h08;
            4'd5: rc_val=8'h10;
            4'd6: rc_val=8'h20;
            4'd7: rc_val=8'h40;
            4'd8: rc_val=8'h80;
            4'd9: rc_val=8'h1B;
            4'd10: rc_val=8'h36;
            default: rc_val = 8'h00;
        endcase

    endfunction

endmodule
