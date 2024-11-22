// Design a synchronous sequential circuit using minimum number of DFFs and a 4:1
// Mux to check the highest number of ones and zeros in the last 3 input samples. The
// design should give 1 at the output if the last 3 samples at the input has more number of
// 1’s similarly than the number of zeros. Only one clock is available and the input is
// sampled at clock rate only.
// Eg:
// IN : 001110110000
// OUT: 0111111000

module dff(input clk, input rst, input d, output reg q);

always@(posedge clk)
begin
if(rst)q<=0;
else
q<=d;
end

endmodule

module mux4to1(input [1:0] s, input [3:0] i, output y);

assign y=i[s];

endmodule

module top(input x, input clk, input rst, output y);

wire w,w1;

dff d0(clk,rst,x,w);
dff d1(clk,rst,w,w1);

mux4to1 m0({w,w1},{1'b1,x,x,1'b0},y);

endmodule

// Testbench

module tb();
reg clk,rst,x;
wire y;

top t(x,clk,rst,y);

always #5 clk=~clk;

initial
begin 
clk=1'b0;
rst=1'b1;
#1 rst=1'b0; 
#1 x=1'b0;
#10 x=1'b0; 
#10 x=1'b1; $strobe($time," ", y);
#10 x=1'b1; $strobe($time," ", y);
#10 x=1'b1; $strobe($time," ", y);
#10 x=1'b0; $strobe($time," ", y);
#10 x=1'b1; $strobe($time," ", y);
#10 x=1'b1; $strobe($time," ", y);
#10 x=1'b0; $strobe($time," ", y);
#10 x=1'b0; $strobe($time," ", y);
#10 x=1'b0; $strobe($time," ", y);
#10 x=1'b0; $strobe($time," ", y);
end
endmodule
