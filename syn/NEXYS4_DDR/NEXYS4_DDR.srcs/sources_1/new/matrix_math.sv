`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.10.2024 09:30:45
// Design Name: 
// Module Name: matrix_math
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module matrix_math #(
    WIDTH = 2,
    HEIGHT = 4
)(
    input  logic [31:0] mat1 [WIDTH - 1:0][HEIGHT - 1:0],
    input  logic [31:0] mat2 [HEIGHT - 1:0][WIDTH - 1:0],  
    output reg [31:0] res [WIDTH - 1:0][WIDTH - 1:0]
    );
//    genvar i,j,k;
//    logic [31:0] pairs [WIDTH-1:0][WIDTH-1:0][HEIGHT-1:0];
//    pair = askjdbas;
//    generate
//        for(i = 0; i < WIDTH; i++) 
//            for(j = 0; j < WIDTH; j++) begin
//                for(k = 0; k < HEIGHT; k++)
//                    pairs[i][j][k] = mat1[i][k]*mat2[k][j];
//                assign res[i][j] = pairs[i][j].sum();
//            end
//    endgenerate
   
    always_comb begin
        for(int i = 0; i < WIDTH; i++) begin
            for(int j = 0; j < WIDTH; j++) begin
                res[i][j] = 0;
                for(int k = 0; k < HEIGHT; k++) begin
                    res[i][j] += mat1[i][k]*mat2[k][j];
                end
            end
        end
    end
    
//always_comb begin
//    res[0][0] = mat1[0][0]*mat2[0][0] + mat1[0][1]*mat2[1][0] + mat1[0][2]*mat2[2][0] + mat1[0][3]*mat2[3][0];
//    res[0][1] = mat1[0][0]*mat2[0][1] + mat1[0][1]*mat2[1][1] + mat1[0][2]*mat2[2][1] + mat1[0][3]*mat2[3][1]; 
//    res[1][0] = mat1[1][0]*mat2[0][0] + mat1[1][1]*mat2[1][0] + mat1[1][2]*mat2[2][0] + mat1[1][3]*mat2[3][0]; 
//    res[1][1] = mat1[1][0]*mat2[0][1] + mat1[1][1]*mat2[1][1] + mat1[1][2]*mat2[2][1] + mat1[1][3]*mat2[3][1]; 
//end
    
//    always @(*) begin
//        for(int i = 0; i < WIDTH; i++)
//            for(int j = 0; j < WIDTH; j++)begin
//                $display("pairs: %p", pairs[i][j]);
//                $display("real pairs: %d %d %d %d", pairs[i][j][0], pairs[i][j][1], pairs[i][j][2], pairs[i][j][3]);
//                $display("sum: %d", pairs[i][j].sum with(item));
//                $display("real sum: %d", pairs[i][j][0] + pairs[i][j][1] + pairs[i][j][2] + pairs[i][j][3]);
//            end
//    end
    
endmodule
