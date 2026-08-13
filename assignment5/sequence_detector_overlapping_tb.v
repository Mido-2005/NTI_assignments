`timescale 1ns / 1ps

module sequence_detector_overlapping_tb;

    // Inputs
    reg IN;
    reg clk;
    reg rst;

    // Outputs
    wire detected;

    // Instantiate the Unit Under Test (UUT)
    sequence_detector_overlapping uut (
        .IN(IN),
        .clk(clk),
        .rst(rst),
        .detected(detected)
    );

    // Clock generation: 10ns period (100 MHz)
    always #5 clk = ~clk;

    initial begin
        // Initialize Inputs
        clk = 0;
        rst = 0;
        IN  = 0;

        // Apply Reset
        #15;
        rst = 1; // Release Reset

        // --- Overlapping Test Sequence ---
        // Bit stream: 1 -> 1 -> 0 -> 1 -> 0 -> 1 -> 1 -> 0 -> 1 -> 0 -> 1
        // Sequence 1: 1 1 0 1 0 1           (First Detection)
        // Sequence 2:           1 1 0 1 0 1 (Second Detection - overlapping on bit 6)
        
        send_bit(1);
        send_bit(1);
        send_bit(0);
        send_bit(1);
        send_bit(0);
        send_bit(1); // 'detected' should go HIGH (1st Detection)

        // Continuation for Overlapping:
        send_bit(1); // This '1' serves as both the end of 1st pattern and start of 2nd!
        send_bit(0);
        send_bit(1);
        send_bit(0);
        send_bit(1); // 'detected' should go HIGH AGAIN (2nd Detection)

        // Extra bits & End simulation
        send_bit(0);
        send_bit(0);

        #20;
        $stop;
    end

    // Task to drive bit synchronized with falling edge
    task send_bit;
        input bit_val;
        begin
            @(negedge clk);
            IN = bit_val;
        end
    endtask

endmodule