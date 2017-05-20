//Verilog-AMS HDL for "tirunels_design", "veri_phase_comp_control" "verilogams"
//THE COMPONENTS ARE :
// 1)  ADDER WHICH IS SHARED BY ALL REGISTERS: LOADABLE, SATURATES
// 2)  SIXTEEN 8 BIT REGISTERS WHICH HAVE RESET, ENABLE, CLK, INPUT AND OUT
// 3)  PD REGISTERS
// 4)  COUNTER TO SELECT THE REGISTERS IN ROUND ROBIN FASHION

 
module veri_phase_comp_control_coarse(R0_OUT,R1_OUT,R2_OUT,R3_OUT,R4_OUT,R5_OUT,R6_OUT,R7_OUT,R8_OUT,R9_OUT,R10_OUT,R11_OUT,R12_OUT,R13_OUT,R14_OUT,R15_OUT,clk,pd_in,resetb,reg_load_data,reg_read_data,reg_num,reg_write_readb,enable,en_mid,freeze);

input en_mid;
input clk;
input resetb;
input enable;
input [15:0] freeze;
input [15:0] pd_in;
input [9:0] reg_load_data;  /////////LOADING VALUE///////////////******************CHANGES WHEN BIT NUM CHANGES
input [3:0] reg_num;
input reg_write_readb;
wire  [15:0]freezeb;

assign freezeb = ~freeze;
output [9:0] reg_read_data;
reg  [9:0] reg_read_data;
output [5:0] R0_OUT,R1_OUT,R2_OUT,R3_OUT,R4_OUT,R5_OUT,R6_OUT,R7_OUT,R8_OUT,R9_OUT,R10_OUT,R11_OUT,R12_OUT,R13_OUT,R14_OUT,R15_OUT;
wire [9:0] R0,R1,R2,R3,R4,R5,R6,R7,R8,R9,R10,R11,R12,R13,R14,R15;  ///////////WIRES OUT OF REGISTERS/////////////******************CHANGES WHEN BIT NUM CHANGES

assign R0_OUT  = R0[9:4];  ////////OUTPUT WIRES////////////////******************CHANGES WHEN BIT NUM CHANGES
assign R1_OUT  = R1[9:4];
assign R2_OUT  = R2[9:4];
assign R3_OUT  = R3[9:4];
assign R4_OUT  = R4[9:4];
assign R5_OUT  = R5[9:4];
assign R6_OUT  = R6[9:4];
assign R7_OUT  = R7[9:4];
assign R8_OUT  = R8[9:4];
assign R9_OUT  = R9[9:4];
assign R10_OUT = R10[9:4];
assign R11_OUT = R11[9:4];
assign R12_OUT = R12[9:4];
assign R13_OUT = R13[9:4];
assign R14_OUT = R14[9:4];
assign R15_OUT = R15[9:4];
 

reg  [9:0] adder_in;  ////////INPUT TO THE ADDER////////////////******************CHANGES WHEN BIT NUM CHANGES
reg  [15:0] reg_pd;
reg  [15:0] enable_reg;
wire  [3:0] counter_out;
reg  down;
wire  [9:0] sum_out;  //////////OUTPUT OF THE ADDER//////////////******************CHANGES WHEN BIT NUM CHANGES
reg  [15:0] load_en;


// THE DIVIDED CLOCK COMES AS THE INPUT USING WHICH PD OUTPUTS ARE SAMPLED INTO REG_PD
// THE ADDER IS MULTIPLEXED BETWEEN THE 16 REGISTERS 
always @(posedge clk or negedge resetb)
if(~resetb)
 reg_pd <= 15'h0;
else 
 reg_pd <= pd_in;

// 5 BIT COUNTER TO SWITCH BETWEEN THE 16 REGISTERS
// THE INPUT OF THE ADDER IS SELECTED USING COUNTER IN A ROTARY FASHION USING
// THE COUNTER-MUX COMBINATION

veri_counter4bit counter_4bit(counter_out,enable,clk,resetb);
// 8 BIT ADDER SHARED BETWEEN ALL REGISTERS

veri_phase_comp_adder adder (adder_in,down,sum_out);
 
