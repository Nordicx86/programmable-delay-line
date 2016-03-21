# programmable-delay-line

A resource-efficient Verilog implementation of an asynchronous, adjustable delay line.

Asynchronous delay lines are implemented by wiring pairs of inverter gates in series.
Pairs of inverter gates (instead of single buffers) to correct for the possibility of asymmetry between rise and fall
times of FPGA logic elements (LEs). For example, if the LEs tend to have a fast fall time than rise time, falling edges
will propagate through a LE faster than rising edges, causing pulses to shrink. Inverter gates turn rising edges into
falling edges and vice-versa, which corrects somewhat for this effect.

The actual amount of time delay that is implemented is highly hardware-dependent. I typically use Altera Cyclone IV FPGAs, 
and have measured the average response time of a single logic element to be about 300 ps. So the total delay of my lines
is approximately 2 * N * (.3 ns). Keep in mind that precise control (i.e. below the order of 100 ps) 
of the amount of delay is an extremely difficult task.

## Files

1. programmable_delay.v: A module that instantiates adjustable delay lines
2. programmable_delay_line.v: A top-level module for a simple test project using some switches

## Parameters

All parameters are mandatory and have no defaults.
- nominal_delay: "y intercept" of the delay, i.e. the number of delay elements when code = 0
- delta_delay: "slope" of the delay, i.e. the number of delay elements the line is increased by when code is increased
- N: The number of possible combinations. Should be a power of 2.
- log2_N: log2(N)

## Arguments

in: input, single wire. The signal you want to delay
code: input, array of log2_N wires. A binary value that selects the amount of delay
out: output, single wire. The input signal, delayed by the desired amount

The total amount of delay increases linearly with code, i.e.

total_delay = nominal_delay + delta_delay * code; code in [0,N-1]
