module test;
reg clk,reset,sw;
wire db_level,db_tick;
debounce DUT(clk,reset,sw,db_level,db_tick);
initial 
begin
forever #10 clk=~clk;
end
initial 
begin
clk=1'b1;
reset=1'b0;
//#30 
//reset=1'b0;
end
initial
begin
sw=1'b0;
#60
sw=1'b1;
#2
sw=1'b0;
#2
sw=1'b1;
#5
sw=1'b0;
#2
sw=1'b1;
#3
sw=1'b0;
#2
sw=1'b1;
#130
sw=1'b0;
#2
sw=1'b1;
#3
sw=1'b0;
#2
sw=1'b1;
#1
sw=1'b0;
#2
sw=1'b1;
#5
sw=1'b0;
#160
sw=1'b1;
#2
sw=1'b0;
#2
sw=1'b1;
#5
sw=1'b0;
#2
sw=1'b1;
#3
sw=1'b0;
#2
sw=1'b1;
#130
sw=1'b0;
#2
sw=1'b1;
#3
sw=1'b0;
#2
sw=1'b1;
#1
sw=1'b0;
#2
sw=1'b1;
#5
sw=1'b0;
#160
sw=1'b0;
#20
$stop;
end



endmodule // test