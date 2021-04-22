module divider(
input      	nrst,
input  		clk_rx,
output reg 	clk_tx,
output reg	clk_front
);

  reg	[11:0]	millis_counter;

 always @ (posedge clk_rx or negedge nrst) begin
   if ( ~nrst ) 	begin
     clk_tx <= 1'b0;
   end
   else
	
	if	( clk_rx )	begin
		clk_front <= clk_rx;
		millis_counter = millis_counter + 1;
		
		if ( millis_counter == 12'd3 )	begin
		clk_tx <= ~clk_tx;
		millis_counter <= 12'd0;
		end
   end
 end

endmodule

