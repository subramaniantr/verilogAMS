//Verilog HDL for "tirunels_design", "veri_phase_comp_high_coarse_reg" "functional"


module veri_phase_comp_high_coarse_reg (resetb, enable,sum_in,clk,reg_out,load_en,load_data);

input clk;
input resetb;
input enable;
input load_en;
input [1:0] load_data;
input [1:0] sum_in;
output [1:0] reg_out;
reg [1:0] reg_out;

always@(posedge clk or negedge resetb)
if(~resetb)
 reg_out <= 2'b01;
else
if(enable)
  if(load_en)
  reg_out <= load_data;
else
  reg_out <= sum_in;

endmodule


