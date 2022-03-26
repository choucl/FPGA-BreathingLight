`include "def.v"

module breather (
    input        clk_div_i,  // clk_div = 125MHz / 8 = 15625000Hz
    input        rst_i,
    input  [2:0] rgb_i,
    output [2:0] rgb4_o,
    output reg   clk_div_o
);

    reg        mask;           // determine if the light can pass
    reg [31:0] clk_counter;    // count the current clock, reset every phase
    reg [31:0] togle_counter;  // determine the mask is 1 or 0
    reg [4:0]  phase_counter;  // count the current phase
    reg [31:0] brightness;

    always @(clk_div_i or rst_i) begin
        
        if (rst_i == 1) begin
            clk_counter   <= 0;
            phase_counter <= 0;
            togle_counter <= 0;
            brightness    <= 32'hffffffff;
            mask          <= 1;
            clk_div_o     <= 1;
        end else begin
            clk_counter <= clk_counter + 32'd1; 
            
            if (clk_counter == 32'd9765625) begin  // 2 sec
                clk_counter   <= 0;
                phase_counter <= phase_counter + 5'd1;
                
                // control brightness, 1 for the brightest
                if (phase_counter <= 5'd15) begin
                    brightness <= (brightness + 32'd2) << 1;
                    clk_div_o  <= 1;
                end else begin
                    brightness <= (brightness >> 1) - 32'd2;
                    clk_div_o  <= 0;
                end
            end
            
            togle_counter <= togle_counter + 32'd1;
            if (togle_counter == brightness) begin
                togle_counter <= 32'd0;
                mask = !mask;
            end
        end
        
    end

    assign rgb4_o = rgb_i & {3{mask}};  // output
    
endmodule
