// Use d flip flop to make JK flip flop 

module d(input d, input clk, input rst, output reg q);
initial q=0;
always@(posedge clk)
if(rst) q<=0;
else q<=d;
endmodule

module jk(input j, input k, input clk, input rst, output q);

wire w;

assign w=(j&(~q))|((~k)&q);

d d1(w,clk,rst,q);

endmodule


// Testbench
module tb();
reg j,k,clk,rst;
wire q;

jk j1(j,k,clk,rst,q);

always #5 clk=~clk;

initial
begin
j=0;k=0;rst=0;clk=0;
#3 j=1;
#10 k=1;
#10 j=0;
#10 k=0;j=1;
#10 j=0;rst=1;
#10 $finish;
end

initial
$monitor($time, " j= %d k= %d out = %b ",j,k,q);

endmodule
