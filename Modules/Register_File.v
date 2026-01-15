`timescale 1ns / 1ps

module register_file (
    input  wire        clk,          // Clock
    input  wire        rst,          // Active-high synchronous reset
    input  wire        RegWrite,     // Control signal to enable register write
    input  wire [4:0]  rs1,          // Address of source register 1
    input  wire [4:0]  rs2,          // Address of source register 2
    input  wire [4:0]  rd,           // Address of destination register
    input  wire [31:0] write_data,   // Data to write into rd
    output wire [31:0] read_data1,   // Output data of rs1
    output wire [31:0] read_data2    // Output data of rs2
);

    // 32 registers, each 32 bits wide
    reg [31:0] regs [0:31];
    integer i;

    // Initialize all registers to zero
    always @(posedge clk) begin
        if (rst) begin
            for (i = 0; i < 32; i = i + 1)
                regs[i] <= 32'b0;
        end 
        else begin
            // Write operation (x0 is always 0)
            if (RegWrite && (rd != 0))
                regs[rd] <= write_data;
        end
    end

    // Continuous read (combinational)
    assign read_data1 = (rs1 == 0) ? 32'b0 : regs[rs1];
    assign read_data2 = (rs2 == 0) ? 32'b0 : regs[rs2];

endmodule
