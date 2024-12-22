class wr_driver;
   virtual intf.WR_DRV_MP wr_drv_inf;
   transaction data2drv;
   mailbox #(transaction) gen2wr;

   function new(virtual intf.WR_DRV_MP wr_drv_inf, mailbox #(transaction) gen2wr);
      this.wr_drv_inf = wr_drv_inf;
      this.gen2wr = gen2wr;
   endfunction

   virtual task drive();
      forever begin
         gen2wr.get(data2drv);
         @(posedge wr_drv_inf.clk);
         wr_drv_inf.wr_en   <= data2drv.wr_en;
         wr_drv_inf.wr_addr <= data2drv.wr_addr;
         wr_drv_inf.data_in <= data2drv.data_in;
         data2drv.display("WRDRV");
      end
   endtask
endclass
