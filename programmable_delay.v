
module programmable_delay(in,code,out);

// total delay = nominal_delay + delta_delay * x
// for x in [0, N-1]
parameter nominal_delay, delta_delay, N;

input in /*synthesis keep*/;
input [N-1:0] code;
output out /*synthesis keep*/; 

//synthesis keep = 1;
wire [N-1:0] mux_output /* synthesis keep */;
wire [2*delta_delay*(N-1)-1:0] internal_wire /* synthesis keep */;

// nested generate loops = ugly code
assign mux_output[N-1] = code[N-1] & in;
genvar i, j;
generate
	for (i = 0; i < (N-1); i = i+1)
		begin: outer_loop
			assign internal_wire[delta_delay*2*i] = ~((code[i] & in) | (~code[i] & mux_output[i+1]));
			for (j = 1; j < 2*delta_delay; j = j+1)
				begin: inner_loop
					assign internal_wire[delta_delay*2*i+j] = ~internal_wire[delta_delay*2*i+j-1];
				end
			assign mux_output[i] = internal_wire[delta_delay*2*i+2*delta_delay-1];
		end
endgenerate

assign out = mux_output[0];

endmodule
