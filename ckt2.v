// Implement this circuit - https://hdlbits.01xz.net/wiki/Mt2015_muxdff
module top_module (
	input clk,
	input L,
	input r_in,
	input q_in,
	output reg Q);
    wire w;
    always @(*)
        begin
            w=L?r_in:q_in;
        end
    always@(posedge clk)
        begin
            Q<=w;
        end

endmodule

