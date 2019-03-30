module Exp_moore(controle, trilhoAberto, trilhoFechado, sensor, clock);

input controle, trilhoAberto, trilhoFechado, sensor, clock;
reg[1:0] estado;
reg[4:1] entrada;
parameter Fechado = 2'b00, Aberto = 2'b11, Fechando = 2'b01, Abrindo =  2'b10;
initial estado = Fechado;
always @(posedge clock) begin
    entrada[4] = controle;
    entrada[3] = trilhoAberto;
    entrada[2] = trilhoFechado;
    entrada[1] = sensor;


case(estado)
    Fechado: begin
        if(entrada[4] == (1'b1))
            estado = Abrindo;
        end


    Abrindo: begin 
        if ((entrada[4] == (1'b0)) && (entrada[3] == (1'b1)))
            estado = Aberto;
        if ((entrada[4] == (1'b1)) && (entrada[1] == (1'b0)))
            estado = Fechando;
        end

    Aberto: begin
        if ((entrada[4] == (1'b1)) && (entrada[1] == (1'b0)))
            estado = Fechando;
        end

    Fechando: begin
        if ((entrada[4] == (1'b1)))
            estado = Abrindo;
        if ((entrada[4] == (1'b0)) && (entrada[2] == (1'b1)))
            estado = Fechado;
        if ((entrada[4] == (1'b0)) && (entrada[1] == (1'b1)))
            estado = Abrindo;
        end
        default: estado = Fechado;
endcase
end
endmodule
