module traffic_light_fsm #(
    parameter CLK_FREQ    = 100_000_000,
    parameter GREEN_TIME  = 5,
    parameter YELLOW_TIME = 2
)(
    input        clk,
    input        rst_n,
    output reg [2:0] road_A,
    output reg [2:0] road_B,
    output reg [2:0] road_C,
    output reg [2:0] road_D
);
    localparam RED=3'b100,YELLOW=3'b010,GREEN=3'b001;
    localparam S_AG=3'd0,S_AY=3'd1,S_BG=3'd2,S_BY=3'd3,
               S_CG=3'd4,S_CY=3'd5,S_DG=3'd6,S_DY=3'd7;

    reg [26:0] clk_div;
    reg        clk_1hz;
    reg [3:0]  timer;
    reg [2:0]  state, next_state;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin clk_div<=0; clk_1hz<=0; end
        else if (clk_div==CLK_FREQ/2-1)
            begin clk_div<=0; clk_1hz<=~clk_1hz; end
        else clk_div<=clk_div+1;
    end

    always @(posedge clk_1hz or negedge rst_n) begin
        if (!rst_n) begin state<=S_AG; timer<=GREEN_TIME; end
        else if (timer==0) begin
            state<=next_state;
            timer<=(next_state==S_AY||next_state==S_BY||
                    next_state==S_CY||next_state==S_DY)
                    ? YELLOW_TIME : GREEN_TIME;
        end else timer<=timer-1;
    end

    always @(*) begin
        case(state)
            S_AG:next_state=S_AY; S_AY:next_state=S_BG;
            S_BG:next_state=S_BY; S_BY:next_state=S_CG;
            S_CG:next_state=S_CY; S_CY:next_state=S_DG;
            S_DG:next_state=S_DY; S_DY:next_state=S_AG;
            default:next_state=S_AG;
        endcase
    end

    always @(*) begin
        road_A=RED;road_B=RED;road_C=RED;road_D=RED;
        case(state)
            S_AG:road_A=GREEN;  S_AY:road_A=YELLOW;
            S_BG:road_B=GREEN;  S_BY:road_B=YELLOW;
            S_CG:road_C=GREEN;  S_CY:road_C=YELLOW;
            S_DG:road_D=GREEN;  S_DY:road_D=YELLOW;
        endcase
    end
endmodule
