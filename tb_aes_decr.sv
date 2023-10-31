module tb_aes_decr();


parameter DATA_WIDTH=8;

bit clk;
bit [127:0] ip_data;
bit [127:0] ip_key;
bit [DATA_WIDTH-1:0] out[0:3][0:3];
bit [DATA_WIDTH-1:0] out_temp[0:3][0:3];
bit [DATA_WIDTH-1:0] out_sub_matrix [0:3][0:3];
bit [DATA_WIDTH-1:0] out_shift_matrix [0:3][0:3];
bit [127:0] mix_col_out_data;
bit [127:0] decr_data_out;

bit [127:0] key_out[0:10];

aes_decr inst_aes_decr
(
    .clk(clk), 
    .rst(rst),
    .ip_data(ip_data),
    .ip_key(ip_key),
    .decr_data_out(decr_data_out)
);

initial begin
    //#3 ip_data = 128'h5D_6F_56_A3_34_37_9D_CD_02_16_0A_24_B9_8E_A2_2D; ; ip_key = 128'hFE_65_78_97_FF_EA_56_76_45_AE_DE_CD_56_89_12_67;
    #3 ip_data = 128'h90_F4_2A_00_17_49_E5_12_F4_D9_48_F8_70_DA_50_0E; ; ip_key = 128'hFE_65_79_7F_FE_A5_67_64_5A_ED_EC_D5_68_91_26_07;
    #10 ip_data = 128'h71f1fb726c8f65a86fc5323d0480f79e; ip_key = 128'hAA_BB_78_17_FF_EA_C6_76_E5_AE_DE_AD_B6_89_19_8F;
    //#10 ip_data = 128'hDF_EE_56_56_78_24_ED_DC_BC_65_77_B7_FF_EA_06_8A; ip_key = 128'hAA_BB_78_1E_FF_EA_C6_36_E5_3E_9E_A0_B6_89_19_8F;

//    #3 ip_data = 128'hAE_FE_D6_75_89_AF_ED_FC_AE_65_78_77_FF_EA_86_76; ip_key = 128'hFE_65_78_97_FF_EA_56_76_45_AE_DE_CD_56_89_12_67;
    //#10 ip_data = 128'h45_AE_DE_CD_56_89_12_67_AE_FE_D6_75_89_AF_ED_FC; ip_key =128'hAE_65_78_77_FF_EA_86_76_AE_FE_D6_75_89_AF_ED_FC ;

end



//clock generator
always #5 clk=~clk;

    initial begin
        #50000 $stop;
    end



endmodule
