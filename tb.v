// Write a testbench for this - https://hdlbits.01xz.net/wiki/Tb/tb2

module top_module();
	reg clk,in;
    reg [2:0] s;
    wire out;
    q7 q(clk,in,s,out);
    initial
        begin
            clk=1'b0;
            in=1'b0;
            s=3'd2;
            #10 s=3'd6;
            #10 s=3'd2; in=1'b1;
            #10 s=3'd7;in=1'b0;
            #10 s=3'd0;in=1'b1;
            #30 in=1'b0;
        end
    always #5 clk=~clk;
endmodule
