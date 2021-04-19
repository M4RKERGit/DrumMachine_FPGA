module DrumMachine(
input 		clk,
input 		nrst,
input	[1:0]	BT_push,
input [2:0]	SW
);

reg 	[7:0]	BPM_value;
reg	[95:0]	map	[3:0];
reg 	[1:0]	map_pointer;

always @( posedge clk or negedge nrst or negedge BT_push[1] or negedge BT_push[0] ) begin
	if ( !nrst )
		BPM_value <= 140;
	else if ( !BT_push[1])
		BPM_value = BPM_value + 5;
	else if ( !BT_push[0])
		BPM_value = BPM_value - 5;
	else if ( SW[2] ) begin
		map_pointer[1] = SW[1];
		map_pointer[0] = SW[0];
		case( //далее логика работы
		
		
end

endmodule