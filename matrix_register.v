module matrix_register (din, a11out, a21out, a31out, a12out, a22out, a32out, a13out, a23out, a33out, a14out, a24out, a34out, clk, load, aclr);
input [7:0] din;
input [11:0] load;
input clk, aclr;

output [7:0] a11out, a21out, a31out, a12out, a22out, a32out, a13out, a23out, a33out, a14out, a24out, a34out;

reg8bit a11 (.din(din), .load(load[0]), .clk(clk), .aclr(aclr), .dout(a11out));
reg8bit a21 (.din(din), .load(load[1]), .clk(clk), .aclr(aclr), .dout(a21out));
reg8bit a31 (.din(din), .load(load[2]), .clk(clk), .aclr(aclr), .dout(a31out));
reg8bit a12 (.din(din), .load(load[3]), .clk(clk), .aclr(aclr), .dout(a12out));
reg8bit a22 (.din(din), .load(load[4]), .clk(clk), .aclr(aclr), .dout(a22out));
reg8bit a32 (.din(din), .load(load[5]), .clk(clk), .aclr(aclr), .dout(a32out));
reg8bit a13 (.din(din), .load(load[6]), .clk(clk), .aclr(aclr), .dout(a13out));
reg8bit a23 (.din(din), .load(load[7]), .clk(clk), .aclr(aclr), .dout(a23out));
reg8bit a33 (.din(din), .load(load[8]), .clk(clk), .aclr(aclr), .dout(a33out));
reg8bit a14 (.din(din), .load(load[9]), .clk(clk), .aclr(aclr), .dout(a14out));
reg8bit a24 (.din(din), .load(load[10]), .clk(clk), .aclr(aclr), .dout(a24out));
reg8bit a34 (.din(din), .load(load[11]), .clk(clk), .aclr(aclr), .dout(a34out));

endmodule