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
    output reg [WIDTH - 1:0][WIDTH - 1:0][31:0] res,
    output reg ready
    );
    
    logic [HEIGHT - 1:0][WIDTH - 1:0][WIDTH - 1:0][31:0] elems;
    
    logic [31:0] iter_elem; 
    logic [31:0] iter_row;
    logic [31:0] iter_column;
    
    enum logic [1:0] {IDLE, COUNT, RESULT} state;
    
    always @(posedge clk, negedge nrst) begin
        if (~nrst) begin
            iter_elem <= 0;
            iter_row <= 0;
            iter_column <= 0;
            state <= IDLE;
            elems <= 0;
            ready <= 0;
            res <= 0;
        end else begin
            case(state)
                IDLE: state <= COUNT;
                COUNT: begin
                    res[iter_row][iter_column] <= res[iter_row][iter_column] + mat1[iter_row][iter_elem] * mat2[iter_elem][iter_column];
                    if (iter_elem != HEIGHT - 1) begin
                        iter_elem <= iter_elem + 1;
                    end else begin
                        iter_elem <= 0;
                        if (iter_row != WIDTH - 1) begin
                            iter_row <= iter_row + 1;
                        end else begin
                            iter_row <= 0;
                            iter_column <= iter_column + 1;
                        end
                    end
                    if (iter_elem == HEIGHT - 1 && iter_row == WIDTH - 1 && iter_column == WIDTH - 1) begin
                        state <= RESULT;
                        iter_elem <= 0;
                        iter_row <= 0;
                        iter_column <= 0;
                    end
                end
                RESULT: ready <= 1;
            endcase
        end
    end
    
endmodule
