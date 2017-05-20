module veri_phase_comp_mux_reg (resetb, enable,sum_in,clk,reg_out,load_en,load_data);

input clk;
input resetb;
input enable;
input load_en;
input [9:0] load_data;
input [9:0] sum_in;
output [9:0] reg_out;
reg [9:0] reg_out;

always@(posedge clk or negedge resetb)
if(~resetb)
 reg_out <= 10'h200;
else
if(load_en)
  reg_out <= load_data;
else
if(enable)
  reg_out <= sum_in;

endmodule
