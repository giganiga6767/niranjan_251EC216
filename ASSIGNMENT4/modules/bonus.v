module bonus(
    input clk,
    input rst,
    input write_enable,
    input [3:0] write_address,
    input [3:0] read_address1,
    input [3:0] read_address2,
    input [2:0] alu_op,
    input [7:0] final_write_data
); 

    wire [7:0] rf_to_alu_in1;
    wire [7:0] rf_to_alu_in2;
    wire [7:0] alu_result_out;
    wire carry_flag_out;

    register_file rf_inst (
        .clk(clk),
        .rst(rst),
        .write_enable(write_enable),
        .write_address(write_address),
        .write_data(final_write_data), 
        .read_address1(read_address1),
        .read_address2(read_address2),
        .read_data1(rf_to_alu_in1),    
        .read_data2(rf_to_alu_in2)     
    );

    alu alu_inst (
        .in1(rf_to_alu_in1),           
        .in2(rf_to_alu_in2),           
        .alu_op(alu_op),
        .result(alu_result_out),
        .carry_flag(carry_flag_out)
    );

endmodule