//16 REGISTERS FOR STORING PD OUT AND CURRENT CONTROL WORD FOR EACH PHASE COMPENSATOR
// A MULTIPLEXER WHOSE OUTPUT IS adder_in. THE MUX ALSO GENERATES AN ENABLE TO
// THE CORRESPONDING REGISTER ALONE TO BE WRITTEN INTO THROUGH reg_load_data by enabling load_en
//BY DEFAULT SUM OUT IS WRITTEN INTO THE REGISTER IF ENABLE IS ASSERTED AT THE RISING EDGE OF CLK

veri_phase_comp_mux_reg reg0  (resetb,(enable_reg[0 ] & freezeb[0 ]) ,sum_out,clk,R0 ,load_en[0 ],reg_load_data);
veri_phase_comp_mux_reg reg1  (resetb,(enable_reg[1 ] & freezeb[1 ]) ,sum_out,clk,R1 ,load_en[1 ],reg_load_data);
veri_phase_comp_mux_reg reg2  (resetb,(enable_reg[2 ] & freezeb[2 ]) ,sum_out,clk,R2 ,load_en[2 ],reg_load_data);
veri_phase_comp_mux_reg reg3  (resetb,(enable_reg[3 ] & freezeb[3 ]) ,sum_out,clk,R3 ,load_en[3 ],reg_load_data);
veri_phase_comp_mux_reg reg4  (resetb,(enable_reg[4 ] & freezeb[4 ]) ,sum_out,clk,R4 ,load_en[4 ],reg_load_data);
veri_phase_comp_mux_reg reg5  (resetb,(enable_reg[5 ] & freezeb[5 ]) ,sum_out,clk,R5 ,load_en[5 ],reg_load_data);
veri_phase_comp_mux_reg reg6  (resetb,(enable_reg[6 ] & freezeb[6 ]) ,sum_out,clk,R6 ,load_en[6 ],reg_load_data);
veri_phase_comp_mux_reg reg7  (resetb,(enable_reg[7 ] & freezeb[7 ] & en_mid) ,sum_out,clk,R7 ,load_en[7 ],reg_load_data);
veri_phase_comp_mux_reg reg8  (resetb,(enable_reg[8 ] & freezeb[8 ]) ,sum_out,clk,R8 ,load_en[8 ],reg_load_data);
veri_phase_comp_mux_reg reg9  (resetb,(enable_reg[9 ] & freezeb[9 ]) ,sum_out,clk,R9 ,load_en[9 ],reg_load_data);
veri_phase_comp_mux_reg reg10 (resetb,(enable_reg[10] & freezeb[10]) ,sum_out,clk,R10,load_en[10],reg_load_data);
veri_phase_comp_mux_reg reg11 (resetb,(enable_reg[11] & freezeb[11]) ,sum_out,clk,R11,load_en[11],reg_load_data);
veri_phase_comp_mux_reg reg12 (resetb,(enable_reg[12] & freezeb[12]) ,sum_out,clk,R12,load_en[12],reg_load_data);
veri_phase_comp_mux_reg reg13 (resetb,(enable_reg[13] & freezeb[13]) ,sum_out,clk,R13,load_en[13],reg_load_data);
veri_phase_comp_mux_reg reg14 (resetb,(enable_reg[14] & freezeb[14]) ,sum_out,clk,R14,load_en[14],reg_load_data);
veri_phase_comp_mux_reg reg15 (resetb,(enable_reg[15] & freezeb[15]) ,sum_out,clk,R15,load_en[15],reg_load_data);


