// FSM for serial 2's complement 

//Design
module test(input clk, input x,input rst, output reg y);
parameter S0=1'b0,S1=1'b1;
reg ps, ns;

initial 
begin ps<=S1;ns<=S1;end

always@(posedge clk)
begin
if(rst)
ps<=S1;
else
ps<=ns;
end

always@(x or ps)
begin
case(ps)
S0:begin
ns<=S0;
if(x)y<=0;
else y<=1;
end
S1:begin
if(x) begin y<=1;ns<=S0;end
else begin y<=0;ns<=S1;end
end
default : begin ns<=S1;y<=0;
end
endcase
end
endmodule

// Test bench

module tb();
reg clk, rst, x;
wire y;

test t(clk, x, rst, y);

always #3 clk = ~clk;

initial begin
clk=1'b0;rst=1'b1;x=1'b0;
#20 rst=1'b0;
#20 x=1'b0;#1$display($time," x= %d , rst = %d , ",x,rst,y);
#20 x=1'b0;#1$display($time," x= %d , rst = %d , ",x,rst,y);
#20 x=1'b0;#1$display($time," x= %d , rst = %d , ",x,rst,y);
#20 x=1'b1;#1$display($time," x= %d , rst = %d , ",x,rst,y);
#20 x=1'b1;#1$display($time," x= %d , rst = %d , ",x,rst,y);
end

endmodule
