module part3(A,B, Function,ALUout);
	input [3:0] A;
	input [3:0] B;
	input [2:0] Function;
	output reg [7:0] ALUout;
	
	wire [3:0] adder;
	wire [3:0] carry;
	FourBitFA p0(.a(A), .b(B), .c_in(1'b0), .s(adder[3:0]), .c_out(carry[3:0]));
	always @(*)
		begin
			case(Function)
			    3'b000: ALUout = {carry,adder};

			    3'b001: ALUout = {3'b0,A + B};

			    3'b010: 
				ALUout = {{4{B[3]}},B};
				
			    3'b011: 
				begin
				    if((A>0) | (B>0))
					ALUout = 8'b00000001;
		    		    else
					ALUout = 8'b0;
				end
			    3'b100: 
				begin
				    if(&{A,B})
					ALUout = 8'b00000001;
		    		    else
					ALUout = 8'b00000000;
				end
	
			    3'b101: ALUout = {A,B};

			    default: ALUout = 8'b0;
			endcase
		end
endmodule


module FA(a,b,c_in,s,c_out);
	input a,b,c_in;
	output s , c_out;
	assign s=(c_in ^ a ^ b);
	assign c_out=(a&b)|(c_in&a)|(c_in&b);
endmodule

module FourBitFA(a,b,c_in,s,c_out);
	input [3:0] a,b;
	input c_in;
	output [3:0] s;
	output [3:0] c_out;
	
	wire c1 , c2 , c3 , c4;
	
	FA bit0(a[0],b[0],c_in,s[0],c1);
	FA bit1(a[1],b[1],c1,s[1],c2);
	FA bit2(a[2],b[2],c2,s[2],c3);
	FA bit3(a[3],b[3],c3,s[3],c4);

	assign c_out = {c4,c3,c2,c1};
endmodule

module hex_decoder(c,display);
	input [3:0] c;
	output[6:0] display;
	
	assign c3 = c[0];
	assign c2 = c[1];
	assign c1 = c[2];
	assign c0 = c[3];
	
	assign display[0] = ~((~c3&~c2&~c1&~c0) + (~c3&~c2&c1&~c0) + (~c3&~c2&c1&c0) + (~c3&c2&~c1&c0) + (~c3&c2&c1&~c0) + (~c3&c2&c1&c0) + (c3&~c2&~c1&~c0) + (c3&~c2&~c1&c0) + (c3&~c2&c1&~c0) + (c3&c2&~c1&~c0) + (c3&c2&c1&~c0) + (c3&c2&c1&c0));
        assign display[1] = ~((~c3&~c2&~c1&~c0) + (~c3&~c2&~c1&c0) + (~c3&~c2&c1&~c0) + (~c3&~c2&c1&c0) + (~c3&c2&~c1&~c0) + (~c3&c2&c1&c0) + (c3&~c2&~c1&~c0) + (c3&~c2&~c1&c0) + (c3&~c2&c1&~c0) + (c3&c2&~c1&c0));
        assign display[2] = ~((~c3&~c2&~c1&~c0) + (~c3&~c2&~c1&c0) + (~c3&~c2&c1&c0) + (~c3&c2&~c1&~c0) + (~c3&c2&~c1&c0) + (~c3&c2&c1&~c0) + (~c3&c2&c1&c0) + (c3&~c2&~c1&~c0) + (c3&~c2&~c1&c0) + (c3&~c2&c1&~c0) + (c3&~c2&c1&c0) + (c3&c2&~c1&c0));
        assign display[3] = ~((~c3&~c2&~c1&~c0) + (~c3&~c2&c1&~c0) + (~c3&~c2&c1&c0) + (~c3&c2&~c1&c0) + (~c3&c2&c1&~c0) + (c3&~c2&~c1&~c0) + (c3&~c2&~c1&c0) + (c3&~c2&c1&c0) + (c3&c2&~c1&~c0) + (c3&c2&~c1&c0) + (c3&c2&c1&~c0));
        assign display[4] = ~((~c3&~c2&~c1&~c0) + (~c3&~c2&c1&~c0) + (~c3&c2&c1&~c0) + (c3&~c2&~c1&~c0) + (c3&~c2&c1&~c0) + (c3&~c2&c1&c0) + (c3&c2&~c1&~c0) + (c3&c2&~c1&c0) + (c3&c2&c1&~c0) + (c3&c2&c1&c0));
        assign display[5] = ~((~c3&~c2&~c1&~c0) + (~c3&c2&~c1&~c0) + (~c3&c2&~c1&c0) + (~c3&c2&c1&~c0) + (c3&~c2&~c1&~c0) + (c3&~c2&~c1&c0) + (c3&~c2&c1&~c0) + (c3&~c2&c1&c0) + (c3&c2&~c1&~c0) + (c3&c2&c1&~c0) + (c3&c2&c1&c0));
        assign display[6] = ~((~c3&~c2&c1&~c0) + (~c3&~c2&c1&c0) + (~c3&c2&~c1&~c0) + (~c3&c2&~c1&c0) + (~c3&c2&c1&~c0) + (c3&~c2&~c1&~c0) + (c3&~c2&~c1&c0) + (c3&~c2&c1&~c0) + (c3&~c2&c1&c0) + (c3&c2&~c1&c0) + (c3&c2&c1&~c0) + (c3&c2&c1&c0));
endmodule 


