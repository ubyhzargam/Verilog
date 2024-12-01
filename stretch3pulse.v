// Write a code to stretch the input pulse to last for 3 clock cycles more.

module stretch(input d, input clk, output q);
reg reg1,reg2,reg3;

initial begin 
reg1=0; reg2=0; reg3=0;
end

always@(posedge clk)
begin
reg1<=d;
reg2<=reg1;
reg3<=reg2;
end

assign q=(reg1|reg2|reg3);

endmodule

// Testbench

module tb();

reg d ,clk;
wire q;

stretch s(d,clk,q);

always #5 clk=~clk;

initial
begin
clk=0;
d=0;
#2 d=1;
#30 d=0;
#30 d=1;
#60 $finish;
end

initial
$monitor($time, " output = %d ",q);

endmodule
