class generator;
   transaction gen_tr; 
   mailbox #(transaction) gen2wr; 
   mailbox #(transaction) gen2rd; 

   function new(mailbox #(transaction) gen2wr, mailbox #(transaction) gen2rd);
      this.gen2wr = gen2wr;
      this.gen2rd = gen2rd;
   endfunction

   virtual task start();
      repeat (5) begin
         // Generate write transaction
         gen_tr = new();
         if (gen_tr.randomize() with { wr_en == 1; rd_en == 0; }) begin
             gen2wr.put(gen_tr);
             gen_tr.display("GEN WR");
         end
         #10;

         // Generate read transaction
         gen_tr = new();
         if (gen_tr.randomize() with { wr_en == 0; rd_en == 1; }) begin
             gen2rd.put(gen_tr);
             gen_tr.display("GEN RD");
         end
         #10;
      end
   endtask
endclass
