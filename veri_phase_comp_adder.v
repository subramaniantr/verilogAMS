module veri_phase_comp_adder(adder_in,down,sum_out);

input [9:0] adder_in;  //From the registers
input down;

output [9:0] sum_out;
reg    [9:0] sum_out;

always@(adder_in or down)
  if(down == 1'b1 && adder_in != 10'h0)
     sum_out <= adder_in - 1'b1;
  else
  if(down == 1'b0 && adder_in != 10'h3FF)
     sum_out <= adder_in + 1'b1;
  else
     sum_out <= adder_in;

endmodule
