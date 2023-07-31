module elevator
(
input wire clk,reset,
input wire [1:0] req_floor,
output reg [2:0] y,
output reg door,
output reg [1:0] present_state
);
reg [2:0] cf ;
parameter UP = 2'b01, DOWN = 2'b10, STOP = 2'b11;
always @ (posedge clk)
begin
	if(reset)
	begin
		cf = 3'd0;
		present_state = STOP;
		door = 1'b1;
	end
	else
	begin
		if(req_floor < 3'd7)
		begin
			if(req_floor == cf )
			begin
				cf = req_floor;
				door=1'b1;
				present_state=STOP;
			end
			else if (req_floor > cf)
			begin
				cf = cf+1;
				door=1'b0;
				present_state = UP;
			end
			else if(req_floor < cf )
			begin
				cf=cf-1;
				door=1'b0;
				present_state = DOWN;
			end
		end
	end
  y = cf;
end
endmodule
