	//Verilog-AMS HDL for "tirunels_design", "veri_accumulator_16bit" "verilogams"

module veri_accumulator_16bit (out,enable,clk,rstb,up,step,ext_val,sel_ext);

        output [15:0]out;
        input enable, clk, rstb,up;
        input [3:0] step;	
        input [15:0] ext_val;
        input sel_ext;	
        
        reg [15:0]out;
        reg upsatb,dnsatb;


    always @(posedge clk or negedge rstb)
    begin
       if (~rstb) 
          begin
            out <= 16'h8000; //START FROM MID CODE
          end 
    else
       if (enable)         //SATURATION AND FREEZE CHECK
         if(sel_ext)       //ENABLE TO EXTERNAL INPUT TO ACCUMULATOR
           out<= ext_val;
         else
           if(up == 1'b1 && upsatb)
          begin
            out <= out + step;
          end
        else 
         if(up == 1'b0 && dnsatb) 
          begin
           out <= out - step;
          end

end  //SEQUENTIAL END

     //NEXT
     //Saturate_Bar variable for saturating at highest or lowest values to prevent rolling over of the accumulator_
  always @(out)
        if(out > 16'hFFC0)
          begin
            upsatb <= 1'b0;
            dnsatb <= 1'b1;
         end          
        else if (out < 16'h3F)
          begin
            upsatb <= 1'b1;
            dnsatb <= 1'b0;
         end
        else
          begin
            upsatb <= 1'b1;
            dnsatb <= 1'b1;
         end
endmodule
