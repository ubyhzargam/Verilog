// A "population count" circuit counts the number of '1's in an input vector. Build a population count circuit for a 3-bit input vector.

module top_module( 
    input [2:0] in,
    output [1:0] out );
    
    integer i, count;
    
        always@(in)
        begin
            count=0;
            for(i=0;i<=2;i++)
                begin
                    if((in>>i)&1'b1==1) count=count+1;
                end
        end
        
        assign out =count[1:0];

endmodule
