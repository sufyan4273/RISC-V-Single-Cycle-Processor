`timescale 1ns / 1ps

module ALU (
    input  wire [31:0] A,           
    input  wire [31:0] B,           
    input  wire [3:0]  ALU_control, // ALU control signal (from ALU Control Unit)
    output reg  [31:0] result,  
    output wire        zero     
);

    // ALU Operations Encoding (you'll match these in ALU Control Unit)
    localparam ADD  = 4'b0000;
    localparam SUB  = 4'b0001;
    localparam AND_ = 4'b0010;
    localparam OR_  = 4'b0011;
    localparam XOR_ = 4'b0100;
    localparam SLL  = 4'b0101;
    localparam SRL  = 4'b0110;
    localparam PASS = 4'b1000;  

    always @(*) begin
        case (ALU_control)
            ADD:   result = A + B;
            SUB:   result = A - B;
            AND_:  result = A & B;
            OR_:   result = A | B;
            XOR_:  result = A ^ B;
            SLL:   result = A << B[4:0];  
            SRL:   result = A >> B[4:0];  
            PASS:  result = A;
            default: result = 32'b0;
        endcase
    end

    // Zero flag 
    assign zero = (result == 0);

endmodule
