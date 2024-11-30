// Build a counter that counts from 0 to 999, inclusive, with a period of 1000 cycles. The reset input is synchronous, and should reset the counter to 0.

module top_module (
    input clk,
    input reset,
    output reg [9:0] q);
    
    always@(posedge clk)
        begin
            if(reset||q==10'd999)
                q<=0;
			else
                q<=q+1;
        end
    
endmodule
