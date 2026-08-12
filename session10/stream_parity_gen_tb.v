module stream_parity_gen_tb ();
    reg clk;
    reg rst;
    reg serial_in;
    wire parity_out;

    stream_parity_gen DUT (
        .clk(clk),
        .rst(rst),
        .serial_in(serial_in),
        .parity_out(parity_out)
    );

    always #5 clk=~clk;
    
    integer i;
    initial begin
        clk=0; rst=0; serial_in=0;
        @(negedge clk);
        rst=1;

        for (i=0; i<256 ; i=i+1) begin
            send_data(i);
        end
        #20;
        $stop;
    end
   
    task send_data;
        input [7:0] input_data;
        reg parity_calc;
        integer bit_index;

    begin   
        parity_calc=^input_data;

        for(bit_index=0; bit_index<=7; bit_index=bit_index+1) begin
            serial_in=input_data[bit_index];
            @(negedge clk);
        end

        
        #1;

        if (parity_out == parity_calc) begin
            $display("PASS: DATA = %b | Expected = %b | Actual = %b", input_data, parity_calc, parity_out);
        end
        else begin 
            $display("FAIL: DATA = %b | Expected = %b | Actual = %b", input_data, parity_calc, parity_out); 
        end
    end

        
    endtask
endmodule