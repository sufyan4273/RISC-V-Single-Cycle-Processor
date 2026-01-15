`timescale 1ns / 1ps

module pc (
    input  wire clk,       // Clock signal
    input  wire rst,       // Active-high synchronous reset
    input  wire [31:0] pc_in,     // Next PC value
    output reg  [31:0] pc_out     // Current PC value
);

    always @(posedge clk) begin
        if (rst)
            pc_out <= 32'b0;        // Reset PC to 0 on reset
        else
            pc_out <= pc_in;        // Update PC every clock cycle
    end

endmodule
