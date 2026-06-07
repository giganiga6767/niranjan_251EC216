`timescale 1ns / 1ps

module tb_alu();

    // Inputs
    reg [7:0] in1;
    reg [7:0] in2;
    reg [2:0] alu_op;

    // Outputs
    wire [7:0] result;
    wire carry_flag;

    // Instantiate the Unit Under Test (UUT)
    alu uut (
        .in1(in1), 
        .in2(in2), 
        .alu_op(alu_op), 
        .result(result), 
        .carry_flag(carry_flag)
    );

    initial begin
        // Setup waveform dumping
        $dumpfile("alu.vcd");
        $dumpvars(0, tb_alu);

        // Initialize Inputs
        in1 = 0;
        in2 = 0;
        alu_op = 0;

        // Monitor changes in the console
        $monitor("Time = %0t | in1 = %d, in2 = %d, OP = %b | result = %d, carry = %b", 
                 $time, in1, in2, alu_op, result, carry_flag);

        // Test Setup: Use the values from your Part C integration challenge
        in1 = 8'd5;
        in2 = 8'd3;
        #10;

        // Test ADD (011)
        $display("\nTesting ADD:");
        alu_op = 3'b011; 
        #10;

        // Test SUB (100)
        $display("\nTesting SUB:");
        alu_op = 3'b100;
        #10;

        // Test XOR (101)
        $display("\nTesting XOR:");
        alu_op = 3'b101;
        #10;

        // Test INC (110)
        $display("\nTesting INC:");
        alu_op = 3'b110;
        #10;
        
        // Test Overflow on ADD (255 + 5 to trigger carry flag)
        $display("\nTesting Carry Flag with ADD:");
        in1 = 8'd255;
        in2 = 8'd5;
        alu_op = 3'b011; // ADD
        #10;

        // End simulation
        $finish;
    end
endmodule