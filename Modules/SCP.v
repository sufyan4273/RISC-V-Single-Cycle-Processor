// Single Cycle Processor 
// Muhammad Sufyan (Computer Engineering)
// Ghulam Ishaq Khan Institute
`timescale 1ns / 1ps

module SCP (
    input  wire clk,
    input  wire rst
);

// ========================= Wire/Reg Declarations =========================

// Program Counter & Instruction
wire [31:0] pc_out;
wire [31:0] instruction;

// Instruction decode fields
wire [6:0] opcode;
wire [4:0] rd;
wire [2:0] funct3;
wire [4:0] rs1;
wire [4:0] rs2;
wire [6:0] funct7;

// Control signals
wire Branch, MemRead, MemWrite, RegWrite, ALUSrc;
wire [1:0] MemToReg, ALUOp;

// Immediate
wire [31:0] imm_out;

// Register File
wire [31:0] read_data1, read_data2, write_data_rf;

// ALU
wire [31:0] alu_input2, alu_result;
wire zero_flag;
wire [3:0] ALU_control;

// Data Memory
wire [31:0] mem_read_data;

// PC / Branch
wire [31:0] pc_plus_4, branch_target, next_pc;
wire BranchTaken;

// ========================= Instruction Decode Fields =========================
assign opcode = instruction[6:0];
assign rd     = instruction[11:7];
assign funct3 = instruction[14:12];
assign rs1    = instruction[19:15];
assign rs2    = instruction[24:20];
assign funct7 = instruction[31:25];

// ========================= PC and Instruction Fetch =========================

// Program Counter
pc u_pc (
    .clk(clk),
    .rst(rst),
    .pc_in(next_pc),
    .pc_out(pc_out)
);

// Instruction Memory
instruction_memory u_imem (
    .address(pc_out),
    .instruction(instruction)
);

// ========================= Decode Stage =========================

// Control Unit
control_unit u_ctrl (
    .opcode(opcode),
    .Branch(Branch),
    .MemRead(MemRead),
    .MemWrite(MemWrite),
    .RegWrite(RegWrite),
    .ALUSrc(ALUSrc),
    .MemToReg(MemToReg),
    .ALUOp(ALUOp)
);

// ========================= Immediate Generation =========================
Extend u_extend (
    .instruction(instruction),
    .imm_out(imm_out)
);

// ========================= Register File =========================
register_file u_regfile (
    .clk(clk),
    .rst(rst),
    .RegWrite(RegWrite),
    .rs1(rs1),
    .rs2(rs2),
    .rd(rd),
    .write_data(write_data_rf),
    .read_data1(read_data1),
    .read_data2(read_data2)
);

// ========================= ALU Input Selection =========================
alu_src_mux u_alu_src (
    .read_data2(read_data2),
    .imm_data(imm_out),
    .ALUSrc(ALUSrc),
    .alu_input2(alu_input2)
);

// ========================= ALU and ALU Control =========================
ALU_CU u_alucu (
    .ALUOp(ALUOp),
    .funct3(funct3),
    .funct7(funct7),
    .ALU_control(ALU_control)
);

ALU u_alu (
    .A(read_data1),
    .B(alu_input2),
    .ALU_control(ALU_control),
    .result(alu_result),
    .zero(zero_flag)
);

// ========================= Data Memory =========================
data_memory u_dmem (
    .clk(clk),
    .MemWrite(MemWrite),
    .address(alu_result),
    .write_data(read_data2),
    .read_data(mem_read_data)
);

// ========================= Write-Back MUX =========================
wb_mux u_wb (
    .alu_result(alu_result),
    .mem_data(mem_read_data),
    .pc_plus_4(pc_plus_4),
    .MemToReg(MemToReg),
    .write_data(write_data_rf)
);

// ========================= PC Adder & Branching =========================
pc_adder u_pc_adder (
    .pc_in(pc_out),
    .pc_next(pc_plus_4)
);

branch_adder u_branch_adder (
    .pc_in(pc_out),
    .imm_in(imm_out),
    .branch_target(branch_target)
);

// ========================= Branch Decision =========================
branch_decision_unit u_branch_decision (
    .Branch(Branch),
    .funct3(funct3),
    .zero(zero_flag),
    .alu_result(alu_result),
    .BranchTaken(BranchTaken)
);

// ========================= PC Source Selection =========================
pc_src_mux u_pc_src (
    .pc_plus_4(pc_plus_4),
    .branch_target(branch_target),
    .Branch(BranchTaken),
    .next_pc(next_pc)
);

endmodule
