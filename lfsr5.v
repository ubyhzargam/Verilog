// A linear feedback shift register is a shift register usually with a few XOR gates to produce the next state of the shift register. A Galois LFSR is one particular arrangement where // bit positions with a "tap" are XORed with the output bit to produce its next value, while bit positions without a tap shift. If the taps positions are carefully chosen, the LFSR can // be made to be "maximum-length". A maximum-length LFSR of n bits cycles through 2n-1 states before repeating (the all-zero state is never reached).
// The following diagram shows a 5-bit maximal-length Galois LFSR with taps at bit positions 5 and 3. (Tap positions are usually numbered starting from 1). Note that I drew the XOR 
// gate at position 5 for consistency, but one of the XOR gate inputs is 0.


module df(input d,input clk, input reset,output reg q);
    always@(posedge clk)
        begin
            if(reset)
                q<=0;
            else
                q<=d;
        end
endmodule

module df1(input d,input clk, input reset,output reg q);
    always@(posedge clk)
        begin
            if(reset)
                q<=1;
            else
                q<=d;
        end
endmodule

module top_module(
    input clk,
    input reset,    
    output reg [4:0] q
); 
    wire a,b;
    assign a=q[0]^1'b0,
        b=q[0]^q[3];
    
    df d4(a,clk,reset,q[4]);
    df d3(q[4],clk,reset,q[3]);
    df d2(b,clk,reset,q[2]);
    df d1(q[2],clk,reset,q[1]);
    df1 d0(q[1],clk,reset,q[0]);
    
endmodule
