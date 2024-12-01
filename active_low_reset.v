// This code asserts active low reset for 32 cycles whenever the input is assserted high. 

module reset_extend(input gen, input clk, output rst);

reg[31:0] d;

initial d=0;

always@(posedge clk)
begin
d[31]<=gen;
d[30:0]<=d[31:1];
end

assign rst=~(|d);

endmodule


// Testbench

module tb();
reg gen,clk;
wire rst;

reset_extend r(gen,clk,rst);

always #5 clk=~clk;

initial
begin
clk=0;
gen=0;
#2 gen=1;
#1000 gen=0;
#1000 gen=1;
#1000 $finish;
end

initial
$monitor($time, " Active low reset = %b ",rst);
endmodule
