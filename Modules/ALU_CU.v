`timescale 1ns / 1ps

module ALU_CU (
    input  wire [1:0] ALUOp,        
    input  wire [2:0] funct3,       // instruction [14:12]
    input  wire [6:0] funct7,       // instruction [31:25]
    output reg  [3:0] ALU_control   
);

    // ALU operation encoding (must match your ALU)
    localparam ADD  = 4'b0000;
    localparam SUB  = 4'b0001;
    localparam AND_ = 4'b0010;
    localparam OR_  = 4'b0011;
    localparam XOR_ = 4'b0100;
    localparam SLL  = 4'b0101;
    localparam SRL  = 4'b0110;
    localparam PASS = 4'b1000;  

    always @(*) begin
        case (ALUOp)
            // 00 ? for I-type (addi, lw, sw)
            2'b00: ALU_control = ADD;

            // 01 ? for Branch (beq, bne)
            2'b01: ALU_control = SUB;

            // 10 ? for R-type (add, sub, and, or, xor, sll, srl)
            2'b10: begin
                case (funct3)
                    3'b000: ALU_control = (funct7[5]) ? SUB : ADD;  // add/sub
                    3'b111: ALU_control = AND_;
                    3'b110: ALU_control = OR_;
                    3'b100: ALU_control = XOR_;
                    3'b001: ALU_control = SLL;
                    3'b101: ALU_control = SRL;
                    default: ALU_control = PASS;
                endcase
            end

            default: ALU_control = PASS;
        endcase
    end

endmodule
