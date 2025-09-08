`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.09.2025 12:11:37
// Design Name: 
// Module Name: tb_subbytes
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


module tb_subbytes; 
reg [127:0] state_in;
 wire [127:0] state_out; 
 aes_subbytes dut ( .state_in(state_in), .state_out(state_out) ); 
 initial begin // FIPS-197 Appendix C.1 - expected SubBytes result below
  state_in = 128'h00102030405060708090a0b0c0d0e0f0; 
  #5; $display("state_in = %032h", state_in);
   $display("subbytes = %032h", state_out);
    if (state_out === 128'h63cab7040953d051cd60e0e7ba70e18c) $display("PASS: SubBytes matches expected"); 
    else begin $display("FAIL: expected 63cab7040953d051cd60e0e7ba70e18c"); 
    $display("Got = %032h", state_out); 
    end #10 $finish; 
    end 
    initial $monitor("t=%0t ns state_out=%032h", $time, state_out);
     endmodule
