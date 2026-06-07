module register_file(
    input clk,
    input rst,
    input write_enable,
    input [3:0] write_address,
    input [7:0] write_data,
    input [3:0] read_address1,
    input [3:0] read_address2,
    output [7:0] read_data1,
    output [7:0] read_data2
);
integer i;
reg [7:0] rf [15:0];

always @(posedge clk) begin
    if (rst) begin
        for (i = 0; i < 16; i = i + 1) begin
            rf[i] <= 0;
        end
    end  else if (write_enable) begin
        rf[write_address] <= write_data;
    end
end
assign read_data1 = rf[read_address1];
assign read_data2 = rf[read_address2];
endmodule
