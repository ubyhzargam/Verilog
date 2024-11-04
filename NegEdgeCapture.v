//For each bit in a 32-bit vector, capture when the input signal changes from 1 in one clock cycle to 0 the next. "Capture" means that the output will remain 1 until the register is reset (synchronous reset).
//Each output bit behaves like a SR flip-flop: The output bit should be set (to 1) the cycle after a 1 to 0 transition occurs. The output bit should be reset (to 0) at the positive clock edge when reset is high. If both of the above events occur at the same time, reset has precedence.

module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output [31:0] reg out
);
    reg [31:0] temp;
    always@(posedge clk)
        begin
            if(reset)
                out<=0;
            else 
                begin
                    out<=out|(temp&~in);
                end
                    temp<=in;
        end

endmodule
