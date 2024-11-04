// 8 bit d flip flop with synchronus reset
module top_module (
    input clk,
    input reset,           
    input [7:0] d,
    output reg [7:0] q
);
    always @(posedge clk)
        begin
            if(reset==1'b1)
                q<=0;
            else
                q<=d;
                end
endmodule
