module mux4to1_GL (
    input wire I0,
    input wire I1,
    input wire I2,
    input wire I3,
    input wire sel0,
    input wire sel1,
    output wire out
);
wire w0,w1,w2,w3;

assign w0=I0 & ~sel1 & ~sel1;
assign w1=I1 & ~sel1 & sel0;
assign w2=I2 & sel1 & ~sel0;
assign w3=I3 & sel1 & sel0;

assign out=w0 | w1 | w2 | w3;

endmodule