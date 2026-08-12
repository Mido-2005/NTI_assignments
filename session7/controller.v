module controller (
    input wire [2:0] opcode,
    input wire [2:0] phase,
    input wire zero,
    output reg sel, 
    output reg rd , 
    output reg ld_ir  , 
    output reg inc_pc , 
    output reg halt   , 
    output reg ld_pc  , 
    output reg data_e , 
    output reg ld_ac  , 
    output reg wr      
);
    localparam integer HLT=0,
                       SKZ=1,
                       ADD=2,
                       AND=3,
                       XOR=4,
                       LDA=5,
                       STO=6,
                       JMP=7;
    
    localparam integer INST_ADDR=0,
                       INST_FETCH=1,
                       INST_LOAD=2,
                       IDLE=3,
                       OP_ADDR=4,
                       OP_FETCH=5,
                       ALU_OP=6,
                       STORE=7;
    
    always@(*) begin
        case(phase)
            INST_ADDR: begin
                sel = 1'b1;
                rd = 1'b0;
                ld_ir = 1'b0;
                inc_pc = 1'b0;
                halt = 1'b0;
                ld_pc = 1'b0;
                data_e = 1'b0;
                ld_ac = 1'b0;
                wr = 1'b0;
            end
            INST_FETCH: begin
                sel = 1'b1;
                rd = 1'b1;
                ld_ir = 1'b0;
                inc_pc = 1'b0;
                halt = 1'b0;
                ld_pc = 1'b0;
                data_e = 1'b0;
                ld_ac = 1'b0;
                wr = 1'b0;
            end
            INST_LOAD: begin
                sel = 1'b1;
                rd = 1'b1;
                ld_ir = 1'b1;
                inc_pc = 1'b0;
                halt = 1'b0; 
                ld_pc =  1'b0; 
                data_e =  1'b0;
                ld_ac = 1'b0; 
                wr =  1'b0; 
            end
            IDLE: begin
                sel = 1'b1;
                rd = 1'b1;
                ld_ir = 1'b1;
                inc_pc = 1'b0;
                halt = 1'b0;
                ld_pc = 1'b0;
                data_e = 1'b0;
                ld_ac = 1'b0;
                wr = 1'b0;
            end
            OP_ADDR: begin
                sel = 1'b0;
                rd = 1'b0;
                ld_ir = 1'b0;
                inc_pc = 1'b1;
                halt = (opcode == HLT) ? 1'b1 : 1'b0;
                ld_pc = 1'b0;
                data_e = 1'b0;
                ld_ac = 1'b0;
                wr = 1'b0;
            end
            OP_FETCH: begin
                sel = 1'b0;
                rd = (opcode==ADD || opcode==AND || opcode==XOR || opcode==LDA) ? 1'b1 : 1'b0;
                ld_ir = 1'b0;
                inc_pc = 1'b0;
                halt = 1'b0;
                ld_pc = 1'b0;
                data_e = 1'b0;
                ld_ac = 1'b0;
                wr = 1'b0;
            end
            ALU_OP: begin
                sel = 1'b0;
                rd = (opcode==ADD || opcode==AND || opcode==XOR || opcode==LDA) ? 1'b1 : 1'b0;
                ld_ir = 1'b0;
                inc_pc = (opcode==SKZ && zero) ? 1'b1 : 1'b0;
                halt = 1'b0;
                ld_pc = (opcode==JMP) ? 1'b1 : 1'b0;
                data_e = (opcode==STO) ? 1'b1 : 1'b0;
                ld_ac = 1'b0;
                wr =  1'b0;
            end
            STORE: begin
                sel = 1'b0;
                rd = (opcode==ADD || opcode==AND || opcode==XOR || opcode==LDA) ? 1'b1 : 1'b0;
                ld_ir = 1'b0;
                inc_pc = 1'b0;
                halt = 1'b0;
                ld_pc = (opcode==JMP) ? 1'b1 : 1'b0;
                data_e = (opcode==STO) ? 1'b1 : 1'b0;
                ld_ac = (opcode==ADD || opcode==AND || opcode==XOR || opcode==LDA) ? 1'b1 : 1'b0;
                wr = (opcode==STO) ? 1'b1 : 1'b0;
            end
        endcase
    end
endmodule