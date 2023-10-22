module inv_aes_s_table 
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
           aes_table[0]   = {'h52,'h09,'h6a,'hd5,'h30,'h36,'ha5,'h38,'hbf,'h40,'ha3,'h9e,'h81,'hf3,'hd7,'hfb};
           aes_table[1]   = {'h7c,'he3,'h39,'h82,'h9b,'h2f,'hff,'h87,'h34,'h8e,'h43,'h44,'hc4,'hde,'he9,'hcb};
           aes_table[2]   = {'h54,'h7b,'h94,'h32,'ha6,'hc2,'h23,'h3d,'hee,'h4c,'h95,'h0b,'h42,'hfa,'hc3,'h4e};
           aes_table[3]   = {'h08,'h2e,'ha1,'h66,'h28,'hd9,'h24,'hb2,'h76,'h5b,'ha2,'h49,'h6d,'h8b,'hd1,'h25};
           aes_table[4]   = {'h72,'hf8,'hf6,'h64,'h86,'h68,'h98,'h16,'hd4,'ha4,'h5c,'hcc,'h5d,'h65,'hb6,'h92};
           aes_table[5]   = {'h6c,'h70,'h48,'h50,'hfd,'hed,'hb9,'hda,'h5e,'h15,'h46,'h57,'ha7,'h8d,'h9d,'h84};
           aes_table[6]   = {'h90,'hd8,'hab,'h00,'h8c,'hbc,'hd3,'h0a,'hf7,'he4,'h58,'h05,'hb8,'hb3,'h45,'h06};
           aes_table[7]   = {'hd0,'h2c,'h1e,'h8f,'hca,'h3f,'h0f,'h02,'hc1,'haf,'hbd,'h03,'h01,'h13,'h8a,'h6b};
           aes_table[8]   = {'h3a,'h91,'h11,'h41,'h4f,'h67,'hdc,'hea,'h97,'hf2,'hcf,'hce,'hf0,'hb4,'he6,'h73};
           aes_table[9]   = {'h96,'hac,'h74,'h22,'he7,'had,'h35,'h85,'he2,'hf9,'h37,'he8,'h1c,'h75,'hdf,'h6e};
           aes_table[10]  = {'h47,'hf1,'h1a,'h71,'h1d,'h29,'hc5,'h89,'h6f,'hb7,'h62,'h0e,'haa,'h18,'hbe,'h1b};
           aes_table[11]  = {'hfc,'h56,'h3e,'h4b,'hc6,'hd2,'h79,'h20,'h9a,'hdb,'hc0,'hfe,'h78,'hcd,'h5a,'hf4};
           aes_table[12]  = {'h1f,'hdd,'ha8,'h33,'h88,'h07,'hc7,'h31,'hb1,'h12,'h10,'h59,'h27,'h80,'hec,'h5f};
           aes_table[13]  = {'h60,'h51,'h7f,'ha9,'h19,'hb5,'h4a,'h0d,'h2d,'he5,'h7a,'h9f,'h93,'hc9,'h9c,'hef};
           aes_table[14]  = {'ha0,'he0,'h3b,'h4d,'hae,'h2a,'hf5,'hb0,'hc8,'heb,'hbb,'h3c,'h83,'h53,'h99,'h61};
           aes_table[15]  = {'h17,'h2b,'h04,'h7e,'hba,'h77,'hd6,'h26,'he1,'h69,'h14,'h63,'h55,'h21,'h0c,'h7d};


end

assign aes_table_out = aes_table[row_num][col_num]; 

endmodule
