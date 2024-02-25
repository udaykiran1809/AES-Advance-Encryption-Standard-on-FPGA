module key_addition(input wire [127:0] key,
                    input wire [3:0] round,
                    output wire [127:0] new_key 
                    );

wire [31:0] RC_lookup [0:9];
                  
assign RC_lookup[4'h00] = 32'h01000000;
assign RC_lookup[4'h01] = 32'h02000000;
assign RC_lookup[4'h02] = 32'h04000000;
assign RC_lookup[4'h03] = 32'h08000000;
assign RC_lookup[4'h04] = 32'h10000000;
assign RC_lookup[4'h05] = 32'h20000000;
assign RC_lookup[4'h06] = 32'h40000000;
assign RC_lookup[4'h07] = 32'h80000000;
assign RC_lookup[4'h08] = 32'h1B000000;
assign RC_lookup[4'h09] = 32'h36000000;

wire [31:0] w3;
wire [31:0] tmp;

assign w3[31:0] = key[31:0];

SBox sbox0(w3[23:16], tmp[31:24]);
SBox sbox1(w3[15:8], tmp[23:16]);
SBox sbox2(w3[7:0], tmp[15:8]);
SBox sbox3(w3[31:24], tmp[7:0]);                   

assign new_key [127:96] = key[127:96] ^ tmp ^ RC_lookup[round];
assign new_key [95:64] = key[127:96] ^ tmp ^ RC_lookup[round] ^ key[95:64];
assign new_key [63:32] = key[127:96] ^ tmp ^ RC_lookup[round] ^ key[95:64] ^ key[63:32];
assign new_key [31:0] = key[127:96] ^ tmp ^ RC_lookup[round] ^ key[95:64] ^ key[63:32] ^ key[31:0];

endmodule
