module aescore(input clk,
                input rst,
                input aes_en,
                input [127:0] key,
               input [127:0] plaintext,
               input din_valid,
               output [127:0] ciphertext,
               output dout_valid);

(* DONT_TOUCH = "true" *) reg [8:0] shift;

//rounds AES_rounds(clk, rst, aes_en, plaintext, key, ciphertext);
assign ciphertext = plaintext;

assign dout_valid = shift[8];

always @(posedge clk, posedge rst) begin
	if (rst) begin
		shift <= 9'b000000000;
	end
	else begin
		shift <= shift << 1;
		shift[0] <= din_valid;
	end
end

endmodule
