module add_round_key #(parameter DATA_WIDTH=8)
(
    input clk,
    input bit [127:0] ip_data,
    input bit [127:0] ip_key,
    output bit [DATA_WIDTH-1:0] out[0:3][0:3]
);

bit [127:0] out_temp;

assign out_temp = ip_data ^ ip_key;   // 127^ 127


//TODO Can also be implemented without registers using assign statements

genvar i,j;

generate


    for(i=0; i< 4; i++)
    begin
        for(j=0; j<4; j++)
        begin
            always@(posedge clk)
            begin
                out[j][i] = out_temp[127- 32*i -8*j -: 8];
            end
        end
    end
endgenerate

endmodule
