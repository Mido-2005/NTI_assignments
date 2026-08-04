module shift_reg_tb ();
    reg IN;
    reg clk;
    reg rst;
    wire [3:0] OUT;

    shift_reg uut (
        .IN(IN),
        .clk(clk),
        .rst(rst),
        .OUT(OUT)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        IN = 0;

        #10 rst = 0;
        #10 rst = 1;
        #10 IN = 1; 
        #10 IN = 0; 
        #10 IN = 1; 
        #10 IN = 1; 
        #10 IN = 0; 

        #20 $stop;
    end  
endmodule