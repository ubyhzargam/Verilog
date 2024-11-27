// You are given the following AND gate you wish to test:
// module andgate (
//    input [1:0] in,
//    output out
// );
// Write a testbench that instantiates this AND gate and tests all 4 input combinations, by generating the following timing diagram: 
// https://hdlbits.01xz.net/wiki/Tb/and

module top_module();
	wire out;
    reg [1:0] in;
    andgate a(in,out);
    integer i;
    initial
        begin
            in=0;
            for(i=1;i<=3;i++)
                begin
                #10 in=i;
                end
        end
endmodule
