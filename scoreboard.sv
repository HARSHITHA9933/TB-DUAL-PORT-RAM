class scoreboard;
  transaction rm_data,rcvdata;
  mailbox #(transaction) ref2sc;
  mailbox #(transaction)rdm2sc;
  
  function new(mailbox #(transaction) ref2sc, mailbox #(transaction)rdm2sc);
    this.ref2sc=ref2sc;
    this.rdm2sc=rdm2sc;
  endfunction
  
  virtual task start();
    forever begin
      rm_data=new();
      rcvdata=new();
      ref2sc.get(rcvdata);
      rdm2sc.get(rm_data);
      check (rcvdata);
    end
  endtask
  
  virtual task check(transaction rc_data);
    if(rm_data.data_out==rc_data.data_out)
      $display("compared successfully");
    else
      $display("notcompared");
  endtask
endclass
