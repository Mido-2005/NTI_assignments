module shift_reg (
    input wire IN,
    input wire clk,
    input wire rst,
    output reg [3:0] OUT
);
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            OUT <= 4'b0000;
        end else begin
            OUT <= {IN, OUT[3:1]};
        end
    end
endmodule