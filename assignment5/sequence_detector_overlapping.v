module sequence_detector_overlapping (
    input wire IN,
    input wire clk,
    input wire rst,
    output reg detected
);
    localparam IDLE = 3'b000,
               S1 = 3'b001,
               S11 = 3'b010,
               S110 = 3'b011,
               S1101 = 3'b100,
               S11010 = 3'b101;

    reg [2:0] cs,ns;

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            cs<=IDLE;
        end
        else begin
            cs<=ns;
        end
    end

    always @(*) begin
        case (cs)
            IDLE: begin
                if (IN) begin
                    ns=S1;
                end
                else begin
                    ns=IDLE;
                end
            end
            S1: begin
                if (IN) begin
                    ns=S11;
                end
                else begin
                    ns=IDLE;
                end
            end
            S11: begin
                if (IN) begin
                    ns=S11;
                end
                else begin
                    ns=S110;
                end
            end
            S110: begin
                if (IN) begin
                    ns=S1101;
                end
                else begin
                    ns=IDLE;
                end
            end
            S1101: begin
                if (IN) begin
                    ns=S11;
                end
                else begin
                    ns=S11010;
                end
            end
            S11010: begin
                if (IN) begin
                    ns=S1;
                end
                else begin
                    ns=IDLE;
                end
            end
            default: ns=IDLE;
        endcase
    end

    always @(*) begin
        if (cs==S11010 && IN==1) begin
            detected=1;
        end
        else begin
            detected=0;
        end
    end
endmodule