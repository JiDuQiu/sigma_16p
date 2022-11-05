//2022-7-31.罗力中；
//相邻16点相加；目的是用累加器实现乘法运算。比如16程以某个数。

module sigma_16p(
		clk,
		res,
		data_in,
		syn_in,
		data_out,
		syn_out
		);
input		clk;
input		res;
input[7:0]		data_in;//采样数据
input			syn_in;//采样时钟；
output[11:0]		data_out;//累加和；
output			syn_out;//累加和同步脉冲；

reg		syn_in_n1;//syn_in的反向延时；
wire		syn_pulse;//采样时钟上升沿识别脉冲；
assign		syn_pulse=syn_in&syn_in_n1;

reg[3:0]	con_syn;//脉冲尖循环计数；
wire[7:0]	comp_8;//补码；
wire[6:0]	comp_7;//反码+1；
wire[11:0]	d_12;//升码；

/*assign comp_8=data_in[7]?{data_in[7],~data_in[6:0]+1}:data_in;//求补码；*/
assign comp_7=~data_in[6:0]+1;//反码+1;
assign comp_8=data_in[7]?{data_in[7],comp_7}:data_in;//间接求补码；
assign d_12={comp_8[7],comp_8[7],comp_8[7],comp_8[7],comp_8};

reg[11:0]	sigma;//累加计算；
reg[11:0]	data_out;//累加和；
reg		syn_out;//累加和同步脉冲；

always@(posedge clk or negedge res) begin
if(~res) begin
	syn_in_n1<=0;con_syn<=0;sigma<=0;data_out<=0;syn_out<=0;
end
else begin
	syn_in_n1<=~syn_in;
	
	if(syn_pulse==1) begin
	con_syn<=con_syn+1;
	end

	if(syn_pulse==1)begin
		if(con_syn==15) begin
		sigma<=d_12;
		data_out<=sigma;
		syn_out<=1;
		end
		else begin
		sigma<=sigma+d_12;
		end
	end
	else begin
	syn_out<=0;
	end
   end
end



endmodule
