module testbench();
   reg d1,d2,d0;
     wire a,b,c,d,e,f,g;
    sevenbit inst1(.d2(d2),.d1(d1),.d0(d0),.a(a),.b(b),.c(c),.d(d),.e(e),.f(f),.g(g));
    initial begin
        $dumpfile("output.vcd");
        $dumpvars(0,testbench);
        d0=0; d1=0; d2=0; #10;
        d0=0; d1=0; d2=1; #10;
        d0=0; d1=1; d2=0; #10;
        d0=0; d1=1; d2=1; #10;
        d0=1; d1=0; d2=0; #10;
        d0=1; d1=0; d2=1; #10;
        d0=1; d1=1; d2=0; #10;
        d0=1; d1=1; d2=1; #10;
        $finish;
    end
endmodule    