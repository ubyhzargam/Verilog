// Module A is supposed to implement the function z = (x^y) & x. Implement this module.

module top_module (input x, input y, output z);
    wire w;
    xor(w,x,y);
    and(z,w,x);
endmodule
