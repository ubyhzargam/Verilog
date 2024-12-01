// This code detects a positive edge on a signal using D flip flop. Assumption for correct working of the code is that the pulse width of the clock signal used // is not large enough and it toogles with high frequency. 

module posedg(input d, input clk, output reg q);

reg prev_inp;

initial q=0;

always@(posedge clk)
begin
if((d)&(~prev_inp)) q<=1;
else q<=0;
prev_inp<=d;
end

endmodule

// Testbench

module tb();
wire q;
reg d, clk;

posedg p(d,clk,q);

always #1 clk=~clk;

initial
begin
clk=0;
d=0;
#10 d=1;
#10 d=0;
#10 d=1;
#10 $finish;
end

initial
$monitor($time," Posedge pulse %d ", q);

endmodule
