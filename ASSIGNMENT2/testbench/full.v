module testbench;
    reg c, d, cin; 
    wire finalsum, cout;
    fulladder inst1(.c(c),.d(d),.cin(cin),.finalsum(finalsum),.cout(cout));
    initial begin
        $dumpfile("full.vcd");
        $dumpvars(0,testbench);
        c=0; d=0; cin=0; #10;
        c=0; d=0; cin=1; #10;
        c=0; d=1; cin=0; #10;
        c=0; d=1; cin=1; #10;
        c=1; d=0; cin=0; #10;
        c=1; d=0; cin=1; #10;
        c=1; d=1; cin=0; #10;
        c=1; d=1; cin=1; #10;
        $finish;
    end
endmodule    


