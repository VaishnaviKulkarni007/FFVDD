module elevator_tb();
reg clk,reset;
reg [2:0] req_floor;
wire y;
wire door;
wire [1:0] present_state;
elevator dut (.req_floor(req_floor),.y(y),.clk(clk),.reset(reset),.door(door),.present_state());
initial begin
clk=0;
forever #5 clk =~ clk;
end
initial begin 
  $dumpfile("file.vcd");
  $dumpvars(1);
reset = 1; //G floor
#20;
reset = 0;
req_floor=3'd0; //
#30;
req_floor=3'd3;
#10;
req_floor=3'd4;
#30;
req_floor=3'd7;
#60;
req_floor=3'd1;
#100;
$finish;
end
//immediate assertions
req_floor_G: assert final(req_floor == 3'd0);
req_floor_1: assert final(req_floor == 3'd1);
req_floor_2: assert final(req_floor == 3'd2);
req_floor_3: assert final(req_floor == 3'd3);
req_floor_4: assert final(req_floor == 3'd4);
req_floor_5: assert final(req_floor == 3'd5);
req_floor_6: assert final(req_floor == 3'd6);
req_floor_7: assert final(req_floor == 3'd7);
y_G: assert final (y == 3'd0);
y_1: assert final (y == 3'd1);
y_2: assert final (y == 3'd2);
y_3: assert final (y == 3'd3);
y_4: assert final (y == 3'd4);
y_5: assert final (y == 3'd5);
y_6: assert final (y == 3'd6);
y_7: assert final (y == 3'd7);
endmodule
