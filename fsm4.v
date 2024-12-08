// This code implements the following fsm - https://hdlbits.01xz.net/wiki/Fsm1

module top_module(
    input clk,
    input areset,    
    input in,
    output reg out); 

    initial 
    state<=B;
    
    parameter A=0, B=1; 
    reg state, next_state;

    always @(*) begin    
        case(state)
            A: begin out=1'b0; if(in) begin next_state=A; end
                else begin next_state=B; end end
            B: begin out=1'b1; if(in) begin next_state=B; end
                else begin next_state=A; end end
        endcase
    end

    always @(posedge clk, posedge areset) begin   
        if(areset) state<=B;
        else
            state<=next_state;
    end

endmodule

// Testbench

module test;

wire out;
reg clk,areset, in;

top_module t(clk,areset,in,out);

always #5 clk=~clk;

initial begin
clk=1'b0;
areset=1'b0;
in=1'b0;
#6; in=1'b1;
#10; in=1'b0;
#10; in=1'b1;
#10 areset=1;
#20 $finish;
end

initial $monitor($time," ",areset," ",in," ",out);

endmodule









