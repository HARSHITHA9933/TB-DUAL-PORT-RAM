class ref_model;
  transaction wrmon_data, rdmon_data;
  mailbox #(transaction) wrm2ref;
  mailbox #(transaction) rdm2ref;
  mailbox #(transaction) ref2scr;

  // Dual-port RAM memory
  bit [7:0] mem [255:0]; // Adjust size as per design

  function new(mailbox #(transaction) wrm2ref, mailbox #(transaction) rdm2ref, mailbox #(transaction) ref2scr);
    this.wrm2ref = wrm2ref;
    this.rdm2ref = rdm2ref;
    this.ref2scr = ref2scr;
  endfunction

  // Task to handle dual-port RAM logic
  virtual task ref_logic(transaction wrmon_data, transaction rdmon_data);
    // Handle write operation
    if (wrmon_data.wr_en) begin
      mem[wrmon_data.wr_addr] = wrmon_data.data_in;
      $display("Time=%0t [REF WR] Address=%0h Data=%0h", $time, wrmon_data.wr_addr, wrmon_data.data_in);
    end

    // Handle read operation
    if (rdmon_data.rd_en) begin
      rdmon_data.data_out = mem[rdmon_data.rd_addr];
      $display("Time=%0t [REF RD] Address=%0h Data=%0h", $time, rdmon_data.rd_addr, rdmon_data.data_out);
    end
  endtask

  // Task to coordinate and process read/write transactions
  virtual task start();
    forever begin
      wrmon_data = new();
      rdmon_data = new();
      
      // Get transactions from respective mailboxes
      wrm2ref.get(wrmon_data);
      rdm2ref.get(rdmon_data);

      // Perform dual-port RAM logic
      ref_logic(wrmon_data, rdmon_data);

      // Pass data to the scoreboard
      ref2scr.put(wrmon_data);
      ref2scr.put(rdmon_data);
    end
  endtask
endclass
