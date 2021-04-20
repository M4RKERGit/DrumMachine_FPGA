module BPMcalc(
input 		enable,
input	[7:0] BPM_in,
output[9:0] eight_note
);

assign eight_note = (enable) ? (30000/BPM_in) : eight_note;

endmodule