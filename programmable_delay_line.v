module programmable_delay_line(SW, SMA_CLKOUT);

// total delay = nominal_delay + delta_delay * x
// for x in [0, N-1]
parameter nominal_delay = 0;
parameter delta_delay = 5;
parameter N = 18;

input [N-1:0] SW;
output SMA_CLKOUT;

wire [N-1:0] code;
wire pre_delayed /* synthesis keep */; 
wire post_delayed /* synthesis keep */;

assign code[N-1:0] = SW[N-1:0];
assign pre_delayed = ~post_delayed;
assign SMA_CLKOUT = post_delayed;

programmable_delay #(.nominal_delay(nominal_delay), .delta_delay(delta_delay), .N(N)) (pre_delayed, code[N-1:0], post_delayed);

endmodule
