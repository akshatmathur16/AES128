module shift_rows #(parameter DATA_WIDTH=8)
(

    input bit [DATA_WIDTH-1:0] ip_matrix [0:3][0:3],
    output bit [DATA_WIDTH-1:0] out_shift_matrix [0:3][0:3]
);

assign out_shift_matrix[0] = {ip_matrix[0][0],ip_matrix[0][1], ip_matrix[0][2], ip_matrix[0][3]};
assign out_shift_matrix[1] = {ip_matrix[1][1],ip_matrix[1][2], ip_matrix[1][3], ip_matrix[1][0]};
assign out_shift_matrix[2] = {ip_matrix[2][2],ip_matrix[2][3], ip_matrix[2][0], ip_matrix[2][1]};
assign out_shift_matrix[3] = {ip_matrix[3][3],ip_matrix[3][0], ip_matrix[3][1], ip_matrix[3][2]};



endmodule
