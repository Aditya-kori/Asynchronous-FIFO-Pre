class base_seq extends uvm_sequence#(fifo_tx);
	`uvm_object_utils(base_seq)
	`NEW_OBJ
	uvm_phase phase;

	task pre_body();
		if(phase!=null) begin
			phase = get_starting_phase();
			phase.raise_objection(this);
		end
	endtask

	task post_body();
		if(phase!=null) begin
			phase.phase_done.set_drain_time(this,100);
			phase.drop_objection(this);
		end
	endtask
endclass

class wr_seq extends base_seq;
rand int wr_count = `DEPTH;
	`uvm_object_utils(wr_seq)
	`NEW_OBJ

	task body();
		repeat(wr_count) begin
			`uvm_do_with(req, {req.wr_en==1;})
		end
	endtask
endclass

class rd_seq extends base_seq;
rand int rd_count = `DEPTH;
	`uvm_object_utils(rd_seq)
	`NEW_OBJ
	
	task body();
		repeat(rd_count) begin
			`uvm_do_with(req, {req.rd_en==1;})
		end
	endtask
endclass

