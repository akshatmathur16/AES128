module tb_aes_encr();


parameter DATA_WIDTH=8;

bit clk;
bit [127:0] ip_data;
bit [127:0] ip_key;
bit [DATA_WIDTH-1:0] out[0:3][0:3];
bit [DATA_WIDTH-1:0] out_temp[0:3][0:3];
bit [DATA_WIDTH-1:0] out_sub_matrix [0:3][0:3];
bit [DATA_WIDTH-1:0] out_shift_matrix [0:3][0:3];
bit [127:0] mix_col_out_data;
bit [127:0] encr_data_out;

bit [127:0] key_out[0:10];

aes_encr inst_aes_encr
(
    .clk(clk), 
    .rst(rst),
    .ip_data(ip_data),
    .ip_key(ip_key),
    .encr_data_out(encr_data_out)
);




/*
key_expand inst_key_expand
(
    .key(ip_key),
    .key_out(key_out) 
);

add_round_key inst_add_round_key 
(
    .clk(clk),
    .ip_data(ip_data),
    .ip_key(key_out),
    .out(out)
);
assign out_temp = out;

sub_bytes inst_sub_bytes 
(
    .in(out_temp),
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
*/

initial begin

    #3 ip_data = 128'hAE_FE_D6_75_89_AF_ED_FC_AE_65_78_77_FF_EA_86_76; ip_key = 128'hFE_65_78_97_FF_EA_56_76_45_AE_DE_CD_56_89_12_67;
    //#10 ip_data = 128'h45_AE_DE_CD_56_89_12_67_AE_FE_D6_75_89_AF_ED_FC; ip_key =128'hAE_65_78_77_FF_EA_86_76_AE_FE_D6_75_89_AF_ED_FC ;

end





//clock generator
always #5 clk=~clk;

    initial begin
        #50000 $stop;
    end



endmodule
