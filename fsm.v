// Design a FSM to detect more than one 1s in the last 3 samples.
// Eg : I/P 0 1 0 1 0 1 1 0 0 1
// O/P 0 0 0 1 0 1 1 1 0 0

module fsm(input rst, input clk, input x, output reg y);

reg [1:0] ps,ns;
parameter S0='b00, S1=2'b01,S2=2'b10,S3=2'b11;

initial ps<=S0;

always@(posedge clk)
begin
if(rst)
ps<=S0;
else
ps<=ns;
end

always@(ps or x)
begin

case(ps)
S0: begin ns=(x==1)?S1:S0;
          y=0; end
S1: begin ns=(x==1)?S2:S3;
          y=(x==1)?1:0; end
S2: begin ns=(x==1)?S2:S3;
          y=1; end
S3: begin ns=(x==1)?S1:S0;
          y=(x==1)?1:0; end
default : begin ns=S0; y=0; end
endcase
end

endmodule

// Test bench

module tb();
reg clk, rst, x;
wire y;
fsm f0(rst,clk,x,y);

always begin #16 clk = ~clk; end

initial begin
clk=1'b0;
#30 rst=1'b0; 
#30 x=1'b0; #1$strobe($time, " rst = %b , x = %b , ",rst,x,y);
#30 x=1'b1; #1$strobe($time, " rst = %b , x = %b , ",rst,x,y);
#30 x=1'b0; #1$strobe($time, " rst = %b , x = %b , ",rst,x,y);
#30 x=1'b1; #1$strobe($time, " rst = %b , x = %b , ",rst,x,y);
#30 x=1'b0; #1$strobe($time, " rst = %b , x = %b , ",rst,x,y);
#30 x=1'b1; #1$strobe($time, " rst = %b , x = %b , ",rst,x,y);
#30 x=1'b1; #1$strobe($time, " rst = %b , x = %b , ",rst,x,y);
#30 x=1'b0; #1$strobe($time, " rst = %b , x = %b , ",rst,x,y);
#30 x=1'b0; #1$strobe($time, " rst = %b , x = %b , ",rst,x,y);
#30 x=1'b1; #1$strobe($time, " rst = %b , x = %b , ",rst,x,y);
#30 $finish;
end
endmodule
