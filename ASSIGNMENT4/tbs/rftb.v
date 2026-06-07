`timescale 1ns / 1ps

module tb_register_file();

    // Inputs
    reg clk;
    reg rst;
    reg write_enable;
    reg [3:0] write_address;
    reg [7:0] write_data;
    reg [3:0] read_address1;
    reg [3:0] read_address2;

    // Outputs
    wire [7:0] read_data1;
    wire [7:0] read_data2;

    // Instantiate the Unit Under Test (UUT)
    register_file uut (
        .clk(clk), 
        .rst(rst), 
        .write_enable(write_enable), 
        .write_address(write_address), 
        .write_data(write_data), 
        .read_address1(read_address1), 
        .read_address2(read_address2), 
        .read_data1(read_data1), 
        .read_data2(read_data2)
    );

    // Clock generation (10ns period) - Fixed Race Condition
    initial clk = 0; 
    always #5 clk = ~clk;

    initial begin
        // Setup waveform dumping
        $dumpfile("register_file.vcd");
        $dumpvars(0, tb_register_file);

        // Initialize Inputs (Except clk)
        rst = 0;
        write_enable = 0;
        write_address = 0;
        write_data = 0;
        read_address1 = 0;
        read_address2 = 0;

        // 1. Test Reset (clears all registers)
        $display("Applying Reset...");
        rst = 1;
        #10;
        rst = 0;

        // 2. Test Register Write
        $display("Writing to registers...");
        
        // Write 5 to R1
        write_enable = 1;
        write_address = 4'd1;
        write_data = 8'd5;
        #10; // Wait for clock edge
        
        // Write 3 to R2
        write_address = 4'd2;
        write_data = 8'd3;
        #10; // Wait for clock edge
        
        write_enable = 0; // Turn off write

        // 3. Test Register Read (Async)
        $display("Reading from registers...");
        read_address1 = 4'd1; // Read R1
        read_address2 = 4'd2; // Read R2
        #10;
        
        $display("R1 = %d, R2 = %d", read_data1, read_data2);

        // End simulation
        #20;
        $finish;
    end
endmodule