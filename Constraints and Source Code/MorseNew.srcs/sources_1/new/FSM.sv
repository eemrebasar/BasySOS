`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/20/2016 02:41:54 PM
// Design Name: 
// Module Name: FSM
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


module FSM(input logic clk,
			    input logic reset,
			    input wire ta,
			    input wire tb,
			    input wire newWord,
                output logic [5:0] harf,
                output logic o);
                
                logic [4:0] state, nextstate;
                 parameter S0 = 5'b00000;
                 parameter S1 = 5'b00001;
                 parameter S2 = 5'b00010;
                 parameter S3 = 5'b00011;
                 parameter S4 = 5'b00100;
                 parameter S5 = 5'b00101;
                 parameter S6 = 5'b00110;
                 parameter S7 = 5'b00111;
                 parameter S8 = 5'b01000;
                 parameter S9 = 5'b01001;
                parameter S10 = 5'b01010;
                parameter S11 = 5'b01011;
                parameter S12 = 5'b01100;
                parameter S13 = 5'b01101;
                parameter S14 = 5'b01111;
                parameter S15 = 5'b01110;
                parameter S16 = 5'b10000;
                parameter S17 = 5'b10001;
                parameter S18 = 5'b10010;
                parameter S19 = 5'b10011;
                parameter S20 = 5'b10100;
                parameter S21 = 5'b10101;
                parameter S22 = 5'b10110;
                parameter S23 = 5'b10111;
                parameter S24 = 5'b11000;
                parameter S25 = 5'b11001;
                parameter S26 = 5'b11010;

                always_ff@(posedge clk, posedge reset)
                 begin
                    if(reset) state <= S0;
                    else state <= nextstate;
                end
                

                //next state logic
                always_comb
                begin
                    case(state)
                        S0:  begin 
                            if (ta) nextstate = S20;
                            else  if (tb) nextstate = S5;
                             else
                              nextstate = state; end
                              
                        S1:begin    
                         if (ta) nextstate = S23;
                               else if (tb) nextstate = S18;
                               else if(newWord)  o = 1;
                                else
                                nextstate = state;
                          end
                        S2: begin
                            nextstate = state;
                             if(newWord)  o = 1;  
                            end
                        S3:begin
                           nextstate = state;
                            if(newWord)  o = 1;
                           end
                        S4:begin  
                          if(ta) nextstate = S24;
                          else if(tb) nextstate  = S2;
                          else if(newWord) o = 1;
                          else
                          nextstate = state ;
                        end
                        S5:   begin if(ta) nextstate = S1;
                            else if(tb) nextstate = S9;
                            else if(newWord) o = 1;
                            else
                             nextstate = state;
                        end 
                        S6: begin
                            nextstate = state;
                             if(newWord) o = 1;
                        end
                        
                        
                        S7:  begin  if(ta) nextstate = S17;
                 
                             else if(tb) nextstate = S26;
                             else if(newWord) o = 1;
                             else
                               nextstate = state;
                          end
                       S8: begin
                       nextstate = state;
                        if(newWord) o = 1;
                           end
                        S9: begin   if(ta) nextstate = S21;
                             else if(tb) nextstate = S19;
                             else if(newWord) o = 1;
                        else nextstate = state;
                        end            
                            S10:begin
                            nextstate = state;
                             if(newWord) o = 1;
                                end
                            S11: begin   if(ta) nextstate = S25;
                             else if(tb) nextstate = S3;
                             else if(newWord) o = 1;
                            else 
                            nextstate = state;
                            end
                        S12:
                        begin
                        nextstate=state;
                         if(newWord) o = 1;
                        end
                        S13: begin if(ta) nextstate = S15;
                             else if(tb) nextstate = S7;
                             else if(newWord) o = 1;
                       else nextstate = state;
                       end
                       S14: begin
                        if(ta) nextstate = S11;
                          else if(tb) nextstate = S4;
                          else if(newWord) o = 1;
                    else nextstate = state;
                        end
                        S15:
                        begin
                        nextstate = state;
                         if(newWord) o = 1;
                        end
                        S16:
                        begin
                        nextstate = state;
                         if(newWord) o = 1;
                        end
                                        
                        S17: begin
                        if(ta) nextstate = S17;
                               else  if(tb) nextstate = S26;
                               else if(newWord) o = 1;
                       else 
                       nextstate = state;
                       end
                       S18: begin
                            if(tb) nextstate = S12;
                            else if(newWord) o = 1;
                            else nextstate = state;
                            
                            end
                       S19: begin
                        if(ta) nextstate = S22;
                        else if(tb) nextstate = S8;
                        else if(newWord)o = 1;
                       else nextstate = state;
                       end
                       S20: begin
                        if(ta) nextstate = S13;
                        else if(tb) nextstate = S14;
                        else if(newWord) o = 1;
                       else 
                       nextstate = state; 
                       end                      
                       S21:
                       begin
                        if(tb) nextstate = S6;
                        else if(newWord) o = 1;
                        else nextstate = state;
                        end
                       S22:
                       begin
                       nextstate = state;
                        if(newWord) o = 1;
                       end
                        
                       S23: begin
                        if(ta) nextstate = S10;
                        else if(tb) nextstate = S16;
                        else if(newWord) o = 1;
                         else nextstate = state;
                    end
                       S24:begin
                       nextstate = state;
                        if(newWord) o = 1;
                        end
                        S25: begin
                        nextstate =state;
                         if(newWord) o = 1;
                        end
                        S26:begin
                        nextstate = state;
                        if(newWord) begin o = 1; nextstate = S0; end
                     end
                     
                     default: nextstate = S0;
                    
                    endcase

                end    
                
                always @ (*) begin
                    case(state)
                    S0:
                    begin
                        harf = 6'b000000;
                    end    
                    S1: 
                    begin
                       harf =  6'b011010;
                    end
                
                    S2: begin
                             harf =  1;
                              end
                
                    S3:begin
                          harf =  2;
                       end
                
                    S4:begin 
                           harf =  3;
                            end
                
                    S5:   
                    begin 
                       harf =  4;
                    end
                    
                    S6:begin 
                    harf =  5;
                    end
                    
                    S7:begin 
                    harf =  6;
                    end
                    
                    S8:begin
                    harf = 7;
                    end
                    S9: 
                    begin
                    harf =  8;
                    end
                    
                    S10:
                    begin
                    harf =  9;
                    end
                    S11:
                    begin
                    harf=10;
                    end
                    
                    S12: 
                    begin
                    harf = 11;
                    end
                    S13:
                    begin
                    harf=12;
                    end
                    S14:
                    begin
                    harf = 13;
                    end                
                    S15:
                    begin
                    harf=14;
                    end
                    S16:
                    begin
                    harf = 15;
                    end
                    S17:
                    begin
                    harf=16;
                    end
                    S18:
                    begin
                    harf = 17;
                    end
                    S19:
                    begin
                    harf = 18;
                    end
                    S20:
                    begin
                    harf = 19;
                    end
                    S21:
                    begin
                    harf = 20;
                    end
                    S22:
                    begin
                    harf=21;
                    end
                    S23:
                    begin 
                    harf = 22;
                    end
                    S24:
                    begin
                    harf = 23;
                    end
                    S25:
                    begin
                    harf = 24;
                    end
                    S26:
                    begin
                    harf = 25;
                    end             
                endcase        
                 
                end
endmodule
