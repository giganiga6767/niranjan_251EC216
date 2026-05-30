module sevenbit(input wire d2, input wire d1, input wire d0, output wire a, output b, output c, output d, output e, output f, output g );
    assign a = ~d1&~d0|~d2&d1|d2&d0;
    assign b = ~d2|~d0;
    assign c = d2 | ~d1|~d0;
    assign d = d2&d0|d1&d0|~d0&~d2;
    assign e = ~d2&~d1&~d0|d2&~d1&d0|~d2&d1&d0;
    assign f = ~d1&~d2&~d0|d2&(d1|d0);
    assign g = d1|d2&d0;
endmodule
