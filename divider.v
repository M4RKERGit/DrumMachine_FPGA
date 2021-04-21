module divider(
input      	nrst,
input  		clk_rx,
output reg 	clk_tx
);

  reg	[11:0]	millis_counter;

 always @ (posedge clk_rx or negedge nrst) begin
   if ( ~nrst ) 	begin
     clk_tx <= 1'b0;
   end
   else
	
	if	( clk_rx )	begin
		millis_counter = millis_counter + 1;
		
		if ( millis_counter == 12'd3 )	begin
		clk_tx = ~clk_tx;
		millis_counter = 12'd0;
		end
		
		
   end
	
	
 end

endmodule

