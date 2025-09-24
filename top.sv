`include "uvm_pkg.sv"
import uvm_pkg::*;

`include "fifo_common.sv"
`include "async_fifo.sv"
`include "fifo_tx.sv"
`include "seq_lib.sv"
`include "wr_sqr.sv"
`include "wr_drv.sv"
`include "wr_agent.sv"
`include "rd_sqr.sv"
`include "rd_drv.sv"
`include "rd_agent.sv"
`include "fifo_sbd.sv"
`include "fifo_mon.sv"
`include "fifo_cov.sv"
`include "fifo_env.sv"
`include "test_lib.sv"
`include "fifo_intrf.sv"

module top;
	bit w_clk,r_clk,rst;
	fifo_intrf pif(w_clk,r_clk,rst);

asyn_fifo dut(	.w_clk(pif.w_clk),
				.r_clk(pif.r_clk),
				.rst(pif.rst),
				.wr_en(pif.wr_en),
				.wdata(pif.wdata),
				.rd_en(pif.rd_en),
				.rdata(pif.rdata),
				.full(pif.full),
				.overflow(pif.overflow),
				.empty(pif.empty),
				.underflow(pif.underflow));
	always #7 w_clk = ~w_clk;
	always #5 r_clk = ~r_clk;

	initial begin
		uvm_config_db#(virtual fifo_intrf)::set(null,"*","VIF",pif);
	end
	initial begin
		rst = 1;
		w_clk = 0;
		r_clk = 0;
		repeat(2)@(posedge w_clk);
		rst = 0;
	end
	initial begin
		run_test("wr_rd_test");
	end
	initial begin
		$dumpfile("1.vcd");
		$dumpvars;
	end
endmodule
