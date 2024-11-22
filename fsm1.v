// Draw the FSM for a Moore model in which the output is asserted 1 if A had the
// same value at each of the two previous clock ticks or B has been 1 since the last condition
// was true . Note that A & B both are inputs.
// Eg: A 0 0 1 1 0 0 1 0 1 1 0
// B 0 0 0 0 0 0 1 1 0 1 0
// O/P 0 1 0 1 0 1 1 1 0 1 0


module fsm(input x, input y, input clk, input rst,output reg z);

reg [1:0] ps,ns;
parameter S0=2'b00,S1=2'b01,S2=2'b10,S3=2'b11;

initial 
begin
ps=S0;
ns=S0;
end

always@(posedge clk)
begin
if(rst)
ps<=S0;
else
ps<=ns;
end

always@(x or y or ps)
begin
ns=0;
case(ps)
S0: begin
    ns=(x==1)?((y==1)?S2:S1):((y==1)?S1:S0);
    z=(x==1)?((y==1)?0:0):((y==1)?0:1);
    end
S1: begin
    ns=(x==1)?((y==1)?S3:S2):((y==1)?S2:S1);
    z=0;
    end
S2: begin
    ns=(x==1)?((y==1)?S0:S3):((y==1)?S3:S2);
    z=(x==1)?((y==1)?1:0):((y==1)?0:0);
    end
S3: begin
    ns=(x==1)?((y==1)?S1:S0):((y==1)?S0:S3);
    z=(x==1)?((y==1)?0:1):((y==1)?1:0);
    end
default : begin
          ns=S0;z=0;
          end
endcase
end
endmodule

// Test bench

module tb();
reg clk,rst,x,y;
wire z;

fsm f( x, y, clk,  rst, z);

always #15 clk=~clk;

initial begin
clk=1'b0;
y=1'b0;
x=1'b1; 
#30 x=1'b0; $strobe($time," ",z);
#30 x=1'b1; y=1'b1; $strobe($time," ",z);
#30 x=1'b0; $strobe($time," ",z);
#30 y=1'b0; $strobe($time," ",z);
#30 x=1'b0; y=1'b1; $strobe($time," ",z);
#30 x=1'b1; y=1'b0; $strobe($time," ",z);
#30 x=1'b1; y=1'b1; $strobe($time," ",z);
#30 $finish;
end
endmodule























    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
