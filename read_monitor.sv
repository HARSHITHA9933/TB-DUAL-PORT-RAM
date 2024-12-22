class rd_monitor;
   transaction rddata;
   virtual intf.RD_MON_MP rd_mon_inf;
   mailbox #(transaction) rdm2ref;
   mailbox #(transaction) rdm2sc;

   function new(virtual intf.RD_MON_MP rd_mon_inf, mailbox #(transaction) rdm2ref, mailbox #(transaction) rdm2sc);
      this.rd_mon_inf = rd_mon_inf;
      this.rdm2ref = rdm2ref;
      this.rdm2sc = rdm2sc;
   endfunction

   virtual task rd_mon();
      forever begin
         @(posedge rd_mon_inf.clk);
         rddata = new();
         rddata.rd_en   = rd_mon_inf.rd_en;
         rddata.rd_addr = rd_mon_inf.rd_addr;
         rddata.data_out = rd_mon_inf.data_out;
         rddata.display("RDMON");
         rdm2ref.put(rddata);
         rdm2sc.put(rddata);
      end
   endtask
endclass
