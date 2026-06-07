module alu(
    input [7:0] in1,
    input [7:0] in2,
    input [2:0] alu_op,
    output reg [7:0] result,
    output reg carry_flag
);
always @(*) begin
    carry_flag = 1'b0;
    case(alu_op)
        3'b000:result = ~in1;
        3'b001:result = in1&in2;
        3'b010:result = in1|in2;
        3'b011:{carry_flag,result} = in1 +in2;
        3'b100:{carry_flag,result} = in1-in2;
        3'b101:result = in1^in2;
        3'b110:{carry_flag,result} = in1+1;
        default: result = 8'b0;
    endcase
    end
endmodule
        
