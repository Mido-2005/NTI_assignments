module mux4to1_struct (
    input wire I0,
    input wire I1,
    input wire I2,
    input wire I3,
    input wire sel0,
    input wire sel1,
    output wire out
);

    wire w0,w1;

    mux2to1 U0 (
        .I0(I0),
        .I1(I2),
        .sel(sel1),
        .out(w0)
    );

    mux2to1 U1 (
        .I0(I1),
        .I1(I3),
        .sel(sel1),
        .out(w1)
    );
    
    mux2to1 U2 (
        .I0(w0),
        .I1(w1),
        .sel(sel0),
        .out(out)
    );

endmodule