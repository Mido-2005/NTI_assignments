module rising_edge_detector_tb ();
    reg clk;
    reg rst;
    reg level;
    wire tick;

    rising_edge_detector DUT  (
        .clk(clk),
        .rst(rst),
        .level(level),
        .tick(tick)
    );

    always #5 clk=~clk;

    initial begin
        clk=0; rst=0; level=0;
        @(negedge clk);
        rst=1;
        @(negedge clk);
        level=1;
        @(negedge clk);
        level=0;
        @(negedge clk);

        $stop;
    end 
endmodule