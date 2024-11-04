// JK flip flop 
module top_module (
    input clk,
    input j,
    input k,
    output Q); 
    always @(posedge clk)
        begin 
            case ({j,k})
                    2'b00:begin Q<=Q;end
                    2'b01:begin Q<=0;;end
                    2'b10:begin Q<=1;end
                    2'b11:begin Q<=~Q;end
                    default:Q<=0;
            endcase
        end

endmodule
