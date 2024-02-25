//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2019 07:56:07 PM
// Design Name: 
// Module Name: rounds
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module rounds(
    input wire en,
    input wire [127:0] pt,
    input wire [127:0] key,
    output wire [127:0] ct
    );
        
    wire [3:0] round [0:9];    
    wire [127:0] r0_out, r1_out,r2_out,r3_out,r4_out,r5_out,r6_out,r7_out,r8_out,r9_out, r10_out;
    wire [127:0] keyout1,keyout2,keyout3,keyout4,keyout5,keyout6,keyout7,keyout8,keyout9,keyout10;
    wire [127:0] cttemp;
    
    key_addition k0(key, 4'd0, keyout1);
    key_addition k1(keyout1, 4'd1, keyout2);
    key_addition k2(keyout2, 4'd2, keyout3);
    key_addition k3(keyout3, 4'd3, keyout4);
    key_addition k4(keyout4, 4'd4, keyout5);
    key_addition k5(keyout5, 4'd5, keyout6);
    key_addition k6(keyout6, 4'd6, keyout7);
    key_addition k7(keyout7, 4'd7, keyout8);
    key_addition k8(keyout8, 4'd8, keyout9);
    key_addition k9(keyout9, 4'd9, keyout10);
    
    assign r0_out = pt ^ key;
    round r0(r0_out, keyout1, r1_out);
    round r1(r1_out, keyout2, r2_out);
    round r2(r2_out, keyout3, r3_out);
    round r3(r3_out, keyout4, r4_out);
    round r4(r4_out, keyout5, r5_out);
    round r5(r5_out, keyout6, r6_out);
    round r6(r6_out, keyout7, r7_out);
    round r7(r7_out, keyout8, r8_out);
    round r8(r8_out, keyout9, r9_out);
    final_round r9(r9_out, keyout10, r10_out);
    
    assign ct = (en) ? r10_out:pt;

   
    
    ////assign ct = pt;
    
endmodule

module round(
    input wire [127:0] pt,
    input wire [127:0] key,
    output wire [127:0] ct
    );

    wire [127:0] sbox_out;
    wire [127:0] sr_out;
    wire [127:0] mc_out;
    
    Bytesubstitution bs(pt, sbox_out);
    shiftrows shift(sbox_out, sr_out);
    mix_col mix(sr_out, mc_out);
    
    assign ct = mc_out ^ key;
    
endmodule

module final_round(
    input wire [127:0] pt,
    input wire [127:0] key,
    output wire [127:0] ct
    );

    wire [127:0] sbox_out;
    wire [127:0] sr_out;
    
    Bytesubstitution bs(pt, sbox_out);
    shiftrows shift(sbox_out, sr_out);
    
    assign ct = sr_out ^ key;
endmodule