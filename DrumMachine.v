module DrumMachine(
input 					clk,
input 					nrst,
input			[1:0]		BT_push,
input 		[2:0]		SW,
output reg 	[7:0] 	BPM_value,
//output reg	[95:0]	chosen_map,
output reg	[1:0]		map_pointer,
output wire 			btn_pressed
);

//reg	[95:0]	map	[3:0];
reg	[2:0]		cur_sample;
wire	[9:0]		eight_note;
reg	[6:0]		map_counter;


always @( posedge clk or negedge nrst) begin
	if ( !nrst )
		BPM_value = 140;
	else if( clk ) begin
	
		if ( clk ) begin
			if ( !BT_push[1] )
				BPM_value = BPM_value + 5;
			if ( !BT_push[0] )
				BPM_value = BPM_value - 5;
		end
		
		if ( SW[2] ) begin
		map_pointer[1] = SW[1];
		map_pointer[0] = SW[0];
		//case( map_pointer )
			//0:	chosen_map = map[0];
			//1:	chosen_map = map[1];
			//2:	chosen_map = map[2];
			//3:	chosen_map = map[3];
		//endcase
		
		end
	end
end

BPMcalc 		mainCalc(
	.enable				(SW[2]),
	.BPM_in				(BPM_value),
	.eight_note			(eight_note)
);

BeatSynt 	mainSynt(
	.enable				(SW[2]),
	.map_value			(cur_sample),
	.eight_note			(eight_note)
);

debouncer	mainDeb(
	.btn0					(BT_push[0]),
	.btn1					(BT_push[1]),
	.nrst					(nrst),
	.clk					(clk),
	.synced_but			(btn_pressed)
);

endmodule