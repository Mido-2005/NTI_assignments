`timescale 1ns/1ps

module FSM_tb ();
    reg a;
    reg b;
    reg clk;
    reg rst;
    wire y0;
    wire y1;

    FSM DUT (
        .a(a),
        .b,
        input wire clk,
        input wire rst,
        output reg y0,
        output reg y1
    );
endmodule