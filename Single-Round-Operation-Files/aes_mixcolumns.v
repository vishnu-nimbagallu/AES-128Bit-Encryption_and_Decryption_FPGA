`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.09.2025 12:03:44
// Design Name: 
// Module Name: aes_mixcolumns
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


module aes_mixcolumns (
    input  wire [127:0] state_in,
    output wire [127:0] state_out
);

    // Galois field multiplication by 2
    function [7:0] xtime;
        input [7:0] b;
        begin
            xtime = (b[7] ? ((b << 1) ^ 8'h1b) : (b << 1));
        end
    endfunction

    // Multiply by 3 in GF(2^8): (2*b) ^ b
    function [7:0] mul3;
        input [7:0] b;
        begin
            mul3 = xtime(b) ^ b;
        end
    endfunction

    integer c;
    reg [127:0] t;
    reg [7:0] a0, a1, a2, a3;
    reg [7:0] r0, r1, r2, r3;

    always @* begin
        t = 128'd0;
        for (c = 0; c < 4; c = c+1) begin
            // Extract one column (4 bytes)
            a0 = state_in[127 - (0 + 4*c)*8 -: 8];
            a1 = state_in[127 - (1 + 4*c)*8 -: 8];
            a2 = state_in[127 - (2 + 4*c)*8 -: 8];
            a3 = state_in[127 - (3 + 4*c)*8 -: 8];

            // Apply MixColumns matrix
            r0 = xtime(a0) ^ mul3(a1) ^ a2 ^ a3;
            r1 = a0 ^ xtime(a1) ^ mul3(a2) ^ a3;
            r2 = a0 ^ a1 ^ xtime(a2) ^ mul3(a3);
            r3 = mul3(a0) ^ a1 ^ a2 ^ xtime(a3);

            // Write back
            t[127 - (0 + 4*c)*8 -: 8] = r0;
            t[127 - (1 + 4*c)*8 -: 8] = r1;
            t[127 - (2 + 4*c)*8 -: 8] = r2;
            t[127 - (3 + 4*c)*8 -: 8] = r3;
        end
    end

    assign state_out = t;
endmodule

