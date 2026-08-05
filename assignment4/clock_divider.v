module clk_divider_2hz (
    input clk_in,    // 50 MHz input clock
    input rst,       // Active-high synchronous reset
    output reg clk_out // 2 Hz output clock
);

    // Calculate max count: (Input_Freq / (2 * Output_Freq)) - 1
    // 50,000,000 / (2 * 2) - 1 = 12,499,999
    reg [25:0] count;

    always @(posedge clk_in) begin
        if (rst) begin
            count <= 26'd0;
            clk_out <= 1'b0;
        end else begin
            if (count == 26'd12499999) begin
                count <= 26'd0;
                clk_out <= ~clk_out; // Toggle output
            end else begin
                count <= count + 26'd1;
            end
        end
    end
endmodule