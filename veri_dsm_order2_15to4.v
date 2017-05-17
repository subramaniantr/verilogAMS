//Verilog HDL for "tirunels_design", "veri_dsm_order2_15to4" "functional"


module veri_dsm_order2_15to4 ( din, dout, clk, rst );
 

input [14:0] din;
input clk, rst;

output [3:0] dout;

reg [3:0]dout;

reg [15:0]delay1;
reg [15:0]delay2;

reg [15:0] din_2comp;
reg [17:0] dout_int;


reg [15:0] din_signed;
reg [15:0] din_signed_pos;
reg [15:0] din_signed_neg;


 


// Register logic starts here
always @(posedge clk or negedge rst)
begin
        if (rst == 0 ) begin
                dout <= 0;
                delay1 <= 0;
                delay2 <= 0;
                din_2comp <= 0; 
        end
        else begin
                // 2s complement the input data
                din_2comp <= din_signed;

                dout <= {~dout_int[15],dout_int[14],dout_int[13],dout_int[12]};

                delay1 <= {4'b0000 ,dout_int[11:0]};

                delay2 <= delay1;
 
        end
end

//Signed conversion is implemented here
always @(din)
begin

                din_signed_pos = {1'b0,din} + 16'b0100_0000_0000_0000;
                din_signed = {~din_signed_pos[15],din_signed_pos[14:0]};

end


// Limitter on the adder is implemented here
always @(delay1 or delay2 or din_2comp) begin

dout_int = {din_2comp[15],din_2comp} + {1'b0,delay1[14:0],1'b0} - {1'b0,delay2};
//dout_int = din_2comp + {delay1[14:0],1'b0} - delay2;

        // Check if we are on the right side
        if (dout_int < 17'b0_1111_1111_1111_1111)begin
                if (dout_int > 17'b0_0111_1111_1111_1111) begin
                        dout_int = 17'b0_0111_1111_1111_1111;
                end
        end

        // Check if we are on the left side
        if (dout_int > 17'b1_0000_0000_0000_0000)begin
                if (dout_int < 17'b1_1000_0000_0000_0000) begin
                        dout_int = 17'b1_1000_0000_0000_0000;
                end
        end
end


endmodule



