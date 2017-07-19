
module sublime_tb;
parameter  xy_size = 8;
localparam STG = xy_size;

reg clock;
reg [31:0] angle;
reg [xy_size-1:0] xin;
reg [xy_size-1:0] yin;
reg signed [63:0] i;

wire [xy_size-1:0] xout;
wire [xy_size-1:0] yout;

localparam An = 32000/1.647;

initial 
begin
	$dumpfile("cordic.vcd");
	$dumpvars;
	angle = 32'b00110101010101010101010101010101;
	xin = An;
	yin = 0;

	clock = 0;

	#1000
	angle = 32'b00100000000000000000000000000000;

	#1000
	$write("Simulation has finished");
	$stop;
end
always #10 clock = !clock;
sublime s(
		.clock(clock),
 		.angle(angle),
 		.xin(xin),
 		.yin(yin),
 		.xout(xout),
 		.yout(yout)
 		);

initial 
	$monitor($time," clock=%d, angle=%d, xin=%d, yin=%d, xout=%d, yout=%d", clock, angle, xin, yin, xout, yout);
endmodule
