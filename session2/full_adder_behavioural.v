module full_adder_behavioural (
    input wire A,
    input wire B,
    input wire cin,
    output reg sum,
    output reg cout
);

always@(A or B or cin) begin
    {cout,sum}=A+B+cin;
end
endmodule