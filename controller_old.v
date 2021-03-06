module controller(clk, cf_load, ld_sel, mac1a_sel, mac1b_sel, mac2a_sel, mac2b_sel, output_rdy, output_sel, mac1_output_sel, mac2_output_sel, counter, reg_out_sel);
input clk, cf_load;
output [11:0] ld_sel;
output [3:0] mac1a_sel, mac1b_sel, mac2a_sel, mac2b_sel;
output output_rdy;
output [1:0] output_sel;
output [2:0] mac1_output_sel, mac2_output_sel;
output [5:0] counter;
output [3:0] reg_out_sel;

reg reading;
reg [5:0] counter;
reg [11:0] ld_sel;
reg [1:0] output_sel;
reg [3:0] mac1a_sel, mac1b_sel, mac2a_sel, mac2b_sel;
reg [2:0] mac1_output_sel, mac2_output_sel;
reg output_rdy;
reg [3:0] reg_out_sel;
reg [5:0] output_counter;


always @(posedge clk)
begin

	// When cf_load is high, prepare to start reading coefficients.
	if(cf_load == 1'b1)
	begin
		reading <= 1'b1;
		counter <= 5'b00000;
		output_counter <= 5'b00000;
	end

	if(reading == 1'b1)
	begin
		// Only read coefficients after the first clock cycle has passed.
		case (counter)
			0:ld_sel [11:0] = 12'b000000000001;
			1:ld_sel [11:0] = 12'b000000000010;
			2:ld_sel [11:0] = 12'b000000000100;
			3:ld_sel [11:0] = 12'b000000001000;
			4:ld_sel [11:0] = 12'b000000010000;
			5:ld_sel [11:0] = 12'b000000100000;
			6:ld_sel [11:0] = 12'b000001000000;
			7:ld_sel [11:0] = 12'b000010000000;
			8:ld_sel [11:0] = 12'b000100000000;
			9:ld_sel [11:0] = 12'b001000000000;
			10:ld_sel [11:0] = 12'b010000000000;
			11:ld_sel [11:0] = 12'b100000000000;
			default:ld_sel [11:0] = 12'b000000000000;
		endcase

		// Case block for selecting inputs for MACs
		case (counter)

			// MAC1: Idle
			// MAC2: a11*a11
			// MAC1 Output: None
			// MAC2 Output: None
			1:	begin
					mac1a_sel [3:0] <= 4'b0000;
					mac1b_sel [3:0] <= 4'b0000;
					mac2a_sel [3:0] <= 4'b0000;
					mac2b_sel [3:0] <= 4'b0000;
					output_sel [1:0] <= 2'b00;

					mac1_output_sel [2:0] <= 3'b111;
					mac2_output_sel [2:0] <= 3'b111;
				end

			// MAC1: Idle
			// MAC2: a21*a21
			// MAC1 Output: None
			// MAC2 Output: None
			2:	begin
					mac1a_sel [3:0] <= 4'b0000;
					mac1b_sel [3:0] <= 4'b0000;
					mac2a_sel [3:0] <= 4'b0001;
					mac2b_sel [3:0] <= 4'b0001;
					output_sel [1:0] <= 2'b00;

					mac1_output_sel [2:0] <= 3'b111;
					mac2_output_sel [2:0] <= 3'b111;
				end

			// MAC1: Idle
			// MAC2: a31*a31
			// MAC1 Output: None
			// MAC2 Output: None
			3:	begin
					mac1a_sel [3:0] <= 4'b0000;
					mac1b_sel [3:0] <= 4'b0000;
					mac2a_sel [3:0] <= 4'b0010;
					mac2b_sel [3:0] <= 4'b0010;
					output_sel [1:0] <= 2'b00;

					mac1_output_sel [2:0] <= 3'b111;
					mac2_output_sel [2:0] <= 3'b111;
				end

			// MAC1: a11*a12
			// MAC2: a12*a12
			// MAC1 Output: None
			// MAC2 Output: None
			4:	begin
					mac1a_sel [3:0] <= 4'b0000;
					mac1b_sel [3:0] <= 4'b0011;
					mac2a_sel [3:0] <= 4'b0011;
					mac2b_sel [3:0] <= 4'b0011;
					output_sel [1:0] <= 2'b00;

					mac1_output_sel [2:0] <= 3'b111;
					mac2_output_sel [2:0] <= 3'b111;


				end

			// MAC1: a21*a22
			// MAC2: a22*a22
			// MAC1 Output: None
			// MAC2 Output: None
			5:	begin
					mac1a_sel [3:0] <= 4'b0001;
					mac1b_sel [3:0] <= 4'b0100;
					mac2a_sel [3:0] <= 4'b0100;
					mac2b_sel [3:0] <= 4'b0100;
					output_sel [1:0] <= 2'b00;

					mac1_output_sel [2:0] <= 3'b111;
					mac2_output_sel [2:0] <= 3'b111;

				end

			// MAC1: a31*a32
			// MAC2: a32*a32
			// MAC1 Output: None
			// MAC2 Output: None
			6:	begin
					mac1a_sel [3:0] <= 4'b0010;
					mac1b_sel [3:0] <= 4'b0101;
					mac2a_sel [3:0] <= 4'b0101;
					mac2b_sel [3:0] <= 4'b0101;
					output_sel [1:0] <= 2'b11;

					mac1_output_sel [2:0] <= 3'b111;
					mac2_output_sel [2:0] <= 3'b111;

				end

			// MAC1: a11*a13
			// MAC2: a13*a13
			// MAC1 Output: None
			// MAC2 Output: b11
			7:	begin
					mac1a_sel [3:0] <= 4'b0000;
					mac1b_sel [3:0] <= 4'b0110;
					mac2a_sel [3:0] <= 4'b0110;
					mac2b_sel [3:0] <= 4'b0110;
					output_sel [1:0] <= 2'b10;

					mac1_output_sel [2:0] <= 3'b111;
					mac2_output_sel [2:0] <= 3'b000;

				end

			// MAC1: a21*a23
			// MAC2: a23*a23
			// MAC1 Output: None
			// MAC2 Output: None
			8:	begin
					mac1a_sel [3:0] <= 4'b0001;
					mac1b_sel [3:0] <= 4'b0111;
					mac2a_sel [3:0] <= 4'b0111;
					mac2b_sel [3:0] <= 4'b0111;
					output_sel [1:0] <= 2'b11;

					mac1_output_sel [2:0] <= 3'b111;
					mac2_output_sel [2:0] <= 3'b111;
				end

			// MAC1: a31*a33
			// MAC2: a33*a33
			// MAC1 Output:
			// MAC2 Output:
			9:	begin
					mac1a_sel [3:0] <= 4'b0010;
					mac1b_sel [3:0] <= 4'b1000;
					mac2a_sel [3:0] <= 4'b1000;
					mac2b_sel [3:0] <= 4'b1000;

					mac1_output_sel [2:0] <= 3'b111;
					mac2_output_sel [2:0] <= 3'b111;
				end

			// MAC1: a11*a14
			// MAC2: a14*a14
			// MAC1 Output: b12
			// MAC2 Output: b22
			10:	begin
					mac1a_sel [3:0] <= 4'b0000;
					mac1b_sel [3:0] <= 4'b1001;
					mac2a_sel [3:0] <= 4'b1001;
					mac2b_sel [3:0] <= 4'b1001;
					output_sel [1:0] <= 2'b11;

					mac1_output_sel [2:0] <= 3'b000;
					mac2_output_sel [2:0] <= 3'b001;
				end

			// MAC1: a12*a24
			// MAC2: a24*a24
			// MAC1 Output: None
			// MAC2 Output: None
			11:	begin
					mac1a_sel [3:0] <= 4'b0001;
					mac1b_sel [3:0] <= 4'b1010;
					mac2a_sel [3:0] <= 4'b1010;
					mac2b_sel [3:0] <= 4'b1010;
					output_sel [1:0] <= 2'b11;

					mac1_output_sel [2:0] <= 3'b111;
					mac2_output_sel [2:0] <= 3'b111;

					output_rdy <= 1'b1;
					reg_out_sel [3:0] <= 4'b0001;
				end

			// MAC1: a13*a34
			// MAC2: a34*a34
			12:	begin
					mac1a_sel [3:0] <= 4'b0010;
					mac1b_sel [3:0] <= 4'b1011;
					mac2a_sel [3:0] <= 4'b1011;
					mac2b_sel [3:0] <= 4'b1011;
					output_sel [1:0] <= 2'b11;

					mac1_output_sel [2:0] <= 3'b111;
					mac2_output_sel [2:0] <= 3'b111;
				end

			// MAC1: a12*a13
			// MAC2: a12*a14
			// MAC1 Output: b13
			// MAC2 Output: b33
			13:	begin
					mac1a_sel [3:0] <= 4'b0011;
					mac1b_sel [3:0] <= 4'b0110;
					mac2a_sel [3:0] <= 4'b0011;
					mac2b_sel [3:0] <= 4'b1001;
					output_sel [1:0] <= 2'b11;

					mac1_output_sel [2:0] <= 3'b001;
					mac2_output_sel [2:0] <= 3'b010;
				end

			// MAC1: a22*a23
			// MAC2: a22*a24
			// MAC1 Output: None
			// MAC2 Output: None
			14:	begin
					mac1a_sel [3:0] <= 4'b0100;
					mac1b_sel [3:0] <= 4'b0111;
					mac2a_sel [3:0] <= 4'b0100;
					mac2b_sel [3:0] <= 4'b1010;
					output_sel [1:0] <= 2'b00;

					mac1_output_sel [2:0] <= 3'b111;
					mac2_output_sel [2:0] <= 3'b111;
				end

			// MAC1: a32*a33
			// MAC2: a32*a34
			15:	begin
					mac1a_sel [3:0] <= 4'b0101;
					mac1b_sel [3:0] <= 4'b1000;
					mac2a_sel [3:0] <= 4'b0101;
					mac2b_sel [3:0] <= 4'b1011;
					output_sel [1:0] <= 2'b11;

					mac1_output_sel [2:0] <= 3'b111;
					mac2_output_sel [2:0] <= 3'b111;
				end

			// MAC1: a13*a14
			// MAC2: Idle
			// MAC1 Output: b14
			// MAC2 Output: b44
			16:	begin
					mac1a_sel [3:0] <= 4'b0110;
					mac1b_sel [3:0] <= 4'b1001;
					mac2a_sel [3:0] <= 4'b0000;
					mac2b_sel [3:0] <= 4'b0000;
					output_sel [1:0] <= 2'b11;

					mac1_output_sel [2:0] <= 3'b010;
					mac2_output_sel [2:0] <= 3'b011;
				end

			// MAC1: a23*a24
			// MAC2: Idle
			// MAC1 Output: None
			// MAC2 Output: None
			17:	begin
					mac1a_sel [3:0] <= 4'b0111;
					mac1b_sel [3:0] <= 4'b1010;
					mac2a_sel [3:0] <= 4'b0000;
					mac2b_sel [3:0] <= 4'b0000;
					output_sel [1:0] <= 2'b00;

					mac1_output_sel [2:0] <= 3'b111;
					mac2_output_sel [2:0] <= 3'b111;
				end

			// MAC1: a33*a34
			// MAC2: Idle
			18:	begin
					mac1a_sel [3:0] <= 4'b1000;
					mac1b_sel [3:0] <= 4'b1011;
					mac2a_sel [3:0] <= 4'b0000;
					mac2b_sel [3:0] <= 4'b0000;
					output_sel [1:0] <= 2'b00;

					mac1_output_sel [2:0] <= 3'b111;
					mac2_output_sel [2:0] <= 3'b111;


				end

			// MAC1: Idle
			// MAC2: Idle
			// MAC1 Output: b23
			// MAC2 Output: b24
			19:	begin
					mac1a_sel [3:0] <= 4'b0000;
					mac1b_sel [3:0] <= 4'b0000;
					mac2a_sel [3:0] <= 4'b0000;
					mac2b_sel [3:0] <= 4'b0000;
					output_sel [1:0] <= 2'b11;

					mac1_output_sel [2:0] <= 3'b011;
					mac2_output_sel [2:0] <= 3'b100;

				end

			// MAC1: Idle
			// MAC2: Idle
			// MAC1 Output: None
			// MAC2 Output: None
			20:	begin
					mac1a_sel [3:0] <= 4'b1000;
					mac1b_sel [3:0] <= 4'b0000;
					mac2a_sel [3:0] <= 4'b0000;
					mac2b_sel [3:0] <= 4'b0000;
					output_sel [1:0] <= 2'b00;

					mac1_output_sel [2:0] <= 3'b111;
					mac2_output_sel [2:0] <= 3'b111;

					//reading <= 1'b0;

				end

			// MAC1: Idle
			// MAC2: Idle
			default:
				begin
					mac1a_sel [3:0] <= 4'b0000;
					mac1b_sel [3:0] <= 4'b0000;
					mac2a_sel [3:0] <= 4'b0000;
					mac2b_sel [3:0] <= 4'b0000;
					output_sel [1:0] <= 2'b00;

					mac1_output_sel [2:0] <= 3'b111;
					mac2_output_sel [2:0] <= 3'b111;
				end
		endcase


		// If there are still values to read, increment counter.
		if(reading == 1'b1)
		begin
			if(counter < 20)
				counter <= counter + 5'b00001;
			else
				counter <= 5'b00010;
		end

	end

end

endmodule