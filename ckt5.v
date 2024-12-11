// Write a verilog code to implement this circuit - https://hdlbits.01xz.net/wiki/7458

module top_module ( 
    input p1a, p1b, p1c, p1d, p1e, p1f,
    output p1y,
    input p2a, p2b, p2c, p2d,
    output p2y );
    wire w1,w2,w3,w4;
    assign w1=p2a&p2b,w2=p2c&p2d,p2y=w1|w2;
    assign w3=p1a&p1b&p1c, w4=p1f&p1d&p1e, p1y=w3|w4;
endmodule
