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
    input clk, nrst,
    input  logic [WIDTH - 1:0][HEIGHT - 1:0][31:0] mat1,
    input  logic [HEIGHT - 1:0][WIDTH - 1:0][31:0] mat2,  
    output reg [WIDTH - 1:0][WIDTH - 1:0][31:0] res
    );
    
    logic [HEIGHT - 1:0][WIDTH - 1:0][WIDTH - 1:0][31:0] elems;
    
    always @(posedge clk, negedge nrst) begin
        if (~nrst) begin
            elems <= 0;;
            res <= 0;
        end else begin
            // stage 0 - partial products generation
            for(int i = 0; i < WIDTH; i++) 
                for(int j = 0; j < WIDTH; j++) 
                    for(int k = 0; k < HEIGHT; k++) 
                        elems[k][i][j] <= mat1[i][k]*mat2[k][j];        
            // stage 1: final sum 
            for(int i = 0; i < WIDTH; i++)
                for(int j = 0; j < WIDTH; j++)
                    res[i][j] <= elems[0][i][j] + elems[1][i][j] + elems[2][i][j] + elems[3][i][j];
        end
    end
    
endmodule

