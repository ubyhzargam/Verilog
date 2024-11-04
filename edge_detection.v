// For each bit in an 8-bit vector, detect when the input signal changes from one clock cycle to the next (detect any edge). The output bit should be set the cycle after a 0 to 1 
// transition occurs.
module top_module (
    input clk,
    input [7:0] in,
    output [7:0] anyedge
);
    initial
        begin
            temp=0;
            anyedge=0;
        end
    reg [7:0] temp;
    always@(posedge clk)
        begin
            anyedge<=(~temp&in)|(temp&~in);
            temp<=in;
        end
endmodule
