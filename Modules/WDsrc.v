`timescale 1ns / 1ps

module wb_mux (
    input  wire [31:0] alu_result,    
    input  wire [31:0] mem_data,      
    input  wire [31:0] pc_plus_4,     
    input  wire [1:0]  MemToReg,      // Control signal 
    output wire [31:0] write_data     
);

    // MemToReg encoding:
    // 00 -> ALU result
    // 01 -> Data Memory read data
    // 10 -> PC + 4 (for JAL/JALR, optional)

    assign write_data = (MemToReg == 2'b00) ? alu_result :
                        (MemToReg == 2'b01) ? mem_data   :
                        (MemToReg == 2'b10) ? pc_plus_4  :
                        32'b0;

endmodule
