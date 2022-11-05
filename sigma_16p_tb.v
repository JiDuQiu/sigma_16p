//----testbench of sigma_16p-----

`timescale 1ns/10ps
module sigma_16p_tb;
reg		clk,res;
reg[7:0]	data_in;
reg		syn_in;
wire[11:0]	data_out;
wire		syn_out;

sigma_16p sigma_16p(
		.clk(clk),
		.res(res),
		.data_in(data_in),
		.syn_in(syn_in),
		.data_out(data_out),
		.syn_out(syn_out)
		);
initial begin
	clk<=0;res<=0;data_in<=8'b0000_0010;;syn_in<=0;//data_in<=8'b1000_0001表示负1；
	#17 res<=1;
	#25000 $stop;
end

always #5 clk=~clk;

always #100 syn_in=~syn_in;

initial begin
	$dumpfile("test11-2.vcd");
	$dumpvars(0,sigma_16p_tb);
end


endmodule
