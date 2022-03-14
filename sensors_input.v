`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:34:17 11/07/2021 
// Design Name: 
// Module Name:    sensors_input 
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
module sensors_input(
   output  reg [7 : 0]   height,
   input    [7 : 0]   sensor1,
   input    [7 : 0]   sensor2,
   input    [7 : 0]   sensor3,
   input    [7 : 0]   sensor4);

reg [10 : 0] suma; //suma senzorilor; voi verifica restul impartirii ei la 2 sau la 4 pentru a vedea daca inaltimea trebuie sa fie incrementata

always@(*) begin

	if (sensor1 == 0 || sensor3 == 0) begin
			suma = sensor2 + sensor4; //ignor sensor1 si sensor3
			height = suma / 2;
			if (suma[0] == 1) //daca suma este impara (inaltimea are partea fractionara 0.5), incrementez inaltimea cu 1
				height = height + 1;
			end
			
	else if (sensor2 == 0 || sensor4 == 0) begin //ignor sensor2 si sensor4
			suma = sensor1 + sensor3;
			height = suma / 2;
			if (suma[0] == 1) //daca suma este impara (inaltimea are partea fractionara 0.5), incrementez inaltimea cu 1
				height = height + 1;
			end
			
	else begin
			suma = sensor1 + sensor2 + sensor3 + sensor4;
			height = suma / 4;
			if (suma[1:0] == 2 || suma[1:0] == 3) //daca restul impartirii sumei la 4 este 2 sau 3 (inaltimea are partea fractionara 0.5 sau 0.75), incrementez inaltimea cu 1
				height = height + 1;
			end
end

endmodule
