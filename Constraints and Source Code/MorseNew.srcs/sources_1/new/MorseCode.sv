`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/17/2016 04:06:28 PM
// Design Name: 
// Module Name: morseCode
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


module MorseCode( input logic clk,clr,input wire dot, input wire dash, input wire nextWord,
                output logic hsync,
                output logic vsync,
                output logic [3:0] red,
                output logic [3:0] green,
                output logic [3:0] blue,
                output logic c);
logic [9:0] hc;
logic [9:0] vc;
logic [1:0] pxclk;
logic inH = (hc < 640);
logic inV = (vc < 480);
logic inDisplay = inH && inV;
parameter hpixels = 800;
parameter vlines = 521;
parameter hpulse = 96;
parameter vpulse = 2;
parameter hbp = 144;
parameter hfp = 784;
parameter vbp = 31;
parameter vfp = 511;
logic [4:0] harf;
logic [4:0] sentence[11];
logic [3:0] i;
assign c = a;
int counterX = 0;
logic pa,pb,pc;

/*
 clk_wiz_0 wiz
  (
 // Clock in ports
  .clk_in1(clk),
  // Clock out ports  
  .clk_out1(clk_out1),
  // Status and control signals               
  .reset(reset), 
  .locked(locked)            
  );
*/
always @ (posedge clk)
 pxclk = pxclk + 1;

logic pclk;
logic clk_out;
assign pclk = pxclk[1];
debounce buta(clr,clk,dot,pa);
debounce butb(clr,clk,dash,pb);
debounce butc(clr,clk,nextWord,pc);


initial begin
  for(int k=0; k<10; k++) begin
    sentence[k] = 6'b000000 ;
  end
 counterX=150;
 end


//clkDivider vgaClock(4,clk,pclk);
clkDivider newClk(8000000,clk,clk_out);
FSM deneme(clk_out,clr,pa,pb,pc,harf,a);

always @(posedge a)
begin
if(i<11)
i = i + 1;
end


always @ (posedge pclk)
begin
//	if (clr == 1)
//	begin
//		hc <= 0;
//		vc <= 0;
//	end
//	else
	//begin
		if (hc < hpixels - 1)
			hc <= hc + 1;
		else
		begin
			hc <= 0;
			if (vc < vlines - 1)
				vc <= vc + 1;
			else
				vc <= 0;
		end
	//end
end

assign hsync = (hc < hpulse) ? 0:1;
assign vsync = (vc < vpulse) ? 0:1;

always  @(*)
begin   
    if (vc >= vbp & vc < vfp & hc >= hbp & hc < hfp)
	begin
     sentence[i] = harf;  
     counterX = 0;
     for(int j = 0; j<11; j++)
     begin
     bok(sentence[j],150 + counterX,200);
	 counterX = counterX+30;
	 end
	 
	end
	if (!inDisplay)
    begin
        red = 0;
        green = 0;
        blue = 0;
    end
end




function bit draw(input logic [9:0]xStart, [9:0]yStart, [9:0]xEnd, [9:0]yEnd,[11:0]color);
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


function bit bok(input logic [5:0]charVal,[9:0]x,[9:0]y);
logic [11:0] white = 12'hFFF;
begin
    case(charVal)
         6 'b000000: // blank
               begin
                   draw(x + 6, y, x + 15, y + 3, white);
               end
        6 'b011010: // A
            begin
                draw(x + 6, y, x + 15, y + 3, white);
                draw(x + 3, y + 3, x + 18, y + 6, white);
                draw(x, y + 6, x + 6, y + 27, white);
                draw(x + 6, y + 12, x + 15, y + 18, white);
                draw(x + 15, y + 6, x + 21, y + 27, white);
            end
        6'b000001: // B
            begin
                draw(x, y, x + 15, y + 6, white);
                draw(x, y + 6, x + 6, y + 27, white);
                draw(x + 15, y + 6, x + 21, y + 12, white);
                draw(x + 6, y + 12, x + 15, y + 15, white);
                draw(x + 15, y + 15, x + 21, y + 24, white);
                draw(x + 6, y + 24, x + 15, y + 27, white);
            end
        6'b000010: // C
            begin
                draw(x + 6, y, x + 18, y + 3, white);
                draw(x + 3, y + 3, x + 6, y + 6, white);
                draw(x + 18, y + 3, x + 21, y + 6, white);
                draw(x, y + 6, x + 6, y + 24, white);
                draw(x + 3, y + 24, x + 18, y + 27, white);
                draw(x + 18, y + 21, x + 21, y + 24, white);
            end
        6'b000011: // D
            begin
                draw(x, y, x + 15, y + 3, white);
                draw(x, y + 3, x + 6, y + 27, white);
                draw(x + 15, y + 3, x + 18, y + 6, white);
                draw(x + 18, y + 6, x + 21, y + 21, white);
                draw(x + 15, y + 21, x + 18, y + 24, white);
                draw(x + 6, y + 24, x + 15, y + 27, white);
            end
        6'b000100: // E
            begin
                draw(x, y, x + 21, y + 3, white);
                draw(x, y + 3, x + 6, y + 27, white);
                draw(x + 6, y + 12, x + 15, y + 15, white);
                draw(x + 6, y + 24, x + 21, y + 27, white);
            end
        6'b000101: // F
            begin
                draw(x, y, x + 21, y + 3, white);
                draw(x, y + 3, x + 6, y + 27, white);
                draw(x + 6, y + 9, x + 15, y + 12, white);
            end
        6'b000110: // G
            begin
                draw(x + 3, y, x + 18, y + 3, white);
                draw(x, y + 3, x + 6, y + 24, white);
                draw(x + 18, y + 3, x + 21, y + 6, white);
                draw(x + 3, y + 24, x + 18, y + 27, white);
                draw(x + 15, y + 15, x + 21, y + 24, white);
                draw(x + 12, y + 15, x + 15, y + 18, white);
            end
        6'b000111: // H
            begin
                draw(x, y, x + 6, y + 27, white);
                draw(x + 6, y + 12, x + 15, y + 15, white);
                draw(x + 15, y, x + 21, y + 27, white);
            end
        6'b001000: // I
            begin
                draw(x, y, x + 6, y + 27, white);
            end
        6'b001001: // J
            begin
                draw(x + 15, y, x + 21, y + 24, white);
                draw(x, y + 18, x + 3, y + 24, white);
                draw(x + 3, y + 24, x + 18, y + 27, white);
            end
        6'b001010: // K
            begin
                draw(x, y, x + 6, y + 27, white);
                draw(x + 6, y + 12, x + 15, y + 15, white);
                draw(x + 15, y + 9, x + 18, y + 12, white);
                draw(x + 15, y + 15, x + 18, y + 18, white);
                draw(x + 18, y, x + 21, y + 9, white);
                draw(x + 18, y + 18, x + 21, y + 27, white);
            end
        6'b001011: // L
            begin
                draw(x, y, x + 6, y + 27, white);
                draw(x + 6, y + 21, x + 21, y + 27, white);
            end
        6'b001100: // M
            begin
                draw(x + 3, y, x + 9, y + 3, white);
                draw(x + 12, y, x + 18, y + 3, white);
                draw(x, y + 3, x + 21, y + 6, white);
                draw(x, y + 6, x + 6, y + 27, white);
                draw(x + 9, y + 6, x + 12, y + 27, white);
                draw(x + 15, y + 6, x + 21, y + 27, white);
            end
        6'b001101: // N
            begin
                draw(x, y, x + 6, y + 27, white);
                draw(x + 6, y + 3, x + 9, y + 6, white);
                draw(x + 9, y, x + 18, y + 3, white);
                draw(x + 18, y + 3, x + 21, y + 27, white);
            end
        6'b001110: // O
            begin
                draw(x, y + 3, x + 6, y + 24, white);
                draw(x + 15, y + 3, x + 21, y + 24, white);
                draw(x + 3, y, x + 18, y + 3, white);
                draw(x + 3, y + 24, x + 18, y + 27, white);
            end
        6'b001111: // P
            begin
                draw(x, y, x + 15, y + 3, white);
                draw(x, y + 3, x + 6, y + 27, white);
                draw(x + 15, y + 3, x + 18, y + 6, white);
                draw(x + 18, y + 6, x + 21, y + 12, white);
                draw(x + 15, y + 12, x + 18, y + 15, white);
                draw(x + 6, y + 15, x + 15, y + 18, white);
            end
        6'b010000: // Q
            begin
                draw(x + 3, y, x + 18, y + 3, white);
                draw(x, y + 3, x + 6, y + 24, white);
                draw(x + 15, y + 3, x + 21, y + 21, white);
                draw(x + 3, y + 24, x + 21, y + 27, white);
                draw(x + 9, y + 18, x + 12, y + 21, white);
                draw(x + 12, y + 21, x + 18, y + 24, white);
                draw(x + 3, y + 24, x + 21, y + 27, white);
            end
        6'b010001: // R
            begin
                draw(x, y, x + 15, y + 3, white);
                draw(x, y + 3, x + 6, y + 27, white);
                draw(x + 15, y + 3, x + 18, y + 6, white);
                draw(x + 18, y + 6, x + 21, y + 12, white);
                draw(x + 15, y + 12, x + 18, y + 15, white);
                draw(x + 6, y + 15, x + 18, y + 18, white);
                draw(x + 18, y + 18, x + 21, y + 27, white);
            end
        6'b010010: // S
            begin
                draw(x + 3, y, x + 18, y + 3, white);
                draw(x, y + 3, x + 3, y + 12, white);
                draw(x + 18, y + 3, x + 21, y + 9, white);
                draw(x + 3, y + 12, x + 18, y + 15, white);
                draw(x + 18, y + 15, x + 21, y + 24, white);
                draw(x, y + 18, x + 3, y + 24, white);
                draw(x + 6, y + 24, x + 21, y + 27, white);
            end
        6'b010011: // T
            begin
                draw(x, y, x + 21, y + 6, white);
                draw(x + 9, y + 6, x + 15, y + 27, white);
            end
        6'b010100: // U
            begin
                draw(x, y, x + 6, y + 24, white);
                draw(x + 15, y, x + 21, y + 24, white);
                draw(x + 3, y + 21, x + 18, y + 27, white);
            end
        6'b010101: // V
            begin
                draw(x, y, x + 3, y + 15, white);
                draw(x + 18, y, x + 21, y + 15, white);
                draw(x + 3, y + 12, x + 6, y + 21, white);
                draw(x + 15, y + 12, x + 18, y + 21, white);
                draw(x + 9, y + 18, x + 12, y + 24, white);
                draw(x + 15, y + 18, x + 18, y + 24, white);
                draw(x + 12, y + 24, x + 15, y + 27, white);
            end
        6'b010110: // W
            begin
                draw(x, y, x + 3, y + 24, white);
                draw(x + 18, y, x + 21, y + 24, white);
                draw(x + 9, y + 9, x + 12, y + 24, white);
                draw(x, y + 24, x + 21, y + 27, white);
            end
        6'b010111: // X
            begin
                draw(x, y, x + 3, y + 9, white);
                draw(x + 18, y, x + 21, y + 9, white);
                draw(x + 3, y + 6, x + 6, y + 12, white);
                draw(x + 15, y + 6, x + 18, y + 12, white);
                draw(x + 6, y + 12, x + 15, y + 15, white);
                draw(x + 3, y + 15, x + 6, y + 21, white);
                draw(x + 15, y + 15, x + 18, y + 21, white);
                draw(x, y + 18, x + 3, y + 27, white);
                draw(x + 18, y + 18, x + 21, y + 27, white);              
            end
        6'b011000: // Y
            begin
                draw(x, y, x + 6, y + 12, white);
                draw(x + 15, y, x + 21, y + 24, white);
                draw(x + 3, y + 12, x + 15, y + 15, white);
                draw(x, y + 21, x + 6, y + 24, white);
                draw(x + 3, y + 24, x + 18, y + 27, white);
            end
        6'b011001: // Z
            begin
                draw(x, y, x + 21, y + 6, white);
                draw(x + 15, y + 6, x + 21, y + 9, white);
                draw(x + 12, y + 9, x + 15, y + 12, white);
                draw(x + 9, y + 12, x + 12, y + 15, white);
                draw(x + 6, y + 15, x + 9, y + 18, white);
                draw(x, y + 18, x + 6, y + 21, white);
                draw(x + 3, y + 21, x + 24, y + 27, white);
            end
        default:
            begin
                red = 0;
                green = 0;
                blue = 0;
            end
    endcase
end
endfunction



endmodule
