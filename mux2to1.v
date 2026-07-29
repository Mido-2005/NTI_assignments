module mux2to1 (
    input wire I0,
    input wire I1,
    input wire sel,
    output reg out
);
    always @(*) begin
        case(sel)
        1'b0: out=I0;
        1'b1: out=I1;
        endcase
    end
endmodule