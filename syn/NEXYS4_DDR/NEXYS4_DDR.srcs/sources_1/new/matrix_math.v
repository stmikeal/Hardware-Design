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


module matrix_math(
     input  [31:0]  
            mata00, mata01, mata02, mata03,
            mata10, mata11, mata12, mata13,
            matb00, matb10, matb20, matb30,
            matb01, matb11, matb21, matb31,
    output [31:0]  
            res00, res01, res10, res11 
    );
    assign res00 = mata00*matb00 + mata01*matb10 + mata02*matb20 + mata03*matb30;
    assign res01 = mata00*matb01 + mata01*matb11 + mata02*matb21 + mata03*matb31; 
    assign res10 = mata10*matb00 + mata11*matb10 + mata12*matb20 + mata13*matb30; 
    assign res11 = mata10*matb01 + mata11*matb11 + mata12*matb21 + mata13*matb31; 
endmodule
