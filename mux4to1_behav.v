module mux4to1_behav (
    input wire I0,
    input wire I1,
    input wire I2,
    input wire I3,
    input wire sel0,
    input wire sel1,
    output reg out
);

always@(*) begin
    case({sel1,sel0})
    2'b00: out=I0;
    2'b01: out=I1;
    2'b10: out=I2;
    2'b11: out=I3;
    endcase
end

endmodule