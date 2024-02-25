`timescale 10ns / 1ps

module control_tb();


reg clk;
reg rst;
reg aes_en;
reg [7:0]uart_rxd;
wire [7:0]uart_txd;



controller a (clk, rst, aes_en, uart_txd, uart_rxd);



initial begin 
#0 clk<=0;
#0 rst<=1;
#0 aes_en<=0;
#0 uart_rxd<=0;
#10 rst<=0;
#0 aes_en<=1;
end 


always #5 clk<=~clk;



always begin
#10 uart_rxd <= 8'h61;
#10 uart_rxd<= 8'h62;
end




endmodule
