`include "design.sv"
`include "Interface.sv"
`include "Transaction.sv"
`include "generator.sv"
`include "Write_driver.sv"
`include "Write_monitor.sv"
`include "rd_driver.sv"
`include "Read_monitor.sv"
`include "Ref_model.sv"
`include "Scoreboard.sv"
`include "Env.sv"
`include "Test.sv"
module testbench;
   intf duv_if();
   test test_h;

   design dut (
      .clk(duv_if.clk),
      .rst(duv_if.rst),
      .wr_en(duv_if.wr_en),
      .rd_en(duv_if.rd_en),
      .wr_addr(duv_if.wr_addr),
      .rd_addr(duv_if.rd_addr),
      .data_in(duv_if.data_in),
      .data_out(duv_if.data_out)
   );
   initial begin
      duv_if.clk = 0;
      forever #5 duv_if.clk = ~duv_if.clk;
   end

   initial begin
     // test_h = new(duv_if.WR_DRV_MP, duv_if.WR_MON_MP, duv_if.RD_DRV_MP, duv_if.RD_MON_MP);
     test_h=new(duv_if,duv_if,duv_if,duv_if);
      test_h.build_run();
      #100
      $finish;
   end
endmodule

