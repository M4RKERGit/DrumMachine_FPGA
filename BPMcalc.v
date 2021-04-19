module BPMcalc(
input 		enable,
input	[7:0] BPM_in,
output[9:0] eight_note_out
);

assign eight_note_out = (enable) ? (30000/BPM_in) : eight_note_out;

endmodule