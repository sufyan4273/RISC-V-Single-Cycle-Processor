`timescale 1ns / 1ps

module control_unit (
    input  wire [6:0] opcode,      // bits [6:0] of instruction
    output reg        Branch,      
    output reg        MemRead,     
    output reg        MemWrite,    
    output reg        RegWrite,    
    output reg        ALUSrc,      
    output reg [1:0]  MemToReg,    
    output reg [1:0]  ALUOp        
);

    // ALUOp encoding (to send to ALU Control Unit)
    localparam ALU_OP_RTYPE = 2'b10;
    localparam ALU_OP_ITYPE = 2'b00;
    localparam ALU_OP_BRANCH = 2'b01;

    always @(*) begin
        Branch    = 0;
        MemRead   = 0;
        MemWrite  = 0;
        RegWrite  = 0;
        ALUSrc    = 0;
        MemToReg  = 2'b00;
        ALUOp     = 2'b00;

        case (opcode)
            // R-type: 0110011
            7'b0110011: begin
                RegWrite = 1;
                ALUSrc   = 0;
                ALUOp    = ALU_OP_RTYPE;
                MemToReg = 2'b00; // write ALU result to register
            end

            // I-type (ADDI): 0010011
            7'b0010011: begin
                RegWrite = 1;
                ALUSrc   = 1;
                ALUOp    = ALU_OP_ITYPE;
                MemToReg = 2'b00; // ALU result
            end

            // Load (LW): 0000011
            7'b0000011: begin
                RegWrite = 1;
                ALUSrc   = 1;
                MemRead  = 1;
                MemToReg = 2'b01; // from memory
                ALUOp    = ALU_OP_ITYPE;
            end

            // Store (SW): 0100011
            7'b0100011: begin
                ALUSrc   = 1;
                MemWrite = 1;
                ALUOp    = ALU_OP_ITYPE;
            end

            // Branch (BEQ/BNE): 1100011
            7'b1100011: begin
                Branch   = 1;
                ALUSrc   = 0;
                ALUOp    = ALU_OP_BRANCH;
            end

            default: begin

            end
        endcase
    end

endmodule
