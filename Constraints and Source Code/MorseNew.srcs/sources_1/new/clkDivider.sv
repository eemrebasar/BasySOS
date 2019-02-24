`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/23/2016 06:29:47 PM
// Design Name: 
// Module Name: clkDivider
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


module clkDivider(input int border, input logic clk, output logic clk_out);

          int count ;
          always @(posedge clk)
          begin        
               count <= count +1;   
          if(count == border)
          count <= 0;        
          if ( count == 0)
          clk_out <= 1'b1;        
          else
          clk_out <= 1'b0;        
          end
endmodule      