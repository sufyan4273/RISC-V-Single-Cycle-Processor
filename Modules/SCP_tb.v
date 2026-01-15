`timescale 1ns / 1ps

module SCP_tb;
    reg clk;
    reg rst;

    SCP uut (
        .clk(clk),
        .rst(rst)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
    
        rst = 1;
        #20;
        rst = 0;
        #150;  
        $finish;
    end
initial begin
        $display("Time\tPC\tRS1\tRS2\tRD\tALU_Result");
        $monitor("%0t\t%h\t%0d\t%0d\t%0d\t%h",
                 $time,
                 uut.pc_out,
                 uut.rs1,
                 uut.rs2,
                 uut.rd,
                 uut.alu_result);
    end



endmodule
