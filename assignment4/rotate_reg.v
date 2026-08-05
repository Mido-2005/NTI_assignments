module rotate_reg # (
    parameter SEED = 4'b1000
) (
    input wire clk,
    input wire rst,
    input wire hold,
    output reg [3:0] out
);
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            out <= SEED;
        end else if (!hold) begin
            out <= {out[0], out[3:1]};
        end
    end
endmodule