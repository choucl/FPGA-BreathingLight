`include "def.v"

module fsm (
    input            clk_div_i,
    input            rst_i,
    output reg [2:0] color_o
);

    parameter red    = 3'd0,
              orange = 3'd1,
              yellow = 3'd2,
              green  = 3'd3,
              blue   = 3'd4,
              purple = 3'd5;
              
    reg [2:0] cstate;

    always @(clk_div_i or rst_i) begin
        if (rst_i == 1) begin
            cstate <= 0; 
        end else begin
            if (cstate == 3'd5) begin
                cstate <= 0;
            end else begin
                cstate <= cstate + 1;
            end
        end
    end

    always @(*) begin  // comb circuit
        case (cstate)
            red:    color_o = RED;
            orange: color_o = ORANGE;
            yellow: color_o = YELLOW;
            green:  color_o = GREEN;
            blue:   color_o = BLUE;
            purple: color_o = PURPLE;
        endcase
    end

endmodule
