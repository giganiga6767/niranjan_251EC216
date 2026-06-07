`timescale 1ns / 1ps

module tb_bonus();

    // Inputs to drive the bonus module
    reg clk;
    reg rst;
    reg write_enable;
    reg [3:0] write_address;
    reg [3:0] read_address1;
    reg [3:0] read_address2;
    reg [2:0] alu_op;
    
    // MUX Control Signals
    reg [7:0] immediate_data;
    reg use_alu_result;
    wire [7:0] final_write_data;

    // Instantiate the Unit Under Test (UUT)
    bonus uut (
        .clk(clk),
        .rst(rst),
        .write_enable(write_enable),
        .write_address(write_address),
        .read_address1(read_address1),
        .read_address2(read_address2),
        .alu_op(alu_op),
        .final_write_data(final_write_data)
    );

    // Grab the internal ALU result from inside the bonus module!
    wire [7:0] alu_result = uut.alu_result_out;
    
    // The MUX: Feed immediate data (5 or 3) OR the ALU result back to Register File
    assign final_write_data = use_alu_result ? alu_result : immediate_data;

    // Bulletproof clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Part C Simulation Sequence
    initial begin
        $dumpfile("bonus_sim.vcd");
        $dumpvars(0, tb_bonus);

        // Initialize signals
        rst = 1; write_enable = 0; alu_op = 3'b000;
        read_address1 = 0; read_address2 = 0; write_address = 0;
        use_alu_result = 0; immediate_data = 0;
        #10 rst = 0;

        $display("--- Starting Part C Challenge via bonus.v ---");

        // Step 1: Write 5 to R1
        use_alu_result = 0;       // Use immediate data
        immediate_data = 8'd5;
        write_address = 4'd1;
        write_enable = 1;
        #10;
        
        // Step 2: Write 3 to R2
        immediate_data = 8'd3;
        write_address = 4'd2;
        #10;
        write_enable = 0;         // Turn off writing

        // Step 3 & 4: R3 = R1 + R2
        read_address1 = 4'd1;     // Output R1
        read_address2 = 4'd2;     // Output R2
        alu_op = 3'b011;          // ADD Operation
        
        #5;                       // Let combinational logic settle
        
        use_alu_result = 1;       // Flip MUX to route ALU output back in
        write_address = 4'd3;     // Destination: R3
        write_enable = 1;         // Turn writing back on
        #10;
        
        write_enable = 0;         // Turn off writing

        // Verification: Read R3 to confirm the math worked
        #10;
        read_address1 = 4'd3;
        #10;
        $display("Final Result inside R3: %d (Expected: 8)", uut.rf_to_alu_in1);

        #20 $finish;
    end
endmodule