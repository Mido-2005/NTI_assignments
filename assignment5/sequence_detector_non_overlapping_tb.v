`timescale 1ns / 1ps

module sequence_detector_non_overlapping_tb;

    // Inputs
    reg IN;
    reg clk;
    reg rst;

    // Outputs
    wire detected;

    // Instantiate the Unit Under Test (UUT)
    sequence_detector_non_overlapping uut (
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

        // Bit Stream Test Vector: 
        // 1. Correct sequence: 1 -> 1 -> 0 -> 1 -> 0 -> 1  (Should detect)
        // 2. Extra '1' right after: 1                       (Non-overlapping test)
        // 3. Repeat sequence:  1 -> 1 -> 0 -> 1 -> 0 -> 1  (Should detect again)
        
        // --- Test Sequence 1 ---
        send_bit(1);
        send_bit(1);
        send_bit(0);
        send_bit(1);
        send_bit(0);
        send_bit(1); // 'detected' should go HIGH here!

        // --- Extra Bits ---
        send_bit(1);
        send_bit(0);

        // --- Test Sequence 2 ---
        send_bit(1);
        send_bit(1);
        send_bit(0);
        send_bit(1);
        send_bit(0);
        send_bit(1); // 'detected' should go HIGH again!

        #20;
        $stop; // End Simulation
    end

    // Task to send a bit synchronized with falling clock edge
    // to ensure stable setup time before rising edge
    task send_bit;
        input bit_val;
        begin
            @(negedge clk);
            IN = bit_val;
        end
    endtask

endmodule