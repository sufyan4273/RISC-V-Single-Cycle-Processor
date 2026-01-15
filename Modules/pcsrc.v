`timescale 1ns / 1ps

module pc_src_mux (
    input  wire [31:0] pc_plus_4,       
    input  wire [31:0] branch_target,   
    input  wire        Branch,          // control signal if branch is taken
    output wire [31:0] next_pc          
);
    assign next_pc = (Branch) ? branch_target : pc_plus_4;

endmodule
