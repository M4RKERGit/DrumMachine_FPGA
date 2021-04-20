module debouncer(
  input btn0,
  input btn1,
  input nrst,
  input clk,
  
  output synced_but
  );
    
reg [1:0] button_syncroniser;
wire      key_event;

assign key_event =  btn0 || btn1;

always @( posedge clk or negedge nrst ) begin
  if ( !nrst )
    button_syncroniser <= 2'b0;
  else begin
    button_syncroniser[0] <= ~key_event;
    button_syncroniser[1] <=  button_syncroniser[0];
  end
end

assign synced_but = ~button_syncroniser[1] & button_syncroniser[0];

endmodule