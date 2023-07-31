module fifo
(
input wire clk,reset,
input wire rd,wr,
input wire [7:0] w_data,

output wire empty,full,
output wire [3:0] r_data
);
//signal declaration
reg [7:0] array_reg [(2**8)-1:0];
reg [3:0] w_ptr_reg,w_ptr_next,w_ptr_succ;
reg [3:0] r_ptr_reg,r_ptr_next,r_ptr_succ;
reg full_reg,empty_reg,full_next,empty_next;
wire wr_en;

always @(posedge clk)
begin
	if(wr_en)
	array_reg[w_ptr_reg] <= w_data;
end

always @(posedge clk,posedge reset)
begin	
	if(reset)
	begin
		w_ptr_reg<=0;
		r_ptr_reg<=0;
		full_reg<=1'b0;
		empty_reg<=1'b1;
	end
	else
	begin
		w_ptr_reg <= w_ptr_next;
		r_ptr_reg <= r_ptr_next;
		full_reg <= full_next;
		empty_reg <= empty_next;
	end
end

always @*
begin
	w_ptr_succ=w_ptr_reg+1;
	r_ptr_succ=r_ptr_reg+1;
	w_ptr_next=w_ptr_reg;
	r_ptr_next=r_ptr_reg;
	full_next=full_reg;
	empty_next=empty_reg;
	case({wr,rd})
	2'b01:	if(~empty_reg)
		begin
		r_ptr_next=r_ptr_succ;
		full_next=1'b0;
		if(r_ptr_succ==w_ptr_reg)
		empty_next=1'b1;
		end
	2'b10:	if(~full_reg)
		begin
		w_ptr_next=w_ptr_succ;
		empty_next=1'b0;
		if(w_ptr_succ==r_ptr_reg)
		full_next=1'b1;
		end
	2'b11:
		begin
		w_ptr_next=w_ptr_succ;
		r_ptr_next=r_ptr_succ;
		end
	endcase

end

assign full=full_reg;
assign empty=empty_reg;
assign r_data = array_reg[r_ptr_reg];
assign wr_en = wr & ~full_reg;

whenfullnowrite: assume property (@(posedge clk)(full |-> !wr));
noreadwhenempty: assume property (@(posedge clk)(empty |-> !rd));
emptyandfullnotsame: assume property(@(posedge clk)(!(full&& empty)));
stayfulltillread :assert property(@(posedge clk)(full&!rd) |=> full );
stayemptytillwrite :assert property(@(posedge clk)(empty&!wr) |=> empty );

writeen : assert property (@(posedge clk)({(~wr),rd} && (~ empty_reg)) |-> $fell(full_next));
write : assert property (@(posedge clk)({wr,(~rd)}&&(~full_reg)) |-> $fell(empty_next));
output_read : assert property (@(posedge clk) (r_ptr_succ == w_ptr_reg) |-> $rose(empty_next));
output_write : assert property (@(posedge clk)(w_ptr_succ== r_ptr_reg) |-> $rose(full_next));

endmodule
