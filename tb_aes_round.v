`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.09.2025 12:15:41
// Design Name: 
// Module Name: tb_aes_round
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

module tb_aes_round;
    reg  [127:0] state_in;      // Initial state
    reg  [127:0] round_key;     // Round key
    wire [127:0] state_sb;      // After SubBytes
    wire [127:0] state_sr;      // After ShiftRows  
    wire [127:0] state_mc;      // After MixColumns
    wire [127:0] state_ark;     // After AddRoundKey
    
    // Instantiate all AES round operations
    subbytes u_sb (.data_in(state_in), .data_out(state_sb));
    shiftrows u_sr (.data_in(state_sb), .data_out(state_sr));
    mixcolumns u_mc (.data_in(state_sr), .data_out(state_mc));
    addroundkey u_ark (.state_in(state_mc), .round_key(round_key), .state_out(state_ark));
    
    initial begin
        // Test values from FIPS-197 Appendix C.1
        state_in   = 128'h00102030405060708090a0b0c0d0e0f0;
        round_key  = 128'hd6aa74fdd2af72fadaa678f1d6ab76fe;
        
        #1;
        
        // Display all intermediate states
        $display("Initial State:    %032h", state_in);
        $display("After SubBytes:   %032h", state_sb);
        $display("After ShiftRows:  %032h", state_sr);
        $display("After MixColumns: %032h", state_mc);
        $display("After AddRoundKey:%032h", state_ark);
        $display("");
        
        // Verify against expected values from FIPS-197
        if (state_sb === 128'h63cab7040953d051cd60e0e7ba70e18c)
            $display("PASS: SubBytes matches expected");
        else
            $display("FAIL: SubBytes expected 63cab7040953d051cd60e0e7ba70e18c");
            
        if (state_sr === 128'h6353e08c0960e104cd70b751bacad0e7)
            $display("PASS: ShiftRows matches expected");
        else
            $display("FAIL: ShiftRows expected 6353e08c0960e104cd70b751bacad0e7");
            
        if (state_mc === 128'h5f72641557f5bc92f7be3b291db9f91a)
            $display("PASS: MixColumns matches expected");
        else
            $display("FAIL: MixColumns expected 5f72641557f5bc92f7be3b291db9f91a");
            
        if (state_ark === 128'ha49c7ff2689f352b6b5bea43026a5049)
            $display("PASS: AddRoundKey matches expected");
        else
            $display("FAIL: AddRoundKey expected a49c7ff2689f352b6b5bea43026a5049");
        
        #5 $finish;
    end
endmodule

