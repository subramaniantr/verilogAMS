//Verilog HDL for "tirunels_design", "veri_decoder4x16" "functional"


module veri_bin2therm_4bit( clk, resetb, binary_in, therm_out );
 
input clk, resetb;
input [3:0] binary_in;
output [14:0] therm_out;
reg [14:0] therm_out;


always @(posedge clk or negedge resetb)
if(resetb == 1'b0)
 therm_out <= 15'h0000;
else
  case (binary_in)
    4'hF    : begin therm_out <= 15'h0000;end    
    4'hE    : begin therm_out <= 15'h0001;end   
    4'hD    : begin therm_out <= 15'h0003;end    
    4'hC    : begin therm_out <= 15'h0007;end   
    4'hB    : begin therm_out <= 15'h000F;end  
    4'hA    : begin therm_out <= 15'h001F;end  
    4'h9    : begin therm_out <= 15'h003F;end  
    4'h8    : begin therm_out <= 15'h007F;end  
    4'h7    : begin therm_out <= 15'h00FF;end   
    4'h6    : begin therm_out <= 15'h01FF;end   
    4'h5    : begin therm_out <= 15'h03FF;end   
    4'h4    : begin therm_out <= 15'h07FF;end   
    4'h3    : begin therm_out <= 15'h0FFF;end  
    4'h2    : begin therm_out <= 15'h1FFF;end  
    4'h1    : begin therm_out <= 15'h3FFF;end 
    4'h0    : begin therm_out <= 15'h7FFF;end 
    default : begin therm_out <= 15'h0000;end
  endcase

endmodule

