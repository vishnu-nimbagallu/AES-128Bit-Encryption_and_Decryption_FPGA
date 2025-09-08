`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.09.2025 12:09:55
// Design Name: 
// Module Name: tb_aes_round_debug
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

module tb_aes_round_debug;

    reg  [127:0] state_in;
    reg  [127:0] round_key;
    wire [127:0] state_sb;
    wire [127:0] state_sr;
    wire [127:0] state_mc;
    wire [127:0] state_ark;

    // DUT
    aes_round_debug uut (
        .state_in(state_in),
        .round_key(round_key),
        .state_sb(state_sb),
        .state_sr(state_sr),
        .state_mc(state_mc),
        .state_ark(state_ark)
    );

    initial begin
        // FIPS-197 C.1
        state_in  = 128'h00102030405060708090a0b0c0d0e0f0;
        round_key = 128'hd6aa74fdd2af72fadaa678f1d6ab76fe;
        #5;

        $display("Initial State : %032h", state_in);
        $display("SubBytes      : %032h", state_sb);
        $display("ShiftRows     : %032h", state_sr);
        $display("MixColumns    : %032h", state_mc);
        $display("AddRoundKey   : %032h", state_ark);

        #10 $finish;
    end
endmodule

