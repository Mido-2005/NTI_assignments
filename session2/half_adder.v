module half_adder (
    input wire A,
    input wire B,
    output wire sum,
    output wire cout
);
    assign {cout,sum}=A+B;
endmodule