module rising_edge_detector_mealy (
    input wire clk,
    input wire rst,
    input wire level,
    output reg tick
);
    localparam ZERO = 1'b0,
               ONE  = 1'b1;
    
    reg ns,cs;
    
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            cs<=ZERO;
        end
        else begin
            cs<=ns;
        end
    end

    always@(*) begin
        case(cs)
          ZERO: begin
            if (level) begin
                ns=ONE;
            end
            else begin
                ns=ZERO;
            end
          end
          ONE:begin
            if(!level) begin
                ns=ZERO;
            end
            else begin
                ns=ONE;
            end
          end
          default: begin
            ns=ZERO;
          end
        endcase
    end


    always@(*) begin
        if(cs==ZERO && level) begin
           tick='b1; 
        end
        else begin
            tick=1'b0;
        end
    end
endmodule