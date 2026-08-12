module rising_edge_detector (
    input wire clk,
    input wire rst,
    input wire level,
    output reg tick
);
    localparam ZERO = 2'b00,
               EDGE = 2'b01,
               ONE  = 2'b11;
    
    reg [1:0] ns,cs;
    
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            cs<=ZERO;
        end
        else begin
            cs<=ns;
        end
    end

    always @(*) begin
        case(cs)
        ZERO: begin
        if (level) begin
            ns=EDGE;
        end
        else ns=ZERO;
        end
        EDGE: begin
            ns=ONE;
        end
        ONE: if(!level) begin
            ns=ZERO;
        end
        else begin
            ns=ONE;
        end
        default: begin
            ns=ZERO;
        end
        endcase
    end
    always@(*) begin
        if (cs==EDGE) begin
            tick=1'b1;
        end
        else begin
            tick=1'b0;
        end
    end
endmodule