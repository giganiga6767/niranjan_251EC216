module mag_comp_4bit_comb (
    input wire [3:0] A,        
    input wire [3:0] B,        
    output wire O_gt,          
    output wire O_eq,          
    output wire O_lt           
);

    
    wire E3, E2, E1, E0;
    
    assign E3 = ~(A[3] ^ B[3]); 
    assign E2 = ~(A[2] ^ B[2]); 
    assign E1 = ~(A[1] ^ B[1]); 
    assign E0 = ~(A[0] ^ B[0]); 

    
    wire A_eq_B_int;
    wire A_gt_B_int;
    wire A_lt_B_int;

    
    assign A_eq_B_int = E3 & E2 & E1 & E0;
    
   
    assign A_gt_B_int = ( A[3] & ~B[3]) |
                        (E3 & A[2] & ~B[2]) |
                        (E3 & E2 & A[1] & ~B[1]) |
                        (E3 & E2 & E1 & A[0] & ~B[0]);

    
    assign A_lt_B_int = (~A[3] & B[3]) |
                        (E3 & ~A[2] & B[2]) |
                        (E3 & E2 & ~A[1] & B[1]) |
                        (E3 & E2 & E1 & ~A[0] & B[0]);

   
    assign O_eq = A_eq_B_int ;
    assign O_gt = A_gt_B_int ;
    assign O_lt = A_lt_B_int ;

endmodule