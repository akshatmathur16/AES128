module sub_bytes #(parameter DATA_WIDTH=8)
(
    input bit [DATA_WIDTH-1:0] in [0:3][0:3],
    output bit [DATA_WIDTH-1:0] out_sub_matrix [0:3][0:3]
);

genvar i,j;

generate
for(i=0; i< 4; i++)
begin
    for(j=0; j< 4; j++)
    begin
        aes_s_table inst_aes_s_table
        (
            .row_num(in[i][j][7:4]),
            .col_num(in[i][j][3:0]),
            .aes_table_out(out_sub_matrix[i][j])
        );


    end
end
endgenerate




endmodule
