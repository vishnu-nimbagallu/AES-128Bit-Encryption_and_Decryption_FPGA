`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.09.2025 12:07:55
// Design Name: 
// Module Name: aes_shiftrows
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

module aes_shiftrows (
    input  wire [127:0] state_in,
    output wire [127:0] state_out
);

    // AES uses column-major ordering (4x4 byte matrix)
    // state_in[127:120] = s(0,0), state_in[119:112] = s(1,0), ...
    // Row r is shifted left by r positions.

    wire [7:0] s [0:3][0:3];  // 4x4 matrix of bytes
    genvar r, c;

    // Unpack input into 4x4 byte matrix
    generate
        for (c = 0; c < 4; c = c+1) begin : col_unpack
            for (r = 0; r < 4; r = r+1) begin : row_unpack
                assign s[r][c] = state_in[127 - ((r+4*c)*8) -: 8];
            end
        end
    endgenerate

    // ShiftRows: cyclic shift row r by r bytes to the left
    wire [7:0] sr [0:3][0:3];
    generate
        for (r = 0; r < 4; r = r+1) begin : row_shift
            for (c = 0; c < 4; c = c+1) begin : col_shift
                assign sr[r][c] = s[r][(c + r) % 4];
            end
        end
    endgenerate

    // Pack back into 128-bit output
    generate
        for (c = 0; c < 4; c = c+1) begin : col_pack
            for (r = 0; r < 4; r = r+1) begin : row_pack
                assign state_out[127 - ((r+4*c)*8) -: 8] = sr[r][c];
            end
        end
    endgenerate

endmodule

