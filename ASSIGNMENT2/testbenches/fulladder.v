module halfadder(input a, input b,output s, output c ); 
    assign s = a^b;
    assign c = a&b;
endmodule
module fulladder(input c, input d, input cin, output finalsum, output cout );
    wire e, f ,g,h;
    assign g= cin;
    halfadder inst1(.a(c),.b(d),.s(e), .c(f));
    halfadder inst2(.a(e),.b(g),.s(finalsum), .c(h));
    assign cout = h|f;

endmodule    
    
