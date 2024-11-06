// Design a am-pm based clock, if output 'pm' =1 then it is PM else AM. If clock is reset, the clock should be set to 12:00:00 AM.

module bcd(input clk, input reset,input en,output reg [3:0] q);
    always@(posedge clk)
    begin
        if(reset)
            q<=0;
    	else if(en)
            begin
            	if(q==4'd9)
                	begin
                		q<=0;
               	 	end
   	 			else
                	begin
           				q<=q+1;
                	end
            end
    end
endmodule

module bcdh(input clk, input reset,input en,input ld,output reg [3:0] q);
    always@(posedge clk)
    begin
        if(reset)
            q<=2;
    	else if(en)
            begin
                if (ld)
                    q<=1;
            	else if(q==4'd9)
                	begin
                		q<=0;
               	 	end
   	 			else
                	begin
           				q<=q+1;
                	end
            end
    end
endmodule
            
module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss); 
    
    wire ens,enm,enh;
    
    wire enms,enhm;
    
    assign ens=(ss[3:0]==4'd9)?1'b1:1'b0;
    assign enms=(ss[7:4]==4'd5&&ss[3:0]==4'd9)?1:0;
    assign enm=(mm[3:0]==4'd9&&ss[7:4]==4'd5&&ss[3:0]==4'd9)?1:0;
    assign enhm=(ss[7:4]==4'd5&&ss[3:0]==4'd9&&mm[7:4]==4'd5&&mm[3:0]==4'd9)?1:0;
    assign enh=(hh[3:0]==4'd9&&mm[7:4]==4'd5&&mm[3:0]==4'd9&&ss[7:4]==4'd5&&ss[3:0]==4'd9)?1:0;
    
    wire rs,rm,rh,sh0;
    
    initial pm=0;
    
    assign rs=(ss[7:4]==4'd5&&ss[3:0]==4'd9||reset==1)?1:0;
    assign rm=(ss[7:4]==4'd5&&ss[3:0]==4'd9&&mm[7:4]==4'd5&&mm[3:0]==4'd9||reset==1)?1:0;
    assign sh0=(ss[7:4]==4'd5&&ss[3:0]==4'd9&&mm[7:4]==4'd5&&mm[3:0]==4'd9&&hh[7:4]==1&&hh[3:0]==4'd2)?1:0;
    assign rh=(ss[7:4]==4'd5&&ss[3:0]==4'd9&&mm[7:4]==4'd5&&mm[3:0]==4'd9&&hh[7:4]==1&&hh[3:0]==4'd2)?1:0;
	
    always @(posedge clk)
        begin
            if(reset)
                begin
                	pm<=0;
                end
            else if(ss[7:4]==4'd5&&ss[3:0]==4'd9&&mm[7:4]==4'd5&&mm[3:0]==4'd9&&hh[7:4]==1&&hh[3:0]==4'd1)
                pm<=~pm;
            else
                pm<=pm;
        end
    always @(posedge clk)
    	begin
            if(reset)
            	hh[7:4]<=1;
            else if(enh&&ena)
                hh[7:4]<=1;
            else if(rh)
                hh[7:4]<=0;
            else
                hh[7:4]<=hh[7:4];
        end
          
    bcd s0(clk,reset,ena,ss[3:0]);
    bcd s1(clk,rs,ens&&ena,ss[7:4]);
    bcd m0(clk,reset,enms&&ena,mm[3:0]);
    bcd m1(clk,rm,enm&&ena,mm[7:4]);
    bcdh h0(clk,reset,enhm&&ena,sh0,hh[3:0]);

endmodule
