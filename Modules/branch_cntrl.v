`timescale 1ns / 1ps

module branch_decision_unit (
    input  wire        Branch,       
    input  wire [2:0]  funct3,       
    input  wire        zero,         
    input  wire [31:0] alu_result,   
    output reg         BranchTaken   
);

    always @(*) begin
        if (Branch) begin
            case (funct3)
                3'b000: BranchTaken = zero;          //  branch if equal
                3'b001: BranchTaken = ~zero;         // branch if not equal
                3'b100: BranchTaken = (alu_result[31]); // if result < 0
                3'b101: BranchTaken = ~alu_result[31];  // if result >= 0
                default: BranchTaken = 0;            
            endcase
        end 
        else begin
            BranchTaken = 0; 
        end
    end

endmodule
