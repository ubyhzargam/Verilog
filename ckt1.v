// implement circuit mentioned in this link - https://hdlbits.01xz.net/wiki/Exams/m2014_q4d
module top_module (
    input clk,
    input in, 
    output out);
    wire xout;
    assign xout=in^out;
    always@(posedge clk)
        begin
            out<=xout;
        end

endmodule
