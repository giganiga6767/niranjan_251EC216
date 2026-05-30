module  subtractor(input a, input b,output s, output c ); 
    assign s = a^b;
    assign c = ~(a)&b;
endmodule
module fsub(input c, input d, input cin, output finalsum, output cout );
    wire e, f ,g,h;
    assign g= cin;
    subtractor inst1(.a(c),.b(d),.s(e), .c(f));
    subtractor inst2(.a(e),.b(g),.s(finalsum), .c(h));
    assign cout = h|f;

endmodule    
    
