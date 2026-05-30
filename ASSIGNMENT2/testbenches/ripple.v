`timescale 1ns / 1ps

module tb_mag_comp_4bit_comb;

    // 1. Declare testbench signals
    reg [3:0] A;
    reg [3:0] B;
    
    wire O_gt;
    wire O_eq;
    wire O_lt;

    // 2. Instantiate the Unit Under Test (UUT)
    mag_comp_4bit_comb uut (
        .A(A), 
        .B(B), 
        .O_gt(O_gt), 
        .O_eq(O_eq), 
        .O_lt(O_lt)
    );

    // 3. Apply Test Vectors
    initial begin
        // Set up the monitor to automatically print whenever A or B changes
        $monitor("Time=%0t | A = %b (%2d) | B = %b (%2d) || Output: >(%b) ==(%b) <(%b)", 
                 $time, A, A, B, B, O_gt, O_eq, O_lt);
        $dumpfile("rippleout.vcd");
        $dumpvars(0,tb_mag_comp_4bit_comb);

        // Test Case 1: Both are Zero (Equality check)
        A = 4'b0000; B = 4'b0000;
        #10; 

        // Test Case 2: A is greater than B (Difference at MSB)
        A = 4'b1000; B = 4'b0111; // 8 vs 7
        #10; 

        // Test Case 3: A is less than B 
        A = 4'b0011; B = 4'b1100; // 3 vs 12
        #10; 

        // Test Case 4: A is greater than B (Difference at LSB)
        A = 4'b1011; B = 4'b1010; // 11 vs 10
        #10; 

        // Test Case 5: Exact equality (High bits)
        A = 4'b1111; B = 4'b1111; // 15 vs 15
        #10; 
        
        // Test Case 6: A is less than B (Difference at LSB)
        A = 4'b0101; B = 4'b0110; // 5 vs 6
        #10;

        // End the simulation
        $finish;
    end

endmodule