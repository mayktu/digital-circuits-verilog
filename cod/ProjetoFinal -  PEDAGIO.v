module Mayk_PROJECT(HEX3,HEX2,HEX1,HEX0,SW,LEDR,LEDG,clock);

input [9:5]SW;
input clock;

output reg [0:6]HEX0;
output reg [0:6]HEX1;
output reg [0:6]HEX2;
output reg [0:6]HEX3;
output reg [7:0]LEDG;
output reg[7:0]LEDR;

reg [2:0]estado;
reg [4:0]entrada;
reg [3:0]automovel;
reg camera,RIFD,cancela,cobrar;

parameter A = 0, B = 1, C = 2, D = 3, OK = 4, NOK = 5;

/*
A = STAND BY
B = 1Âº SENSOR DETECTADO
C = 2Âº SENSOR DETECTADO
D = 3Âº SENSOR DETECTADO
OK = VEICULO AUTORIZADO A PASSAGEM
NOK = VEICULO NAO AUTORIZADO A PASSAGEM
*/

always @(posedge clock) begin
	entrada[4] = SW[9]; //A
	entrada[3] = SW[8]; //B
	entrada[2] = SW[7]; //C
	entrada[1] = SW[6]; //D
	entrada[0] = SW[5]; //L or NL(Liberado ou nÃ£o liberado)
    LEDG[7] = automovel[3];
	LEDG[6] = automovel[2];
	LEDG[5] = automovel[1];
	LEDG[4] = automovel[0];
	LEDR[0] = camera;
	LEDR[1] = RIFD ;
	LEDR[2] = cancela;
	LEDR[3] = cobrar;

case(estado)
A:begin
	if(entrada[4] == 1) begin
		estado = B;
		camera = 1;
		RIFD = 1;

		end
	else begin
		estado = A;
			HEX3 = 7'b1111111;
			HEX2 = 7'b1111111;
			HEX1 = 7'b1111111;
			HEX0 = 7'b1111111;
			cobrar = 0;
			camera = 0;
			RIFD = 0;
			cancela = 0;
			automovel[3]=0;
			automovel[2]=0;
			automovel[1]=0;
			automovel[0]=0;

		end
end

B:begin
	if((entrada[4]==1 && entrada[3]==1 && entrada[0]==1) || (entrada[4]==0 && entrada[3]==1 && entrada[0]==1) || 
		(entrada[4]==0 && entrada[3]==1 && entrada[0]==0) || (entrada[4]==1 && entrada[3]==1 && entrada[0]==0)) begin
	
		if(entrada[4]==1 && entrada[3]==1 && entrada[0]==1)begin
			estado = C;
			HEX3 = 7'b0011000;
			HEX2 = 7'b0001000;
			HEX1 = 7'b0100100;
			HEX0 = 7'b0100100;
			//DISPLAY PASS
		end
		if(entrada[4]==0 && entrada[3]==1 && entrada[0]==1)begin
			estado = OK;
			automovel[3]=1;
			HEX3 = 7'b0011000;
			HEX2 = 7'b0001000;
			HEX1 = 7'b0100100;
			HEX0 = 7'b0100100;
			cancela = 1;
			cobrar = 1;

			//CARRO,DISPLAY PASS,ABRIR CANCELA,COBRAR
		end
		if(entrada[4]==0 && entrada[3]==1 && entrada[0]==0) begin
			estado = NOK;
			HEX3 = 7'b0100100;
			HEX2 = 7'b0001111;
			HEX1 = 7'b0000001;
			HEX0 = 7'b0011000;
			//Display STOP
		end
		if(entrada[4]==1 && entrada[3]==1 && entrada[0]==0)begin
			estado = NOK;
			HEX3 = 7'b0100100;
			HEX2 = 7'b0001111;
			HEX1 = 7'b0000001;
			HEX0 = 7'b0011000;
			//Display STOP
		end

	end else begin
		estado = B;	
	end
end

C:begin
	if((entrada[4]==1 && entrada[3]==1 && entrada[2]==1 && entrada[0]==1) || 
		(entrada[4]==0 && entrada[3]==1 && entrada[2]==1 && entrada[0]==1))begin

		if(entrada[4]==1 && entrada[3]==1 && entrada[2]==1 && entrada[0]==1)begin
			estado = D;
			cancela = 1;
			//ABRIR CANCELA
		end
		if(entrada[4]==0 && entrada[3]==1 && entrada[2]==1 && entrada[0]==1)begin
			estado = OK;
			automovel[3]=1;
			automovel[2]=1;
			HEX3 = 7'b0011000;
			HEX2 = 7'b0001000;
			HEX1 = 7'b0100100;
			HEX0 = 7'b0100100;
			cancela = 1;
			cobrar = 1;

			//CARGA 2, DISPLAY â€œPASSâ€,ABRIR CANCELA, COBRAR
		end

	end else begin
		estado = C;
		end
	
	
end

D:begin
	if((entrada[4]==0 && entrada[3]==1 && entrada[2]==1 && entrada[1]==1 && entrada[0]==1) ||
	 (entrada[4]==1 && entrada[3]==1 && entrada[2]==1 && entrada[1]==1 && entrada[0]==1))begin

		if(entrada[4]==0 && entrada[3]==1 && entrada[2]==1 && entrada[1]==1 && entrada[0]==1)begin
			estado=OK;
			automovel[3]=1;
			automovel[2]=1;
			automovel[1]=1;
			cobrar = 1;

			
			//CARGA 3, COBRAR
		end
		if(entrada[4]==1 && entrada[3]==1 && entrada[2]==1 && entrada[1]==1 && entrada[0]==1)begin
			estado=OK;
			automovel[3]=1;
			automovel[2]=1;
			automovel[1]=1;
			automovel[0]=1;
			cobrar = 1;
			//CARGA 4, COBRAR
		end
	end else begin
		estado = D;
	end
			
end

OK:begin
	if(entrada[1]==0 && entrada[2]==0)begin
		estado = A;
		cobrar = 0;
		camera = 0;
		RIFD = 0;
		cancela = 0;

	end
	else begin
		estado = OK;
	end
end

NOK:begin
	//SOAR ALARME da placa 
end

default: estado = A;
endcase
end
endmodule 