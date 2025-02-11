// Simple UART protocol design code 

`timescale 1ns/1ps

module top 
  #(parameter clk_freq 1000000, parameter baud_rate 9600)
  (input clk,
   input rst,
   input rx,
   input newd,
   input [7:0] dintx,
   output reg donerx, donetx,
   output reg [7:0] doutrx,
   output reg tx);
  
  uarttx #(clk_freq,baud_rate) (clk, rst, newd, dintx, donetx, tx);
  uartrx #(clk_freq,baud_rate) (clk, rst, rx, donerx, doutrx);
  
endmodule 



module uarttx
  #(parameter clk_freq, parameter baud_rate)
  (input clk,rst,
   input newd,
   input [7:0] dintx,
   output reg donetx,
   output reg tx);
  
  enum {idle =1'b0, transfer = 1'b1} op;
  op state;
  
  int counts=0;
  int count=0;
  
  reg uclk;
  reg [7:0] din;
  
  localparam ratio=(clk_freq/baud_rate);
  
  always@(posedge clk)
    begin
      if(count<ratio/2)
        count<=count+1;
      else 
        begin
          count<=0;
          uclk<=~uclk;
        end
    end
  
  always@(posedge uclk)
    begin
      if(rst)
        begin
          state<=idle;
        end
      else
        case(state)
          idle : begin
            counts<=1'b0;
            tx<=1'b1;
            donetx<=1'b0;
            if(newd==1'b1)
            	 begin
                   din<=dintx;
                   tx<=1'b0;
                   state<=transfer;
                 end
          		 else
                     state<=idle;
                   end
            transfer : begin
              if(counts<=7)
               	begin
                  count<=count+1;
                  tx<=din[counts];
                  state<=transfer;
                end
              else
                begin
                state<=idle;
              	tx<=1'b1;
                donetx<=1'b1;
                end
            end
          
          default: begin
            state<=idle;
          end
        endcase
    end
endmodule



module uartrx
  #(parameter clk_freq, parameter baud_rate)
  (input clk, rst,
   input rx,
   output reg donerx,
   output reg [7:0] doutrx);
  
  int counts=0;
  int count=0;
  
  localparam ratio=(clk_freq/baud_rate);
  
  enum {idle=1'b0, receive =1'b1} op;
  op state;
  
  reg uclk;
  
  always@(posedge clk)
    begin
      if(count<ratio/2)
        count<=count+1;
      else
        begin
          count<=0;
          uclk<=~uclk;
        end
    end
  
  always @(posedge uclk)
    begin
      if(rst)
        begin
          state<=idle;
        end
      else
        case(state)
          idle : begin
            counts<=1'b0;
            doutrx<=8'b00000000;
            donerx<=1'b0;
            if(rx==1'b0)
              state<=receive;
            else
              state<=idle;
          end
          
          receive : begin
            if(counts<=7)
              begin
                doutrx<={rx,doutrx[7:1]};
                state<=receive;
              end
            else
              begin
                doutrx<=8'h00;
                state<=idle;
                donerx<=1'b1;
              end
          end
          
          default : state<=idle;
        endcase
    end
endmodule



interface uart_if;
  logic uclktx;
  logic uclkrx;
  logic clk;
  logic rst;
  logic rx;
  logic newd;
  logic [7:0] dintx;
  logic donetx;
  logic donerx;
  logic tx;
  logic [7:0] doutrx;
endinterface
              
                  
