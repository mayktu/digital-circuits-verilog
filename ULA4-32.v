module ULA(SW1, SW2, KEY, out, HEX0);

    input [3:0]SW1;
    input [3:0]SW2;
    input [2:0]KEY;

    output reg [3:0]out;
    output reg [0:6]HEX0;

    always@(*)
    case(KEY)
        3'b000: out = 4'b0000;
        3'b001: out = SW2 - SW1;
        3'b010: out = SW1 - SW2;
        3'b011: out = SW1 + SW2;
        3'b100: out = SW1 ^ SW2;
        3'b101: out = SW1 | SW2;
        3'b110: out = SW1 & SW2;
        3'b111: out = 4'b1111;
    endcase

    always@(*)
    case(out)
        4'b0000: HEX0 = 7'b0000001;
        4'b0001: HEX0 = 7'b1001111;
        4'b0010: HEX0 = 7'b0010010;
        4'b0011: HEX0 = 7'b0000110;
        4'b0100: HEX0 = 7'b1001100;
        4'b0101: HEX0 = 7'b0100100;
        4'b0110: HEX0 = 7'b0100000;
        4'b0111: HEX0 = 7'b0001101;
        4'b1000: HEX0 = 7'b0000000;
        4'b1001: HEX0 = 7'b0000100;
    endcase

endmodule