module mix_single_col
(
	input [31:0] in, 
	output [31:0] out
);

	wire [7:0] b0, b1, b2, b3;
	wire [7:0] c0, c1, c2, c3;

	function [7:0] mult_2;
		input [7:0] x;
		begin
			mult_2 = {x[6], x[5], x[4], x[3]^x[7], x[2]^x[7], x[1], x[0]^x[7], x[7]};
		end
	endfunction

	function [7:0] mult_3;
		input [7:0] x;
		begin
			mult_3 = mult_2(x) ^ x;
		end
	endfunction

	assign {b0, b1, b2, b3} = in;

	assign c0 = mult_2(b0) ^ mult_3(b1) ^ b2 ^ b3;
	assign c1 = b0 ^ mult_2(b1) ^ mult_3(b2) ^ b3;
	assign c2 = b0 ^ b1 ^ mult_2(b2) ^ mult_3(b3);
	assign c3 = mult_3(b0) ^ b1 ^ b2 ^ mult_2(b3);

	assign out = {c0, c1, c2, c3};

endmodule

module mix_col
(
	input [127:0] in,
	output [127:0] out
);

	genvar i;
	generate
	    for (i=0; i<4; i=i+1)
	    begin : msc
	       mix_single_col m(.in(in[32*i+31:32*i]), .out(out[32*i+31:32*i]));
	    end
	endgenerate

endmodule
