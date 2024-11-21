// Design FSM for a pattern matching block : Output is asserted 1 if pattern “101” is
// detected in last 4 inputs.
// Eg: I/P 0 1 0 1 0 0 1 1 0 1 0 1 0
// O/P 0 0 0 1 1 0 0 0 0 1 1 1 1

module fsm(input clk, input rst, input x, output reg y);

   parameter [1:0] S0=2'b00,S1=2'b01,S2=2'b10,S3=2'b11;

reg [1:0] ps,ns;

initial
begin
ps<=S0;ns<=S0;
end

always@(posedge clk )
begin
if(rst==1)
begin
ps<=S0;
end
else
ps<=ns;
end

always@(ps or x )
begin
case(ps)
S0:if(x==0)begin y<=0;ns<=S0;end
   else begin y<=0;ns<=S1;end
S1:if(x==0)begin y<=0;ns<=S2;end
   else begin y<=0;ns<=S1;end
S2:if(x==0)begin y<=0;ns<=S0;end
   else begin y<=1;ns<=S3;end
S3:if(x==0)begin ns<=S2;y<=1;end
   else begin ns<=S1;y<=1;end
default:begin ns<=S0;y<=0;end
endcase
end
endmodule

// Testbench

module tb();
reg clk, rst, x;
wire y;
fsm f0(clk,rst,x,y);

always begin #2 clk = ~clk; end

initial begin
clk=1'b0;
x=1'b0;
#10 rst=1'b0; $strobe($time, " rst = %b , x = %b , ",rst,x,y);
#10 x=1'b0; $strobe($time, " rst = %b , x = %b , ",rst,x,y);
#10 x=1'b1; $strobe($time, " rst = %b , x = %b , ",rst,x,y);
#10 x=1'b0; $strobe($time, " rst = %b , x = %b , ",rst,x,y);
#10 x=1'b1; $strobe($time, " rst = %b , x = %b , ",rst,x,y);
#10 x=1'b0; $strobe($time, " rst = %b , x = %b , ",rst,x,y);
#10 x=1'b0; $strobe($time, " rst = %b , x = %b , ",rst,x,y);
#10 x=1'b1; $strobe($time, " rst = %b , x = %b , ",rst,x,y);
#10 x=1'b1; $strobe($time, " rst = %b , x = %b , ",rst,x,y);
#10 x=1'b0; $strobe($time, " rst = %b , x = %b , ",rst,x,y);
#10 x=1'b1; $strobe($time, " rst = %b , x = %b , ",rst,x,y);
#10 x=1'b0; $strobe($time, " rst = %b , x = %b , ",rst,x,y);
#10 x=1'b1; $strobe($time, " rst = %b , x = %b , ",rst,x,y);
#10 x=1'b0; $strobe($time, " rst = %b , x = %b , ",rst,x,y);
#10 $finish;
end
endmodule
