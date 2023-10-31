module tb_sub_bytes();

bit [DATA_WIDTH-1:0] in [3:0][3:0];
bit [DATA_WIDTH-1:0] out_sub_matrix [3:0][3:0];

sub_bytes inst_sub_bytes 
(
    .in(in),
    .out_sub_matrix(out_sub_matrix)
);


initial begin
end



//clock generator
always #5 clk=~clk;

    initial begin
        #500 $stop;
    end



endmodule
