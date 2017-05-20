//Verilog HDL for "tirunels_design", "veri_phase_comp_adder2bit" "functional"

module veri_phase_comp_adder2bit (adder_in,down,sum_out);

input [1:0] adder_in;  //From the registers
input down;

output [1:0] sum_out;
reg    [1:0] sum_out;

always@(adder_in or down)
  if(adder_in == 2'b11)
     sum_out <=2'b10;
  else
  if(down == 1'b1 && adder_in != 2'b00) 
     sum_out <= adder_in - 1'b1;
  else
  if(down == 1'b0 && adder_in != 2'b10)
     sum_out <= adder_in + 1'b1;
  else
     sum_out <= adder_in;
  
endmodule
