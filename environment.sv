class environment;
virtual intf.WR_DRV_MP wr_drv_inf;
virtual intf.WR_MON_MP wr_mon_inf;
virtual intf.RD_DRV_MP rd_drv_inf;
virtual intf.RD_MON_MP rd_mon_inf;
mailbox #(transaction)gen2wr=new();
mailbox #(transaction) wrm2ref=new();
mailbox #(transaction)gen2rd=new();
mailbox #(transaction)rdm2ref=new();
mailbox #(transaction) rdm2sc=new();
mailbox #(transaction) ref2sc=new();
generator gen;
wr_driver wr_drv;
wr_monitor wr_m;
rd_driver rd_drv;
rd_monitor rd_m;
ref_model ref_mode;
scoreboard score;
function new(virtual intf.WR_DRV_MP wr_drv_inf, virtual intf.WR_MON_MP wr_mon_inf,virtual intf.RD_DRV_MP rd_drv_inf, virtual intf.RD_MON_MP rd_mon_inf);
this.wr_drv_inf=wr_drv_inf;
this.wr_mon_inf=wr_mon_inf;
this.rd_drv_inf=rd_drv_inf;
this.rd_mon_inf=rd_mon_inf;
endfunction
virtual task build;
gen=new(gen2wr,gen2rd);
wr_drv=new(wr_drv_inf,gen2wr);
rd_drv=new(rd_drv_inf,gen2rd);
wr_m=new(wr_mon_inf,wrm2ref);
rd_m=new(rd_mon_inf,rdm2ref,rdm2sc);
  ref_mode=new(wrm2ref,rdm2ref,ref2sc);
score=new(ref2sc,rdm2sc);
endtask
  virtual task start(); 
fork
gen.start();
wr_drv.drive();
wr_m.wr_mon();
rd_m.rd_mon();
rd_drv.drive();
ref_mode.start();
score.start();
join_none
endtask
endclass
