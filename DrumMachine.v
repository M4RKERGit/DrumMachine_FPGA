module DrumMachine(
input 					clk,
input 					nrst,
input			[1:0]		BT_push,			//кнопки
input 		[2:0]		SW,				//свитчи
output reg 	[7:0] 	BPM_value,		//кол-во У/М
output reg	[95:0]	chosen_map,		//какая мапа сейчас играет
output reg	[1:0]		map_pointer,	//и её номер
output reg	[9:0]		time_counter,	//секундомер для переключения семплов
output wire 			btn_pressed,	//дебаунс кнопки
output wire				clk_div,			//отсчёт 1мс
output reg	[4:0]		map_counter,	//какой элемент мапы сейчас играет
output reg	[2:0]		cur_sample,		//звучащий сейчас семпл
output wire	[9:0]		eight_note		//длительность восьмой ноты (кол-во миллисекунд)
);

reg	[95:0]	map	[3:0];			//массив мап
reg	[6:0]		high_border;
reg	[6:0]		low_border;


always @( posedge clk or negedge nrst ) begin
	if ( !nrst ) begin
		BPM_value = 140;
		time_counter = 0;
		cur_sample = chosen_map[2:0];
	end
	else 
	if( clk ) begin
		if ( !BT_push[1] )
			BPM_value = BPM_value + 5;
		if ( !BT_push[0] )
			BPM_value = BPM_value - 5;
			
		high_border = map_counter * 3;
		low_border = high_border - 3;
			
		time_counter = time_counter + 1;
		if ( time_counter >= eight_note )	begin
			map_counter = map_counter + 1;
			time_counter = 0;
		end

		if ( SW[2] ) begin
		map_pointer[1] = SW[1];
		map_pointer[0] = SW[0];
		case( map_pointer )
			0:	chosen_map = map[0];
			1:	chosen_map = map[1];
			2:	chosen_map = map[2];
			3:	chosen_map = map[3];
		endcase
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

divider		mainDiv (
	.nrst					(nrst),
	.clk_rx				(clk),
	.clk_tx				(clk_div)
);

endmodule