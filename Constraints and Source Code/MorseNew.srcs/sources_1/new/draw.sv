`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/20/2016 03:20:16 PM
// Design Name: 
// Module Name: draw
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


module draw(input logic [9:0] xStart,[9:0] yStart,[9:0] xEnd,[9:0] yEnd,[11:0] color, [3:0]red,[3:0]blue,[3:0]green );

begin
    if (vc >= (vbp + yStart) && vc < (vbp + yEnd) && hc >= (hbp + xStart) && hc < (hbp + xEnd))
    begin
        red = color[3:0];
        green = color[7:4];
        blue = color[11:8];
    end
    if (!inDisplay)
    begin
        red = 0;
        green = 0;
        blue = 0;
    end
end
endfunction















endmodule
