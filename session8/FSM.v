module FSM (
    input wire a,
    input wire b,
    input wire clk,
    input wire rst,
    output reg y0,
    output reg y1
);
    localparam S0 = 2'b00,
               S1 = 2'b01,
               S2 = 2'b10;

    reg [1:0] current_state, next_state;

    //state_transition
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            current_state <= S0;
        end
        else begin
            current_state <= next_state;
        end
    end


    //next_state_logic
    always @(*) begin
        next_state=S0;
        case(current_state)
        S0: begin
            if(a&&!b) begin
                next_state=S1;
            end
            else if (a&&b) begin
                next_state=S2;
            end
            else begin
                next_state=S0;
            end
        end
        S1: begin
            if (a) begin
                next_state=S0;
            end
            else begin
                next_state=S1;
            end
        end
        S2: begin
            next_state=S0;
        end
        default: next_state=S0;
        endcase
    end

    //output_logic
    always @(*) begin
        case (current_state)
        S0: begin
            y1=1; y0=0;
        end
        S1: begin
            y1=1; y0=0;
        end
        S2: begin
            y0=1; y1=0;
        end
        default: begin
            y0=0; y1=1;
        end
        endcase
    end
                
endmodule