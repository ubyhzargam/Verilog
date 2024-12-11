// Write verilog code to implement this basic circuit - https://hdlbits.01xz.net/wiki/Vectorgates

module top_module( 
    input [2:0] a,
    input [2:0] b,
    output [2:0] out_or_bitwise,
    output out_or_logical,
    output [5:0] out_not
);
	assign out_or_bitwise=b|a;
    assign out_or_logical=a||b;
    assign out_not={~b,~a};
endmodule
