module ULA32b(SW1, SW2, KEY, out);

    input [31:0]SW1;
    input [31:0]SW2;
    input [4:0]KEY;
    output reg [31:0]out;

    reg [31:0]outi;


always@(*)
    case(KEY[4:2])
        //PASS OUT
        3'b000: outi = SW1;             //A
        3'b001: outi = SW2 + SW1;       //A+B
        3'b010: outi = SW1 - SW2;       //A-B
        3'b011: outi = SW1 & SW2;       //A&B
        3'b100: outi = SW1 | SW2;       //AORB
        3'b101: outi = SW1 + 1;         //A+1
        3'b110: outi = SW1 -1;          //A-1
        3'b111: outi = SW2;             //B
    endcase

always@(*)
    case(KEY[1:0])
        2'b00: out = outi;              //out
        2'b01: out = outi << 1;         //shift left
        2'b10: out = outi >> 1;         //shift right
        2'b11: out = 0;                 //0
    endcase

endmodule
