`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/23/2016 09:46:52 PM
// Design Name: 
// Module Name: nextLetter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module nextLetter(input logic clk, input int i, input wire nextWord,output int o);



always@(posedge clk)
begin
if(nextWord == 1)
begin
o = i + 1;
end
else
o = o;
end



endmodule
