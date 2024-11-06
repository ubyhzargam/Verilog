// Build a 4-digit BCD (binary-coded decimal) counter. Each decimal digit is encoded using 4 bits: q[3:0] is the ones digit, q[7:4] is the tens digit, etc. For digits [3:1], also 
// output an enable signal indicating when each of the upper three digits should be incremented.

module bcd(input clk, input reset, input en, output [3:0] q);
    always@(posedge clk)
        begin
            if(reset==1)
                q<=0;
            else if(en==1'b1)
                begin
                    if(q==4'd9)
                        q<=0;
                    else
                		q<=q+1;
                end
            else 
                q<=q;
        end
endmodule

module top_module (
    input clk,
    input reset,   
    output [3:1] ena,
    output reg [15:0] q);
    
    assign ena[1]=(q[3:0]==4'd9)?1:0;
    assign ena[2]=(q[7:4]==4'd9&&q[3:0]==4'd9)?1:0;
    assign ena[3]=(q[11:8]==4'd9&&q[7:4]==4'd9&&q[3:0]==4'd9)?1:0;
    
    bcd b0(clk, reset, 1,q[3:0]);
    bcd b1(clk, reset, ena[1],q[7:4]);
    bcd b2(clk, reset, ena[2],q[11:8]);
    bcd b3(clk, reset, ena[3],q[15:12]);

endmodule
