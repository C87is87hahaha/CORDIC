`timescale 1 ns/100 ps


module CORDIC(clock, angle, xin, yin, xout, yout);

parameter xy_size = 8;
localparam STG = xy_size;

input clock;
input signed [31:0] angle;
input signed [xy_size-1:0] xin;
input signed [xy_size-1:0] yin;
output signed [xy_size:0] xout;
output signed [xy_size:0] yout;


wire signed [31:0] atan [0:30];

assign atan[00] = 32

wire [1:0] qr;
	assign atan_table[00] = 32'b00100000000000000000000000000000; // 45.000 degrees -> atan(2^0)
  	assign atan_table[01] = 32'b00010010111001000000010100011101; // 26.565 degrees -> atan(2^-1)
	assign atan_table[02] = 32'b00001001111110110011100001011011; // 14.036 degrees -> atan(2^-2)
	assign atan_table[03] = 32'b00000101000100010001000111010100; // atan(2^-3)
	assign atan_table[04] = 32'b00000010100010110000110101000011;
	assign atan_table[05] = 32'b00000001010001011101011111100001;
	assign atan_table[06] = 32'b00000000101000101111011000011110;
	assign atan_table[07] = 32'b00000000010100010111110001010101;
	assign atan_table[08] = 32'b00000000001010001011111001010011;
/*	
	assign atan_table[09] = 32'b00000000000101000101111100101110;
	assign atan_table[10] = 32'b00000000000010100010111110011000;
	assign atan_table[11] = 32'b00000000000001010001011111001100;
	assign atan_table[12] = 32'b00000000000000101000101111100110;
	assign atan_table[13] = 32'b00000000000000010100010111110011;
	assign atan_table[14] = 32'b00000000000000001010001011111001;
	assign atan_table[15] = 32'b00000000000000000101000101111101;
	assign atan_table[16] = 32'b00000000000000000010100010111110;
	assign atan_table[17] = 32'b00000000000000000001010001011111;
	assign atan_table[18] = 32'b00000000000000000000101000101111;
	assign atan_table[19] = 32'b00000000000000000000010100011000;
	assign atan_table[20] = 32'b00000000000000000000001010001100;
	assign atan_table[21] = 32'b00000000000000000000000101000110;
	assign atan_table[22] = 32'b00000000000000000000000010100011;
	assign atan_table[23] = 32'b00000000000000000000000001010001;
	assign atan_table[24] = 32'b00000000000000000000000000101000;
	assign atan_table[25] = 32'b00000000000000000000000000010100;
	assign atan_table[26] = 32'b00000000000000000000000000001010;
	assign atan_table[27] = 32'b00000000000000000000000000000101;
	assign atan_table[28] = 32'b00000000000000000000000000000010;
	assign atan_table[29] = 32'b00000000000000000000000000000001;
	assign atan_table[30] = 32'b00000000000000000000000000000000;
*/

// --------------- //
//    registers    //
// --------------- //




reg signed [xy_size:0] x [0:STG-1];
reg signed [xy_size:0] y [0:STG-1];
reg signed [31:0] z [0:STG-1];


// ------------------------ //
//          stage 0         //
// ------------------------ //

wire [1:0] quadrant;
assign quadrant = angle[31:30];

always @(posedge clock) 
begin
	case (quadrant)
		2'b00,
		2'b11:
		begin  
			x[0] <= xin;
			y[0] <= yin;
			z[0] <= zin;
		end
		2'b01:
		begin
			x[0] <= -yin;
			y[0] <= xin;
			z[0] <= {2'b00,angle[29:0]}; // sub pi/2 from angle for this quadrant
		end
		2'b10:
		begin
			x[0] <= yin;
			y[0] <= -xin;
			z[0] <= {2'b11,angle[29:0]}; // add pi/2 to angle for this quadrant
		end
	endcase
end
// --------------------------------------------- //
//          generate stages 1 to STG - 1         //
// --------------------------------------------- //
genvar i;

generate
for(i=0; i<(STG-1); i=i+1)
begin: xyz

	wire z_sign;
	wire signed [xy_size:0] x_shr, y_shr;

	assign x_shr = x[i] >>> i; // signed shift right
	assign y_shr = y[i] >>> i;

	assign z_sign = z[i][31];
	always @(posedge clock)
	begin
		// add/sub shifted data
		x[i+1] <= z_sign ? x[i] + y_shr : x[i] - y_shr;
		y[i+1] <= z_sign ? y[i] - x_shr : y[i] + x_shr;
		z[i+1] <= z_sign ? z[i] +
	end
end
endgenerate

assign xout = x[STG-1];
assign yout = y[STG-1];
endmodule

