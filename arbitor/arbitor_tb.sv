module tb();

reg clk;
reg req0;
reg req1;
reg req2;
reg req3;
reg rst_an;
reg grant;

round_robin_arbiter dut (
	.req({req3,req2,req1,req0}),
	.grant({grant3,grant2,grant1,grant0}),
	.clk(clk),
	.rst_an(rst_an)
);

always	
begin
	#1; 
	clk = ~clk;
end
initial
begin
	clk = 0;
	req3 = 0;
	req2 = 0;
	req1 = 0;
	req0 = 0;
	rst_an = 1;
	#10 
	rst_an = 0;
	#10 
	rst_an = 1;
	repeat (1) @ (posedge clk);
		req0 <= 1;
	repeat (1) @ (posedge clk);
		req0 <= 0;
		req1 <= 1;
	repeat (1) @ (posedge clk);
		req0 <= 1;
		req1 <= 0;
		req2 <= 1;
	repeat (1) @ (posedge clk);
		req2 <= 1;
		req1 <= 0;
	repeat (1) @ (posedge clk);
		req0 <= 1;
		req1 <= 0;
		req2 <= 1;
		req3 <= 1;
	repeat (1) @ (posedge clk);
		req0 <= 0;
		req1 <= 0;
		req2 <= 0;
		req3 <= 1;
	repeat (1) @ (posedge clk);
		req0 <= 1;
		req1 <= 1;
		req2 <= 1;
		req3 <= 1;
	repeat (1) @ (posedge clk);
		req0 <= 1;
		req1 <= 1;
		req2 <= 0;
		req3 <= 0;
	repeat (1) @ (posedge clk);
		req0 <= 0;
		req1 <= 1;
		req2 <= 1;
		req3 <= 0;
	repeat (1) @ (posedge clk);
	#10  $finish;
end

//immediate assertions
/*
allinputzeros: assert final(~req0 && ~req1 && ~req2 && ~req3);
req_0001: assert final(~req3 && ~req2 && ~req1 && req0);
req_0010: assert final(~req3 && ~req2 && req1 && ~req0);
req_0011: assert final(~req3 && ~req2 && req1 && req0);
req_0100: assert final(~req3 && req2 && ~req1 && ~req0);
req_0101: assert final(~req3 && req2 && ~req1 && req0);
req_0110: assert final(~req3 && req2 && req1 && ~req0);
req_0111: assert final(~req3 && req2 && req1 && req0);
req_1000: assert final(req3 && ~req2 && ~req1 && ~req0);
req_1001: assert final(req3 && ~req2 && ~req1 && req0);
req_1010: assert final(req3 && ~req2 && req1 && ~req0);
req_1011: assert final(req3 && ~req2 && req1 && req0);
req_1100: assert final(req3 && req2 && ~req1 && ~req0);
req_1101: assert final(req3 && req2 && ~req1 && req0);
req_1110: assert final(req3 && req2 && req1 && ~req0);
allinputones: assert final((req0) && (req1) && (req2) && (req3));

only_req0: assert final(~req3 && ~req2 && ~req1 && req0);
only_req1: assert final(~req3 && ~req2 && req1 && ~req0);
only_req2: assert final(~req3 && req2 && ~req1 && ~req0);
only_req3: assert final(req3 && ~req2 && ~req1 && ~req0);

alloutputones: assert final (grant0 && grant1 && grant2 && grant3);
alloutputzeros: assert final (~grant0 && ~grant1 && ~grant2 && ~grant3);
out_0001: assert final (~grant0 && grant1 && ~grant2 && grant3);
out_0011: assert final (~grant0 && ~grant1 && grant2 && grant3);*/
endmodule