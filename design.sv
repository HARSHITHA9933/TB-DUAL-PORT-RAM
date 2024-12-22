module design(clk,rst,wr_en, rd_en,wr_addr,rd_addr, data_in, data_out);
  parameter RAM_WIDTH=8;
  parameter RAM_DEPTH=256;
  parameter ADDR_SIZE=8;
  input clk,rst,wr_en, rd_en;
  input [7:0] wr_addr,rd_addr;
  input [7:0]data_in;
  output reg [7:0] data_out;
  reg [RAM_WIDTH-1:0] mem [RAM_DEPTH-1:0];
  integer i;
  always @(posedge clk) begin
    if(rst) begin
      for(i=0;i<RAM_DEPTH;i=i+1)
        mem[i]<=0;
      data_out<=0;
    end
    else begin
      if(wr_en)
        mem [wr_addr]<=data_in;
      if(rd_en)
        data_out<=mem[rd_addr];
    end
  end
endmodule
