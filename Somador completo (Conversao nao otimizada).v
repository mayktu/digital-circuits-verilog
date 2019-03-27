module SOMADOR_COMPLETAO_4BITS(SW,HEX0,HEX1,HEX2,HEX3);

//ENTRADAS NA PLACA

input [9:0]SW;

//Fios Intermediários
wire A,B,C,D,E,F,G;
wire S1,S2,S3,S4,Cin1,Cin2,Cin3,Cin4, Cout1,Cout2,Cout3,Cout4,T;

//SAIDAS NA PLACA

output [6:0]HEX0;
output [6:0]HEX1;
output [6:0]HEX2;
output [6:0]HEX3;

//MAPEAMENTO DOS DIGITOS

assign A = SW[9];
assign B = SW[8];
assign C = SW[7];
assign D = SW[6];
assign E = SW[3];
assign F = SW[2];
assign G = SW[1];
assign H = SW[0];


//Primeiro Display HEX3 - PRIMEIRO ALGARISMO

assign HEX3[0] = ~( (~A & ~B & ~C & D) + (~A & B & ~C & ~D) );
assign HEX3[1] = ~( (~A & B & ~C & D) + (~A & B & C & ~D) );
assign HEX3[2] = ~( (~A & ~B & C & ~D) );
assign HEX3[3] = ~( (~A & ~B & ~C & D) + (~A & B & ~C & ~D) +  (~A & B & C & D) + (A & ~B & ~C & D) );
assign HEX3[4] =   (~A & ~B & ~C & ~D) + (~A & ~B & C & ~D) +  (~A & B & C & ~D) + (A & ~B & ~C & ~D);
assign HEX3[5] = ~( (~A & ~B & ~C & D) + (~A & ~B & C & ~D) +  (~A & ~B & C & D) + (~A & B & C & D) );
assign HEX3[6] = ~( (~A & ~B & ~C & ~D) + (~A & ~B & ~C & D) + (~A & B & C & D));

//SEGUNDO Display HEX2 - SEGUNDO ALGARISMO

assign HEX2[0] = ~( (~E & ~F & ~G & H) + (~E & F & ~G & ~H) );
assign HEX2[1] = ~( (~E & F & ~G & H) + (~E & F & G & ~H) );
assign HEX2[2] = ~( (~E & ~F & G & ~H) );
assign HEX2[3] = ~( (~E & ~F & ~G & H) + (~E & F & ~G & ~H) +  (~E & F & G & H) + (E & ~F & ~G & H) );
assign HEX2[4] =   (~E & ~F & ~G & ~H) + (~E & ~F & G & ~H) +  (~E & F & G & ~H) + (E & ~F & ~G & ~H) ;
assign HEX2[5] = ~( (~E & ~F & ~G & H) + (~E & ~F & G & ~H) +  (~E & ~F & G & H) + (~E & F & G & H) );
assign HEX2[6] = ~( (~E & ~F & ~G & ~H) + (~E & ~F & ~G & H) + (~E & F & G & H));

//SOMADOR COMPLETO DE DOIS NUMEROS DE 4 BITS

assign Cin1 = 0;
assign S1 = H ^ D ^ Cin1;
assign Cout1 = H & D + H & Cin1 + D & Cin1;
assign Cin2 = Cout1;

assign S2 = G ^ C ^ Cin2;
assign Cout2 = G & C + G & Cin2 + C & Cin2;
assign Cin3 = Cout2;

assign S3 = F ^ B ^ Cin3;
assign Cout3 = F & B + F & Cin2 + B & Cin2;
assign Cin4 = Cout3;

assign S4 = E ^ A ^ Cin4;
assign out4 = E & A + E & Cin4 + A & Cin4;




//VERIFICANDO SE É MAIOR QUE 6

assign T = S4 & S3 + S4 & S2;

begin
  if (T == 0)
    begin
    //TESTAR ESSA LOGICA, VER SE NAO TA INVERTIDO MSB com LSB
      assign A = S4;
      assign B = S3;
      assign C = S2;
      assign D = S1;

      assign HEX0[0] = ~( (~A & ~B & ~C & D) + (~A & B & ~C & ~D) );
      assign HEX0[1] = ~( (~A & B & ~C & D) + (~A & B & C & ~D) );
      assign HEX0[2] = ~( (~A & ~B & C & ~D) );
      assign HEX0[3] = ~( (~A & ~B & ~C & D) + (~A & B & ~C & ~D) +  (~A & B & C & D) + (A & ~B & ~C & D) );
      assign HEX0[4] =   (~A & ~B & ~C & ~D) + (~A & ~B & C & ~D) +  (~A & B & C & ~D) + (A & ~B & ~C & ~D);
      assign HEX0[5] = ~( (~A & ~B & ~C & D) + (~A & ~B & C & ~D) +  (~A & ~B & C & D) + (~A & B & C & D) );
      assign HEX0[6] = ~( (~A & ~B & ~C & ~D) + (~A & ~B & ~C & D) + (~A & B & C & D));

    end
  else
    begin
    //CASO CONTRARIO SOMAR 6;

    assign A = S4;
    assign B = S3;
    assign C = S2;
    assign D = S1;

    //6 em Binario
    assign E = 0;
    assign F = 1;
    assign G = 1;
    assign H = 0;

    assign Cin1 = 0;
    assign S1 = H ^ D ^ Cin1;
    assign Cout1 = H & D + H & Cin1 + D & Cin1;
    assign Cin2 = Cout1;

    assign S2 = G ^ C ^ Cin2;
    assign Cout2 = G & C + G & Cin2 + C & Cin2;
    assign Cin3 = Cout2;

    assign S3 = F ^ B ^ Cin3;
    assign Cout3 = F & B + F & Cin2 + B & Cin2;
    assign Cin4 = Cout3;

    assign S4 = E ^ A ^ Cin4;
    assign out4 = E & A + E & Cin4 + A & Cin4;


    assign A = S4;
    assign B = S3;
    assign C = S2;
    assign D = S1;

    //REPRESENTAÇÃO DO SEGUNDO ALGARISMO
    assign HEX0[0] = ~( (~A & ~B & ~C & D) + (~A & B & ~C & ~D) );
    assign HEX0[1] = ~( (~A & B & ~C & D) + (~A & B & C & ~D) );
    assign HEX0[2] = ~( (~A & ~B & C & ~D) );
    assign HEX0[3] = ~( (~A & ~B & ~C & D) + (~A & B & ~C & ~D) +  (~A & B & C & D) + (A & ~B & ~C & D) );
    assign HEX0[4] =   (~A & ~B & ~C & ~D) + (~A & ~B & C & ~D) +  (~A & B & C & ~D) + (A & ~B & ~C & ~D);
    assign HEX0[5] = ~( (~A & ~B & ~C & D) + (~A & ~B & C & ~D) +  (~A & ~B & C & D) + (~A & B & C & D) );
    assign HEX0[6] = ~( (~A & ~B & ~C & ~D) + (~A & ~B & ~C & D) + (~A & B & C & D));

    //REPRESENTAÇÂO DO DIG 1 NA PENULTIMA PORTA, PS: não sei se precisa dessas atribuição a zero
    assign HEX1[0] = 0;
    assign HEX1[1] = 1;
    assign HEX1[2] = 1;
    assign HEX1[3] = 0;
    assign HEX1[4] = 0;
    assign HEX1[5] = 0;
    assign HEX1[6] = 0;

    end
end
endmodule
