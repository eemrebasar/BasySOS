`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/24/2016 06:31:25 PM
// Design Name: 
// Module Name: debounce
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

module debounce (input logic reset, clock, noisy, 
output logic clean);
   parameter DELAY = 270000;   // .01 sec with a 27Mhz clock

   reg [18:0] count;
   reg hell;

   always @(posedge clock)
     if (reset)
       begin
	  count <= 0;
	  hell <= noisy;
	  clean <= noisy;
       end
     else if (noisy != hell)
       begin
	  hell <= noisy;
	  count <= 0;
       end
     else if (count == DELAY)
       clean <= hell;
     else
       count <= count+1;
    

endmodule