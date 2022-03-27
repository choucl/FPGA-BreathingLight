/* def.v
 *
 */
`ifndef _DEF_V_

// input sw for each color
`define PURPLE              3'd0
`define CYAN                3'd1
`define YELLOW              3'd2
`define CRIMSON             3'd3
`define RED                 3'd4
`define ORANGE              3'd5
`define GREEN               3'd6
`define BLUE                3'd7

// pwm values
`define PWM_PURPLE_B        8'd255
`define PWM_PURPLE_G        8'd31
`define PWM_PURPLE_R        8'd127

`define PWM_CYAN_B          8'd255
`define PWM_CYAN_G          8'd255
`define PWM_CYAN_R          8'd0

`define PWM_YELLOW_B        8'd0
`define PWM_YELLOW_G        8'd255
`define PWM_YELLOW_R        8'd255

`define PWM_CRIMSON_B       8'd255
`define PWM_CRIMSON_G       8'd0
`define PWM_CRIMSON_R       8'd255

`define PWM_RED_B           8'd0
`define PWM_RED_G           8'd0
`define PWM_RED_R           8'd255

`define PWM_ORANGE_B        8'd0
`define PWM_ORANGE_G        8'd97
`define PWM_ORANGE_R        8'd255

`define PWM_GREEN_B         8'd0
`define PWM_GREEN_G         8'd255
`define PWM_GREEN_R         8'd0

`define PWM_BLUE_B          8'd255
`define PWM_BLUE_G          8'd0
`define PWM_BLUE_R          8'd0

`endif