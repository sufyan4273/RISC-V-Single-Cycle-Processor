`timescale 1ns / 1ps

module branch_adder (
    input  wire [31:0] pc_in,        // current PC value
    input  wire [31:0] imm_in,       // immediate from imm_gen 
    output wire [31:0] branch_target // branch address = PC + immediate 
);

    assign branch_target = pc_in + imm_in;

endmodule
