module stream_parity_gen (
    input wire clk,
    input wire rst,
    input wire serial_in,
    output reg parity_out
);
    reg [7:0] data;
    reg [3:0] counter;
    wire count_max;

    always @(posedge clk or negedge rst) begin
        if(!rst) begin
            parity_out<=0;
            data<=0;
        end
        else begin
            data[counter] <= serial_in;
            if (count_max) begin
                parity_out<=^{serial_in,data[6:0]};
            end
        end
    end

    always @(posedge clk or negedge rst) begin
        if(!rst) begin
            counter<=4'd0;
        end
        else if (count_max) begin
            counter<=0;
        end
        else begin
            counter<=counter+1;
        end
    end

    assign count_max=(counter==4'd7);
endmodule