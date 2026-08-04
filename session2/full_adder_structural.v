module full_adder_structural (
    input wire A,
    input wire B,
    input wire cin,
    output wire sum,
    output wire cout
);

wire w1,w2,w3;
half_adder U0 (.A(A),.B(B),.sum(w1),.cout(w2));
half_adder U1 (.A(w1),.B(cin),.sum(sum),.cout(w3));

assign cout=w3|w2;

endmodule