// The block diagram shown above has one input “IN” which is coming serially @
// clock, “CLK”. It has 4 outputs A, B,C & D . A will be 1 if IN has even number of 1’s &
// even number of 0’s. Similarly B will be 1 for even 1’s odd 0’s, C for odd 1’s even 0’s and
// D for both odd. Give the FSM required to design above block.

module fsm(input x, input clk, input rst, output reg A, output reg B, output reg C, output reg D);
reg [1:0] ps,ns;
parameter S0=2'b00,S1=2'b01,S2=2'b10,S3=2'b11;

initial begin ps=S0;ns=S0;end

always@(posedge clk)
begin
if(rst)
ps<=S0;
else
ps<=ns;
end

always @(ps or x)
begin
ns=S0;
case(ps)
S0: begin
    A=1;B=0;C=0;D=0;
    if(x==1)ns=S1;
    else ns=S2;
    end
S1: begin
    A=0;B=0;C=1;D=0;
    if(x==1)ns=S0;
    else ns=S3;
    end
S2: begin
    A=0;B=1;C=0;D=0;
    if(x==1)ns=S3;
    else ns=S0;
    end
S3: begin
    A=0;B=0;C=0;D=1;
    if(x==1)ns=S2;
    else ns=S1;
    end
default: begin
         ns=S0;
         A=0;B=0;C=0;D=0;
         end
endcase
end

endmodule

//Testbench

module tb();
reg clk, rst, x;
wire a,b,c,d;

fsm f(x, clk,  rst,  a, b,c,  d);

always #15 clk=~clk;

initial 
begin
clk=1'b0;
    x=1; #1$strobe($time," ",a,b,c,d);
#30 x=1;#1$strobe($time," ",a,b,c,d);
#30 x=0; #1$strobe($time," ",a,b,c,d);
#30 x=1; #1$strobe($time," ",a,b,c,d);
#30 x=0;#1$strobe($time," ",a,b,c,d);
#30 x=0; #1$strobe($time," ",a,b,c,d);
#30 x=0; #1$strobe($time," ",a,b,c,d);
#30 x=1; #1$strobe($time," ",a,b,c,d);
#30 x=1; #1$strobe($time," ",a,b,c,d);
#30 $strobe($time," ",a,b,c,d); 
end
endmodule

