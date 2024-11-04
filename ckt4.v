// Implement this circuit - https://hdlbits.01xz.net/wiki/Exams/ece241_2014_q4
module dfff(input d, input clk, output reg q, output reg qbar);
    always@(posedge clk)
        begin
        q<=d;
        end
    initial 
        begin
            q<=0;
        end
    assign qbar=~q;
endmodule
module top_module (
    input clk,
    input x,
    output z
); 
    wire w1,w2,w3;
    reg r1,r2,r3;
    reg r1bar,r2bar,r3bar; 
    assign w1=x^r1;
    assign w2=x&(r2bar);
    assign w3=x|(r3bar);      
    dfff d0(w1,clk,r1,r1bar);
    dfff d1(w2,clk,r2,r2bar);
    dfff d2(w3,clk,r3,r3bar);
    assign z=~(r1|r2|r3);
endmodule
