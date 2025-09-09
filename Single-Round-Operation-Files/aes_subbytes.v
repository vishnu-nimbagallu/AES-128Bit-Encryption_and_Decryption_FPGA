`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.09.2025 12:06:18
// Design Name: 
// Module Name: aes_subbytes
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


module aes_subbytes ( 
input wire [127:0] state_in,
 output wire [127:0] state_out
  );
   genvar i;
    generate for (i=0; i<16; i=i+1)
     begin : sbox_loop // Note: use [127 - 8*i -: 8] so byte 0 = MSB field (column-major mapping) 
     aes_sbox sbox_inst ( .a(state_in[127 - 8*i -: 8]), .y(state_out[127 - 8*i -: 8]) ); 
     end 
     endgenerate 
     endmodule