//MULTIPLEXER TO ENABLE EACH REGISTER AS WELL AS PASS THE SELECTED REGISTER TO THE ACCUMULATOR 
always @(*)

  case ({enable,counter_out})
    5'h10   : begin adder_in = R0 ; down = reg_pd[0 ]; enable_reg = 16'h0001; end    
    5'h11   : begin adder_in = R1 ; down = reg_pd[1 ]; enable_reg = 16'h0002; end   
    5'h12   : begin adder_in = R2 ; down = reg_pd[2 ]; enable_reg = 16'h0004; end    
    5'h13   : begin adder_in = R3 ; down = reg_pd[3 ]; enable_reg = 16'h0008; end   
    5'h14   : begin adder_in = R4 ; down = reg_pd[4 ]; enable_reg = 16'h0010; end  
    5'h15   : begin adder_in = R5 ; down = reg_pd[5 ]; enable_reg = 16'h0020; end  
    5'h16   : begin adder_in = R6 ; down = reg_pd[6 ]; enable_reg = 16'h0040; end  
    5'h17   : begin adder_in = R7 ; down = reg_pd[7 ]; enable_reg = 16'h0080; end  
    5'h18   : begin adder_in = R8 ; down = reg_pd[8 ]; enable_reg = 16'h0100; end   
    5'h19   : begin adder_in = R9 ; down = reg_pd[9 ]; enable_reg = 16'h0200; end   
    5'h1A   : begin adder_in = R10; down = reg_pd[10]; enable_reg = 16'h0400; end   
    5'h1B   : begin adder_in = R11; down = reg_pd[11]; enable_reg = 16'h0800; end   
    5'h1C   : begin adder_in = R12; down = reg_pd[12]; enable_reg = 16'h1000; end  
    5'h1D   : begin adder_in = R13; down = reg_pd[13]; enable_reg = 16'h2000; end  
    5'h1E   : begin adder_in = R14; down = reg_pd[14]; enable_reg = 16'h4000; end 
    5'h1F   : begin adder_in = R15; down = reg_pd[15]; enable_reg = 16'h8000; end 
    default : begin adder_in = R15; down = reg_pd[15]; enable_reg = 16'h0000; end
  endcase
  	  //DECODER TO LOAD EACH REGISTER 
always @(*)

  case ({reg_write_readb,reg_num})
//WRITE DATA ENABLE
    5'h10   : begin reg_read_data = R7; load_en = 16'h0001; end    
    5'h11   : begin reg_read_data = R7; load_en = 16'h0002; end   
    5'h12   : begin reg_read_data = R7; load_en = 16'h0004; end    
    5'h13   : begin reg_read_data = R7; load_en = 16'h0008; end   
    5'h14   : begin reg_read_data = R7; load_en = 16'h0010; end  
    5'h15   : begin reg_read_data = R7; load_en = 16'h0020; end  
    5'h16   : begin reg_read_data = R7; load_en = 16'h0040; end  
    5'h17   : begin reg_read_data = R7; load_en = 16'h0080; end  
    5'h18   : begin reg_read_data = R7; load_en = 16'h0100; end   
    5'h19   : begin reg_read_data = R7; load_en = 16'h0200; end   
    5'h1A   : begin reg_read_data = R7; load_en = 16'h0400; end   
    5'h1B   : begin reg_read_data = R7; load_en = 16'h0800; end   
    5'h1C   : begin reg_read_data = R7; load_en = 16'h1000; end  
    5'h1D   : begin reg_read_data = R7; load_en = 16'h2000; end  
    5'h1E   : begin reg_read_data = R7; load_en = 16'h4000; end 
    5'h1F   : begin reg_read_data = R7; load_en = 16'h8000; end 
//READ DATA
    5'h00   : begin reg_read_data = R0;  load_en=16'b0000; end    
    5'h01   : begin reg_read_data = R1;  load_en=16'b0000; end   
    5'h02   : begin reg_read_data = R2;  load_en=16'b0000; end    
    5'h03   : begin reg_read_data = R3;  load_en=16'b0000; end   
    5'h04   : begin reg_read_data = R4;  load_en=16'b0000; end  
    5'h05   : begin reg_read_data = R5;  load_en=16'b0000; end  
    5'h06   : begin reg_read_data = R6;  load_en=16'b0000; end  
    5'h07   : begin reg_read_data = R7;  load_en=16'b0000; end  
    5'h08   : begin reg_read_data = R8;  load_en=16'b0000; end   
    5'h09   : begin reg_read_data = R9;  load_en=16'b0000; end   
    5'h0A   : begin reg_read_data = R10; load_en=16'b0000; end   
    5'h0B   : begin reg_read_data = R11; load_en=16'b0000; end   
    5'h0C   : begin reg_read_data = R12; load_en=16'b0000; end  
    5'h0D   : begin reg_read_data = R13; load_en=16'b0000; end  
    5'h0E   : begin reg_read_data = R14; load_en=16'b0000; end 
    5'h0F   : begin reg_read_data = R15; load_en=16'b0000; end 
    default : begin reg_read_data = R7;  load_en=16'b0000; end
  endcase




endmodule

