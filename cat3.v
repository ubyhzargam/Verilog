// Implement this circuit - https://hdlbits.01xz.net/wiki/Exams/2014_q4a

module top_module (
    input clk,
    input w, R, E, L,
    output Q
);
    wire w1,w2;
    always@(*)
        begin
            w1=E?w:Q;
            w2=L?R:w1;
        end
    always@(posedge clk)
        begin
            Q<=w2;
        end

endmodule
