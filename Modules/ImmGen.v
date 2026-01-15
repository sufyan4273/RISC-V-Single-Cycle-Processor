`timescale 1ns / 1ps

module Extend (
    input  wire [31:0] instruction,   // 32-bit instruction
    output reg  [31:0] imm_out        // 32-bit sign-extended immediate
);

    wire [6:0] opcode;
    assign opcode = instruction[6:0];

    always @(*) begin
        case (opcode)
            // I-type 
            7'b0010011,    // ADDI
            7'b0000011:    // LW
                imm_out = {{20{instruction[31]}}, instruction[31:20]};

            // S-type 
            7'b0100011:
                imm_out = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};

            // B-type 
            7'b1100011:
                imm_out = {{19{instruction[31]}}, instruction[31], instruction[7],
                            instruction[30:25], instruction[11:8], 1'b0};

            // Default (R-type or unknown opcode)
            default:
                imm_out = 32'b0;
        endcase
    end

endmodule
