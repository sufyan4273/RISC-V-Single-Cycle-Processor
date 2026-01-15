`timescale 1ns / 1ps

module alu_src_mux (
    input  wire [31:0] read_data2,   
    input  wire [31:0] imm_data,     
    input  wire        ALUSrc,       // control signal from control unit
    output wire [31:0] alu_input2    
);

    assign alu_input2 = (ALUSrc) ? imm_data : read_data2;

endmodule
