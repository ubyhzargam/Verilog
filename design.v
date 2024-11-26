// There is a room which has two doors one to
// enter and another to leave. There is a sensor in the corridor at the entrance and also at the
// exit. There is a bulb in the room which should turn off when there is no one inside the
// room. So imagine a black box with the inputs as the outputs of sensors. What should the
// black box be?

module top(input clk, input a, input b, input rst, output out);

reg [7:0] count;

initial
count=8'b00000000;

always@(posedge clk)
begin
if(rst)
count<=0;
else
begin
if(a&&b)
count<=count;
else if(a)
count<=count+1;
else if(b)
count<=count-1;
else
count<=count;
end
end

assign out=(count>0)?1:0;

endmodule
