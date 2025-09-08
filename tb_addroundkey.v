`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.09.2025 12:10:39
// Design Name: 
// Module Name: tb_addroundkey
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


module tb_addroundkey;
    reg  [127:0] state_in;
    reg  [127:0] round_key;
    wire [127:0] state_sb;
    wire [127:0] state_sr;
    wire [127:0] state_mc;
    wire [127:0] state_ark;

    // DUTs
    aes_subbytes     u_sb  (.state_in(state_in),   .state_out(state_sb));
    aes_shiftrows    u_sr  (.state_in(state_sb),  .state_out(state_sr));
    aes_mixcolumns   u_mc  (.state_in(state_sr),  .state_out(state_mc));
    aes_addroundkey  u_ark (.state_in(state_mc),  .round_key(round_key), .state_out(state_ark));

    initial begin
        // FIPS-197 Appendix C.1 input
        state_in  = 128'h00102030405060708090a0b0c0d0e0f0;
     round_key = 128'hd6aa74fdd2af72fadaa678f1d6ab76fe;
        #5;
        $display("SubBytes    = %032h", state_sb);
        $display("ShiftRows   = %032h", state_sr);
        $display("MixColumns  = %032h", state_mc);
        $display("AddRoundKey = %032h", state_ark);

        if (state_ark === 128'ha49c7ff2689f352b6b5bea43026a5049)
            $display("? PASS: Full AES round output matches expected");
        else begin
            $display("? FAIL: Expected a49c7ff2689f352b6b5bea43026a5049");
            $display("Got     = %032h", state_ark);
        end

        #10 $finish;
    end
endmodule
