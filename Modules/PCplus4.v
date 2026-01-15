`timescale 1ns / 1ps

module pc_adder (
    input  wire [31:0] pc_in,      // Current PC value
    output wire [31:0] pc_next     // Next PC value (PC + 4)
);

    assign pc_next = pc_in + 32'd4;

endmodule
