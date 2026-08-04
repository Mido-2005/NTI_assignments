module full_adder_data_flow (
    input wire A,
    input wire B,
    input wire cin,
    output wire sum,
    output wire cout
);
    assign {cout,sum}=A+B+cin;
endmodule