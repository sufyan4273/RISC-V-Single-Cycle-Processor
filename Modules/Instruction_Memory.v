`timescale 1ns / 1ps
module instruction_memory (
    input  wire [31:0] address,       // Address from Program Counter
    output wire [31:0] instruction    // Output instruction
);

    // Instruction memory: 256 words (32-bit each)
    reg [31:0] memory [0:255];

    // Initialize with instructions (you can later load from a file)
   initial begin
        memory[0] = 32'h00000093;  // addi x1, x0, 0   ; x1 = 0
   memory[1] = 32'h00500113;  // addi x2, x0, 5   ; x2 = 5
   memory[2] = 32'h00a00193;  // addi x3, x0, 10  ; x3 = 10
   memory[3] = 32'h00310233;  // add  x4, x2, x3  ; x4 = 15
   memory[4] = 32'h404182b3;  // sub  x5, x3, x4  ; x5 = -5
   memory[5] = 32'h0051a023;  // sw   x5, 0(x3)   ; store -5 at mem[10]
   memory[6] = 32'h0001a303;  // lw   x6, 0(x3)   ; load back into x6
   memory[7] = 32'h00000013;  // nop (addi x0,x0,0)

    end


    assign instruction = memory[address[9:2]];  


endmodule
