`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.09.2025 12:02:53
// Design Name: 
// Module Name: aes_round_debug
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


module aes_round_debug (
    input  wire [127:0] state_in,
    input  wire [127:0] round_key,
    output wire [127:0] state_sb,
    output wire [127:0] state_sr,
    output wire [127:0] state_mc,
    output wire [127:0] state_ark
);

    // Instantiate all AES round operations
    aes_subbytes  u_sb  (.state_in(state_in),  .state_out(state_sb));
    aes_shiftrows u_sr  (.state_in(state_sb), .state_out(state_sr));
    aes_mixcolumns u_mc (.state_in(state_sr), .state_out(state_mc));
    addroundkey   u_ark (.state_in(state_mc), .round_key(round_key), .state_out(state_ark));

endmodule
