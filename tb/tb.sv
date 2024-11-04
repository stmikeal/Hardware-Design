/*
 * tb.v
 *
 *  Created on: 17.10.2019
 *      Author: Alexander Antonov <antonov.alex.alex@gmail.com>
 *     License: See LICENSE file for details
 */


`timescale 1ns / 1ps

`define HALF_PERIOD			5						//external 100 MHZ
`define DIVIDER_115200		32'd8680
`define DIVIDER_19200		32'd52083
`define DIVIDER_9600		32'd104166
`define DIVIDER_4800		32'd208333
`define DIVIDER_2400		32'd416666


module tb ();
//
logic CLK_100MHZ, RST, rx, tx;
logic [15:0] SW;
logic [15:0] LED;

always #`HALF_PERIOD CLK_100MHZ = ~CLK_100MHZ;

always #1000 SW = SW + 8'h1;
	
NEXYS4_DDR
#(
	.SIM("YES")
) DUT (
	.CLK100MHZ(CLK_100MHZ)
    , .CPU_RESETN(!RST)
    
    , .SW(SW)
    , .LED(LED)

    , .UART_TXD_IN(rx)
    , .UART_RXD_OUT(tx)
);

////reset all////
task RESET_ALL ();
    begin
    CLK_100MHZ = 1'b0;
    RST = 1'b1;
    rx = 1'b1;
    #(`HALF_PERIOD/2);
    RST = 1;
    #(`HALF_PERIOD*6);
    RST = 0;
    while (DUT.srst) WAIT(10);
    end
endtask

////wait////
task WAIT
    (
     input logic [15:0] periods
     );
    begin
    integer i;
    for (i=0; i<periods; i=i+1)
        begin
        #(`HALF_PERIOD*2);
        end
    end
endtask

`define UDM_RX_SIGNAL rx
`define UDM_BLOCK DUT.udm
`include "udm.svh"
udm_driver udm = new();

/////////////////////////
// main test procedure //
localparam CSR_LED_ADDR         = 32'h00000000;
localparam CSR_SW_ADDR          = 32'h00000004;
localparam TESTMEM_ADDR         = 32'h80000000;

initial
    begin
    logic [31:0] wrdata [];
    logic [31:0] res;
    integer ARRSIZE=10;
    
	$display ("### SIMULATION STARTED ###");
	
	SW = 8'h30;
	RESET_ALL();
	WAIT(100);

	udm.cfg(`DIVIDER_115200, 2'b00);
	udm.check();
	udm.hreset();
	WAIT(100);
	
	udm.wr32(32'h20000000, 32'h1);
	udm.wr32(32'h20000004, 32'h2);
	udm.wr32(32'h20000008, 32'h3);
	udm.wr32(32'h2000000C, 32'h4);
	udm.wr32(32'h20000010, 32'h8);
	udm.wr32(32'h20000014, 32'h7);
	udm.wr32(32'h20000018, 32'h6);
	udm.wr32(32'h2000001C, 32'h5);
	
	udm.wr32(32'h20000020, 32'h7);
	udm.wr32(32'h20000024, 32'h5);
	udm.wr32(32'h20000028, 32'h3);
	udm.wr32(32'h2000002C, 32'h1);
	udm.wr32(32'h20000030, 32'h4);
	udm.wr32(32'h20000034, 32'h6);
	udm.wr32(32'h20000038, 32'h8);
	udm.wr32(32'h2000003C, 32'hA);
	
	udm.wr32(32'h20000050, 32'h1);
	
	udm.rd32(32'h20000054, res);
	while(res == 0) begin 
	   udm.rd32(32'h20000054, res);
	end
	
    udm.rd32(32'h20000040, res);
    udm.rd32(32'h20000044, res);
    udm.rd32(32'h20000048, res);
    udm.rd32(32'h2000004C, res);
	
	WAIT(100);
	
	// writing to LED
	udm.wr32(32'h00000000, 32'h5a5a5a5a);
	
	// reading SW
	
	WAIT(1000);

	$display ("### TEST PROCEDURE FINISHED ###");
	$stop;
    end


endmodule
