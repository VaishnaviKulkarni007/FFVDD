module fifo_tb;
reg clk;
reg reset;
reg rd;
reg wr;
reg [7:0]w_data;
wire empty;
wire full; 
wire[3:0]r_data;
fifo uut(.clk(clk),.reset(reset),.rd(rd),.wr(wr),.w_data(w_data),.empty(empty),.full(full),.r_data(r_data));
always
begin
clk=1'b0;
#10;
clk=1'b1;
#10;
end
initial
begin
  $dumpfile("file.vcd");
  $dumpvars(1);
  reset=1'b1;
  #120;
reset=1'b0;
rd=1'b0;
wr=1'b1;
w_data=8'h1;
#20;
w_data=8'h2;
#20;
w_data=8'h3;
#20;
w_data=8'h4;
#20;
w_data=8'h5;
#20;
w_data=8'h6;
#20;
w_data=8'h7;
#20;
w_data=8'h8;
#20;
w_data=8'h9;
#20;
w_data=8'hA;
#20;
rd=1'b1;
wr=1'b0;
#120;
$finish;
end
endmodule
