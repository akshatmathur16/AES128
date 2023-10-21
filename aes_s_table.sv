module aes_s_table 
(
    input bit [3:0] row_num,
    input bit [3:0] col_num,
    output bit [7:0]aes_table_out
    

);

parameter DATA_WIDTH =8;

bit [DATA_WIDTH-1:0] aes_table[0:15][0:15];

// intializing aes table
// TODO make it in registers
initial begin
                   //0   //1  //2 //3   //4  //5  //6 //7  //8   //9  //10 //11 //12 //13 //14 //15
    aes_table[0]= {'h63,'h7C,'h77,'h7B,'hF2,'h6B,'h6F,'hC5,'h30,'h01,'h67,'h2B,'hFE,'hD7,'hAB,'h76}; 
    aes_table[1]= {'hCA,'h82,'hC9,'h7D,'hFA,'h59,'h47,'hF0,'hAD,'hD4,'hA2,'hAF,'h9C,'hA4,'h72,'hC0};
    aes_table[2]= {'hB7,'hFD,'h93,'h26,'h36,'h3F,'hF7,'hCC,'h34,'hA5,'hE5,'hF1,'h71,'hD8,'h31,'h15};
    aes_table[3]= {'h04,'hC7,'h23,'hC3,'h18,'h96,'h05,'h9A,'h07,'h12,'h80,'hE2,'hEB,'h27,'hB2,'h75};
    aes_table[4]= {'h09,'h83,'h2C,'h1A,'h1B,'h6E,'h5A,'hA0,'h52,'h3B,'hD6,'hB3,'h29,'hE3,'h2F,'h84};
    aes_table[5]= {'h53,'hD1,'h00,'hED,'h20,'hFC,'hB1,'h5B,'h6A,'hCB,'hBE,'h39,'h4A,'h4C,'h58,'hCF};
    aes_table[6]= {'hD0,'hEF,'hAA,'hFB,'h43,'h4D,'h33,'h85,'h45,'hF9,'h02,'h7F,'h50,'h3C,'h9F,'hA8};
    aes_table[7]= {'h51,'hA3,'h40,'h8F,'h92,'h9D,'h38,'hF5,'hBC,'hB6,'hDA,'h21,'h10,'hFF,'hF3,'hD2};
    aes_table[8]= {'hCD,'h0C,'h13,'hEC,'h5F,'h97,'h44,'h17,'hC4,'hA7,'h7E,'h3D,'h64,'h5D,'h19,'h73};
    aes_table[9]= {'h60,'h81,'h4F,'hDC,'h22,'h2A,'h90,'h88,'h46,'hEE,'hB8,'h14,'hDE,'h5E,'h0B,'hDB};
    aes_table[10]={'hE0,'h32,'h3A,'h0A,'h49,'h06,'h24,'h5C,'hC2,'hD3,'hAC,'h62,'h91,'h95,'hE4,'h79};   
    aes_table[11]={'hE7,'hC8,'h37,'h6D,'h8D,'hD5,'h4E,'hA9,'h6C,'h56,'hF4,'hEA,'h65,'h7A,'hAE,'h08};
    aes_table[12]={'hBA,'h78,'h25,'h2E,'h1C,'hA6,'hB4,'hC6,'hE8,'hDD,'h74,'h1F,'h4B,'hBD,'h8B,'h8A};
    aes_table[13]={'h70,'h3E,'hB5,'h66,'h48,'h03,'hF6,'h0E,'h61,'h35,'h57,'hB9,'h86,'hC1,'h1D,'h9E};
    aes_table[14]={'hE1,'hF8,'h98,'h11,'h69,'hD9,'h8E,'h94,'h9B,'h1E,'h87,'hE9,'hCE,'h55,'h28,'hDF};
    aes_table[15]={'h8C,'hA1,'h89,'h0D,'hBF,'hE6,'h42,'h68,'h41,'h99,'h2D,'h0F,'hB0,'h54,'hBB,'h16};

   $display("aes_table =%h",aes_table[0][3]);
end


assign aes_table_out = aes_table[row_num][col_num]; 

endmodule
