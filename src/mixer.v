`include "def.v"

module mixer(
    input        clk_i,
    input        rst_i,      // btn[0]
    input  [2:0] color_i,
    output reg   clk_div_o,  // divide clk frequency by 256
    output [2:0] rgb_4_o 
);

    reg [7:0] div_cnt;

    // divide clk
    always @(posedge clk_i or posedge rst_i) begin
        if (rst_i == 1'b1)
            div_cnt <= 8'd0;
        else
            div_cnt <= div_cnt + 8'd1;
    end

    always @(posedge clk_i or posedge rst_i) begin
        if (rst_i == 1'b1)
            clk_div_o <= 1'b0;
        else
            if (div_cnt == 8'd127 || div_cnt == 8'd255)
                clk_div_o <= ~clk_div_o;
            else
                clk_div_o <= clk_div_o;
    end

    // Set the output color
    reg [7:0] pwm_b;
    reg [7:0] pwm_g;
    reg [7:0] pwm_r;

    always @(posedge clk_i) begin
        case (color_i)
            `PURPLE: begin
                pwm_b <= `PWM_PURPLE_B;
                pwm_g <= `PWM_PURPLE_G;
                pwm_r <= `PWM_PURPLE_R;
            end
            `CYAN: begin
                pwm_b <= `PWM_CYAN_B;
                pwm_g <= `PWM_CYAN_G;
                pwm_r <= `PWM_CYAN_R;
            end
            `YELLOW: begin
                pwm_b <= `PWM_YELLOW_B;
                pwm_g <= `PWM_YELLOW_G;
                pwm_r <= `PWM_YELLOW_R;
            end
            `CRIMSON: begin
                pwm_b <= `PWM_CRIMSON_B;
                pwm_g <= `PWM_CRIMSON_G;
                pwm_r <= `PWM_CRIMSON_R;
            end
            `RED: begin
                pwm_b <= `PWM_RED_B;
                pwm_g <= `PWM_RED_G;
                pwm_r <= `PWM_RED_R;
            end
            `ORANGE: begin
                pwm_b <= `PWM_ORANGE_B;
                pwm_g <= `PWM_ORANGE_G;
                pwm_r <= `PWM_ORANGE_R;
            end
            `GREEN: begin
                pwm_b <= `PWM_GREEN_B;
                pwm_g <= `PWM_GREEN_G;
                pwm_r <= `PWM_GREEN_R;
            end
            `BLUE: begin
                pwm_b <= `PWM_BLUE_B;
                pwm_g <= `PWM_BLUE_G;
                pwm_r <= `PWM_BLUE_R;
            end
        endcase
    end

    // output rgb
    assign rgb_4_o[2] = (div_cnt < pwm_b) ? 1'b1 : 1'b0;
    assign rgb_4_o[1] = (div_cnt < pwm_g) ? 1'b1 : 1'b0;
    assign rgb_4_o[0] = (div_cnt < pwm_r) ? 1'b1 : 1'b0;

endmodule
