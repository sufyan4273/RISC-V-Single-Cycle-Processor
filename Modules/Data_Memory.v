`timescale 1ns / 1ps

module data_memory (
    input  wire        clk,          
    input  wire        MemWrite,     
    input  wire [31:0] address,      
    input  wire [31:0] write_data,   
    output wire [31:0] read_data     
);

    reg [31:0] memory [0:255];
    integer i;

    // initialize memory to zero by default
    initial begin
        for (i = 0; i < 256; i = i + 1)
            memory[i] = 32'b0;
    end

    // write operation, that happends with posedge of clk
    always @(posedge clk) begin
        if (MemWrite)
            memory[address[9:2]] <= write_data;
    end

    // Read operation that is combinational
    assign read_data = memory[address[9:2]];

endmodule
