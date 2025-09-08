`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.09.2025 12:14:24
// Design Name: 
// Module Name: tb_mixcolumns
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


module tb_mixcolumns;
    reg  [127:0] state_in;
    wire [127:0] state_sb;
    wire [127:0] state_sr;
    wire [127:0] state_mc;

    // DUTs
    aes_subbytes   u_sb (.state_in(state_in),  .state_out(state_sb));
    aes_shiftrows  u_sr (.state_in(state_sb), .state_out(state_sr));
    aes_mixcolumns u_mc (.state_in(state_sr), .state_out(state_mc));

    initial begin
        // FIPS-197 Appendix C.1 input
        state_in = 128'h00102030405060708090a0b0c0d0e0f0;
        #5;
        $display("SubBytes   = %032h", state_sb);
        $display("ShiftRows  = %032h", state_sr);
        $display("MixColumns = %032h", state_mc);

        if (state_mc === 128'h5f72641557f5bc92f7be3b291db9f91a)
            $display("PASS: MixColumns matches expected");
        else begin
            $display("FAIL: expected 5f72641557f5bc92f7be3b291db9f91a");
            $display("Got   = %032h", state_mc);
        end

        #10 $finish;
    end
endmodule
