`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:34:34 11/07/2021 
// Design Name: 
// Module Name:    square_root 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module square_root(
    output reg [15:0] out,
    input  [7:0] in );

    reg [23:0] num;
	 reg [23:0] res;
    reg [23:0] b;
	 
//voi folosi algoritmul de pe Wikipedia
always@(*) begin

    num [23:16] = in;
	 num [15:0] = 0;
	 res = 0;
    b = 1 << 22; //pentru ca bitul sa poata fi ulterior shiftat la dreapta pe 2 biti de maxim 12 ori
	 
    repeat(12) begin //shiftez bitul astfel incat sa fie mai mic decat numarul initial
        if (b > num) begin
				b = b >> 2;
        end
    end
    
    repeat(12) begin //de maxim 12 ori se poate shifta b la dreapta cu 2
        if (b != 0) begin
            if (num >= res + b) begin
                num = num - (res + b); //num va avea maxim 23 de biti si va putea fi ulterior shiftat
													//de maxim 11 ori (fara shiftarea initiala, unde res este 0)
                res = (res >> 1) + b;
            end 
				else begin
                res = res >> 1;
                end
            b = b >> 2;
        end
    end
	 
	 out [15:12] = 0;
	 out [11:0] = res [11:0];
end

endmodule