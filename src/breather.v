// `include "def.v"

module breather (
    input        clk_div_i,  // clk_div = 125MHz
    input        rst_i,
    input  [2:0] rgb_i,
    output [2:0] rgb4_o,
    output reg   clk_div_o
);

    reg        mask;            // determine if the light can pass
    reg [31:0] clk_cnt;         // count the current clock, reset every phase
    reg [4:0]  phase_cnt;       // count the current phase
    reg [3:0]  brightness;      // determine the current brightness (0-15)
    reg [3:0]  brightness_cnt;  // determine the mask is 1 or 0

    always @(posedge clk_div_i or posedge rst_i) begin
        
        if (rst_i == 1) begin
            clk_cnt        <= 32'd0;
            phase_cnt      <= 5'd0;
            brightness_cnt <= 4'd0;
            brightness     <= 4'd15;
            mask           <= 1;
            clk_div_o      <= 1;
        end else begin
            
            if (clk_cnt != 32'd30517) begin
                clk_cnt   <= clk_cnt + 32'd1; 
            end else begin  // 1/16 sec
                clk_cnt   <= 32'd0;
                phase_cnt <= phase_cnt + 5'd1;
                
                // control brightness, 15 for the brightest
                if (phase_cnt < 5'd15) begin
                    brightness <= brightness - 4'd1;  // dimer
                end else if (phase_cnt > 5'd15 && phase_cnt < 5'd31) begin
                    brightness <= brightness + 4'd1;  // ligher
                end else begin
                    brightness <= brightness;
                end

                // control output clock
                if (phase_cnt == 5'd15 || phase_cnt == 5'd31) begin
                    clk_div_o <= ~clk_div_o;
                end
            end
            
            // determine mask status
            if (brightness_cnt == 4'hf) begin
                mask           <= 1;
                brightness_cnt <= 4'd0;
            end else begin
                brightness_cnt <= brightness_cnt + 4'd1;
                if (brightness_cnt >= brightness) mask <= 0;
            end
        end
        
    end

    assign rgb4_o = rgb_i & {3{mask}};  // output
    
endmodule
