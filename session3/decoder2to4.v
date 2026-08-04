module decoder2to4 (
    input wire A,
    input wire B,
    input wire En,
    output reg [3:0] F
);
    always @(*) begin
        if (En) begin
            case ({A,B})
                2'b00: F=4'b0001;
                2'b01: F=4'b0010;
                2'b10: F=4'b0100;
                2'b11: F=4'b1000;
            endcase
        end
        else begin
            F=4'b0000;
        end
    end
endmodule