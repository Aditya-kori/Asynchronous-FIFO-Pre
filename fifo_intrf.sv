interface fifo_intrf(input bit w_clk,r_clk,rst);
	bit wr_en,rd_en;
	bit [`WIDTH-1:0]wdata;
	bit full,overflow,empty,underflow;
	bit [`WIDTH-1:0]rdata;

clocking wr_drv_cb@(posedge w_clk);
	default input #0 output #1;
	input full,overflow;
	output wr_en,wdata;
endclocking

clocking rd_drv_cb@(posedge r_clk);
	default input #1 output #1;
	input empty,underflow,rdata;
	output rd_en;
endclocking

clocking wr_mon_cb@(posedge w_clk);
	default input #1;
	input wr_en,wdata,full,overflow;
endclocking

clocking rd_mon_cb@(posedge r_clk);
	default input #1;
	input rd_en,rdata,empty,underflow;
endclocking
endinterface
