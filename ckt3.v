// Write a verilog code to model this simple circuit - https://hdlbits.01xz.net/wiki/Wire_decl


module top_module(
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n   ); 
    wire w1,w2;
    assign w1=a&b, w2=c&d;
    assign out=w1|w2;
    assign out_n=~out;

endmodule
