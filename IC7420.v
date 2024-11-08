// The 7400-series integrated circuits are a series of digital chips with a few gates each. The 7420 is a chip with two 4-input NAND gates.
// Create a module with the same functionality as the 7420 chip. It has 8 inputs and 2 outputs.

module top_module ( 
    input p1a, p1b, p1c, p1d,
    output p1y,
    input p2a, p2b, p2c, p2d,
    output p2y );
    nand (p1y,p1a, p1b, p1c, p1d);
    nand (p2y,p2a, p2b, p2c, p2d);


endmodule
