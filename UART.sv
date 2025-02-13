`timescale 1ns / 1ps

module uart_top  //DESIGN TOP MODULE
#(
parameter clk_freq = 1000000,
parameter baud_rate = 9600
)
  (input clk, rst, 
  input rx,
  input [7:0] dintx,
  input newd,
  output tx, 
  output [7:0] doutrx,
  output donetx,
  output donerx
);

uarttx 
#(clk_freq, baud_rate) 
utx   
  (clk, rst, newd, dintx, tx, donetx);   //Check if transmitter is receiving correct value, create a golden value in test bench and compare it with actual value which is transmitted

uartrx 
#(clk_freq, baud_rate)
rtx
  (clk, rst, rx, donerx, doutrx);     // Check if receiver is receiving correct value in test bench by using some algorithm and generating a golden value to compare it with test value

endmodule


module uarttx // TRANSMITTER DESIGN CODE 
#(
parameter clk_freq = 1000000,
parameter baud_rate = 9600
)
(
input clk, rst,
input newd,
  input [7:0] tx_data, // Try and send all the data through transmitter by randomizing this variable
output reg tx,
output reg donetx
);

  localparam clkcount = (clk_freq/baud_rate); 
  
integer count = 0;
integer counts = 0;

reg uclk = 0; //Check toggle coverage

  typedef enum bit  {idle = 1'b0, transfer = 1'b1} state_t; //Check state coverage
state_t state;

  always@(posedge clk) 
begin
    if(count < clkcount/2)
        count <= count + 1;
    else begin
        count <= 0;
        uclk <= ~uclk; // Write an assertion to check if uclk toggles after every 104 main clock cycles as the main clock freq is 1MHz and the baud rate should be 9600 Hz
    end 
end

  reg [7:0] din;

always@(posedge uclk)
begin
    if(rst) 
    begin
        state <= idle; // Write an assertion to check if the state of transmitter is getting updated to idle state once rst goes high
    end
    else
    begin
        case(state)
            idle:
            begin
                counts <= 0;
                tx <= 1'b1;
                donetx <= 1'b0; // Write assertions to make sure donetx is 0, tx is 1 and counts is  0 in idle state 

                if(newd) 
                begin
                    state <= transfer; // Write assertion to check if the transmitter goes to transfer state when newd signal goes high 
                    din <= tx_data; //Write assertion to check if din is loaded with tx_data when newd goes high
                    tx <= 1'b0; // Write an assertion to check if the first bit transmitted that is tx is low when newd goes high because this will act as start bit for the receiving end 
                end
                else
                    state <= idle; //Write an assertion to make sure transmitter's state stays in idle if newd is not high and the present state is idle 
            end

            transfer: //Write an assertion to check if tx is one after exactly 8 'uclk' cycles of design entering transfer state because there is one stop bit after 8 data bits
            begin
              if(counts <= 7) begin 
                    counts <= counts + 1; //Write an assertion to make sure that counts never exceeds the value 8 because if it does then it is transmitting more than 8 data  bits.
                    tx <= din[counts];
                    state <= transfer; //Write an assertion to check if the transmitter stays in the same that is transfer state if counts value is 7 or less
                end
                else 
                begin
                    counts <= 0; //Write an assertion to check if counts is becoming 0 after all data bits have been sent
                    tx <= 1'b1;
                    state <= idle;
                    donetx <= 1'b1; // Write an assertion to check if donetx is going high after all 8 data bits have been transmitted and it should go high when stop bit is asserted on tx pin
                end
            end     
            default : state <= idle;

        endcase
    end
end

endmodule


module uartrx // RECEIVER DESIGN MODULE 
#(
parameter clk_freq = 1000000, 
parameter baud_rate = 9600
)
(
input clk,
input rst,
input rx,
output reg done,
output reg [7:0] rxdata
);

  localparam clkcount = (clk_freq/baud_rate);

integer count = 0;
integer counts = 0;

reg uclk = 0; //Check toggle coverage

  typedef enum bit  {idle = 1'b0, start = 1'b1} state_t; //Check state coverage
state_t state;

always@(posedge clk)
begin
    if(count < clkcount/2)
        count <= count + 1;
    else begin
        count <= 0;
        uclk <= ~uclk; // Write an assertion to check if uclk toggles after every 104 main clock cycles as the main clock freq is 1MHz and the baud rate should be 9600 Hz
    end 
    end 


always@(posedge uclk)
begin
    if(rst) 
    begin
        rxdata <= 8'h00; // Write assertions to check that rxdata , done and counts is 0 when rst is high
        counts <= 0;
        done <= 1'b0;
    end
    else
    begin
        case(state)

            idle : 
            begin
                rxdata <= 8'h00; // Write assertions to check that rxdata , done and counts is 0 when receiver is in idle state
                counts <= 0;
                done <= 1'b0;

              if(rx == 1'b0) // Write assertions to check if receiver goes to start state when rx is low and receiver is in idle state
                    state <= start;
                else
                    state <= idle;
            end

            start: 
            begin
              if(counts <= 7) // Write assertion to  make sure counts never exceeds the value 7
                begin
                    counts <= counts + 1;
                    rxdata <= {rx, rxdata[7:1]};
                end
                else
                begin
                    counts <= 0;
                    done <= 1'b1; // Write assertion to check that done is high after receiver receives 8 data bits.
                    state <= idle; // Write assertion to check that receiver goes to idle state once all the data bits are received
                  // Additionally, write an assertion to check if the data received on rx pin after 8 data bits is one to verify the UART protocol as there should be one stop bit after every 8 data bits 
                end
            end

            default : state <= idle;

        endcase
    end
end

endmodule


// A layered test bench architecture can be developed to verify the functional part of the design
// A verification checker can be designed to check for the assertions so that specification of the design is covered
