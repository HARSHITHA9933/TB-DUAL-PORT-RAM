class transaction;
   rand bit [7:0] data_in;
   rand bit [7:0] rd_addr;
   rand bit [7:0] wr_addr;

   rand bit wr_en;
   rand bit rd_en;
   bit [7:0] data_out;

   constraint c1 { wr_addr != rd_addr; }
   constraint c2 { {rd_en, wr_en} != 2'b00; }
   constraint c3 { data_in inside { [1:127] }; }

   function void display(string label);
       $display("Time=%0t [%0s] wr_en=%0b, rd_en=%0b, wr_addr=%0h, rd_addr=%0h, data_in=%0h, data_out=%0h",
                $time, label, wr_en, rd_en, wr_addr, rd_addr, data_in, data_out);
   endfunction
endclass
