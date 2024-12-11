// Given an 8-bit input vector [7:0], reverse its bit ordering.

module top_module( 
    input [7:0] in,
    output reg [7:0] out
);
    always @(*)
        for(int i=0;i<=7;i++)
            out[7-i]=in[i];

endmodule
