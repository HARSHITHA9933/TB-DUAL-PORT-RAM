class wr_monitor;
   transaction wrdata;
   virtual intf.WR_MON_MP wr_mon_inf;
   mailbox #(transaction) wrm2ref;

   function new(virtual intf.WR_MON_MP wr_mon_inf, mailbox #(transaction) wrm2ref);
      this.wr_mon_inf = wr_mon_inf;
      this.wrm2ref = wrm2ref;
   endfunction

   virtual task wr_mon();
      forever begin
         @(posedge wr_mon_inf.clk);
        // wrdata = new();
           if (wr_mon_inf.wr_en) begin
            wrdata = new();
         wrdata.wr_en = wr_mon_inf.wr_en;
         wrdata.wr_addr = wr_mon_inf.wr_addr;
         wrdata.data_in = wr_mon_inf.data_in;
         wrdata.display("WRMON");
         wrm2ref.put(wrdata);
       $display("Time=%0t [WRMON] wr_en=1, wr_addr=%0h, data_in=%0h",$time, wr_mon_inf.wr_addr, wr_mon_inf.data_in);
         end

      end
   endtask
endclass
