module full_adder_gate_level (
    input wire A,
    input wire B,
    input wire cin,
    output wire sum,
    output wire cout
);
    wire w1,w2,w3;

    xor (w1,A,B);
    xor (sum,w1,cin);
    and (w2,cin,w1);
    and (w3,A,B);
    or (cout,w2,w3);

    
endmodule