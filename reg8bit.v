module reg8bit (din, load, clk, aclr, dout);
input [7:0] din;
input load, clk, aclr;
output [7:0] dout;

reg [7:0] dout;

always @(negedge clk or posedge aclr)
begin
	if(aclr == 1'b1)
		dout = 8'b00000000;
	else if(load == 1'b1)
		dout = din;
	else
		dout = dout;
end

endmodule