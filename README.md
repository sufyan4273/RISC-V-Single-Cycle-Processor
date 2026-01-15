# 32-Bit Single-Cycle RISC-V Processor

![Language](https://img.shields.io/badge/Language-Verilog-blue) ![Tool](https://img.shields.io/badge/Tool-Xilinx%20Vivado-red) ![Architecture](https://img.shields.io/badge/Architecture-RISC--V-green)

## 📌 Overview
This project implements a **32-bit Single-Cycle RISC-V Processor** in Verilog HDL. The design executes fundamental R-type, I-type, and memory access instructions in a single clock cycle. The processor was verified through simulation in Xilinx Vivado, demonstrating correct execution of arithmetic, load/store, and branch instructions.

## 📂 Repository Structure
```text
├── Modules/                  # Verilog Source files and Testbenches
├── Documentation/            # Project Report and images
│   ├── Project Report.pdf
│   └── Screenshots/          # Verification screenshots
└── README.md
## ⚙️ Architecture

The processor integrates key datapath components including the ALU, Control Unit, Instruction Memory, and Register File.

**Datapath Diagram:**

### Key Modules

* **Program Counter:** Manages sequential execution and branching.
* **Instruction Memory:** Stores program instructions.
* **Register File:** Contains 32-bit registers for data storage.
* **ALU:** Performs arithmetic and logical operations.
* **Control Unit:** Decodes Opcode to control signal flow.
* **Immediate Generator:** Extends 12-bit immediates to 32-bit format.

## 💻 Implemented ISA

The processor supports the following instruction types:

## 📊 Simulation & Verification

The functionality was verified using the following steps:

### 1. Test Code & Machine Code

The following assembly code (and corresponding machine code) was hard-coded into the Instruction Memory:

*Verilog Implementation of Instruction Memory:*

### 2. Expected Results

Based on the code above, the expected register values were calculated for verification:

### 3. Actual Simulation Output

The simulation matches the expected values exactly.

**Console Output ($monitor):**

**Waveform Analysis:**

## 🚀 How to Run

1. Clone this repository.
2. Open **Xilinx Vivado**.
3. Add the files from the `Modules` folder as design sources.
4. Set the testbench file as the top module.
5. Run Behavioral Simulation.

## 👥 Credits

* **Author:** Muhammad Sufyan
* **Institution:** Ghulam Ishaq Khan Institute of Engineering and Technology

```

```
