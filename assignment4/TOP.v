module TOP_module (
    input wire clk,
    input wire rst,
    input wire hold,
    output reg [3:0] out
);
    wire clk_div;

    clk_divider U0 (
        .clk_in(clk),
        .rst(rst),
        .clk_out(clk_div)
    );

    rotate_reg U1 (
        .clk(clk_div),
        .rst(rst),
        .hold(hold),
        .out(out)
    );

endmodule