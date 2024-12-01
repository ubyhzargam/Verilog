// Creating a 3 bit counter from a 2 bit counter 

module count2(input clk, input rst, output reg [1:0]  q);

initial
q<=0;

always@(posedge clk)
begin
if(rst)
q<=0;
else
q<=q+1;
end

endmodule

module count3( input clk, input rst, output reg [2:0] q);

initial 
q<=0;

wire [1:0] w;

count2 c(clk,rst,w);

always@(posedge clk)
begin
if(rst)
q<=0;
else if(q[1]&q[0])
q<={~q[2],w};
else
q<={q[2],w};
end

endmodule


//Testbench

module tb();
wire [2:0] q;
reg clk,rst;

count3 c(clk,rst , q);

always #5 clk=~clk;

initial
begin
clk=0;
rst=0;
#50 rst=1;
#20 rst=0;
#20 $finish;
end

initial $monitor($time, " Count = %d ", q);

endmodule



