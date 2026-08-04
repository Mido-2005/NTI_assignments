module decoder2to4_tb ();
    reg A;
    reg B;
    reg En;
    wire [3:0] F;

    decoder2to4 DUT (
        .A(A),
        .B(B),
        .En(En),
        .F(F)
    );

    initial begin
        A=0; B=0; En=0;
        #10
        A=0; B=0; En=1;
        #10
        A=0; B=1;
        #10
        A=1; B=0;
        #10
        A=1; B=1;
        #10;
        $stop;
    end
endmodule