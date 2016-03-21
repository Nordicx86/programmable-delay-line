module programmable_delay_line(SW, SMA_CLKOUT);

// total delay = nominal_delay + delta_delay * x
// for x in [0, N-1]
parameter nominal_delay = 0;
parameter delta_delay = 5;
parameter N = 16;
parameter log2_N = 4;

input [log2_N-1:0] SW;
output SMA_CLKOUT;

wire [log2_N-1:0] code;
wire pre_delayed /* synthesis keep */; 
wire post_delayed /* synthesis keep */;

assign code[log2_N-1:0] = SW[log2_N-1:0];
assign pre_delayed = ~post_delayed;
assign SMA_CLKOUT = post_delayed;

programmable_delay #(.nominal_delay(nominal_delay), .delta_delay(delta_delay), .N(N), .log2_N(log2_N)) (pre_delayed, code[log2_N-1:0], post_delayed);

endmodule
