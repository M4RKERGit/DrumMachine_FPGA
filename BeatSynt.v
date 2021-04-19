module BeatSynt(
input 		enable,
input	[2:0] map_value
);

always @(enable) begin
case (map_value)
	0: ;//отсутствие звука
	1:	;//бочка
	2:	;//рабочий
	3:	;//хэт
	4:	;//бочка и рабочий
	5:	;//бочка и хэт
	6:	;//рабочий и хэт
	7:	;//бочка, рабочий, хэт
endcase
end

endmodule