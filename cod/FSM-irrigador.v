module Exp_5_mealy(SW,HEX1, clk_50mhz, rst_50mhz);

input [1:0]SW;
output reg [0:6]HEX1;
input clk_50mhz, rst_50mhz;

//ESTADOS
reg [1:0]estado;
reg [1:0]entrada;
reg [17:0]count_reg = 0;
reg out_100hz = 0;
parameter S1 =  2'b00, S2 = 2'b01, S3 = 2'b10;

//S1 INICIAL
//S2 30 MINUTOS
//S3 1H
initial estado = S1;

always @ (posedge clk_50mhz) begin
    entrada[1] = SW[1];
    entrada[0] = SW[0];
case(estado)
    S1: begin
        HEX1 = 7'b0000001;
        if (entrada == (2'b10))
            estado = S2;
        if (entrada == (2'b01))
            estado = S3;
    end

    S2: begin
        HEX1 = 7'b0000110;
        if (entrada[0] == 1)
        //DESLIGADO SE HOUVER CONTROLE 
            estado = S1;
        if (clk_50mhz) begin
            count_reg = 0;
        end else begin 
            if (count_reg < 150000) begin
                count_reg = count_reg + 1;
            end else begin
            //DESLIGADO SE TERMINAR O RELOGIO
                count_reg = 0;
                estado = S1;
            end
        end
    end

    S3: begin
        HEX1 = 7'b0100000;
        //DESLIGADO SE HOUVER CONTROLE
        if (entrada[0] = 1)
            estado = S1;

        if (clk_50mhz) begin
            count_reg = 0;
        end else begin
            if (count_reg < 300000) begin
                count_reg = count_reg + 1;
            end else begin
                //DESLIGADO SE TERMINAR O RELOGIO
                count_reg = 0
                estado = S1;
            end
        end
    end
endcase
end
endmodule

