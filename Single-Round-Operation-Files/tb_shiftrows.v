`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.09.2025 12:14:58
// Design Name: 
// Module Name: tb_shiftrows
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


module tb_shiftrows;

    reg  [127:0] state_in;
    wire [127:0] state_sb;
    wire [127:0] state_sr;

    // DUTs
    aes_subbytes  u_sb (.state_in(state_in),  .state_out(state_sb));
    aes_shiftrows u_sr (.state_in(state_sb), .state_out(state_sr));

    initial begin
        // Test vector from FIPS-197 Appendix C.1
        state_in = 128'h00102030405060708090a0b0c0d0e0f0;

        #5;  // small delay for combinational propagation

        $display("SubBytes  = %032h", state_sb);
        $display("ShiftRows = %032h", state_sr);

        // Check SubBytes
        if (state_sb !== 128'h63cab7040953d051cd60e0e7ba70e18c)
            $display("? FAIL at SubBytes stage! Got = %032h", state_sb);
        else
            $display("? PASS: SubBytes matches expected");

        // Check ShiftRows
        if (state_sr === 128'h6353e08c0960e104cd70b751bacad0e7)
            $display("? PASS: ShiftRows matches expected");
        else begin
            $display("? FAIL: expected 6353e08c0960e104cd70b751bacad0e7");
            $display("Got = %032h", state_sr);
        end

        #10 $finish;
    end

endmodule

