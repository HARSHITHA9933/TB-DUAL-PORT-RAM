class rd_driver;
   virtual intf.RD_DRV_MP rd_drv_inf;
   transaction data2drv;
   mailbox #(transaction) gen2rd;

   function new(virtual intf.RD_DRV_MP rd_drv_inf, mailbox #(transaction) gen2rd);
      this.rd_drv_inf = rd_drv_inf;
      this.gen2rd = gen2rd;
   endfunction

   virtual task drive();
      forever begin
         gen2rd.get(data2drv);
         @(posedge rd_drv_inf.clk);
         rd_drv_inf.rd_en   <= data2drv.rd_en;
         rd_drv_inf.rd_addr <= data2drv.rd_addr;
         data2drv.display("RDRV");
      end
   endtask
endclass
