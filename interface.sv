interface intf();
    logic clk, rst;                 // Clock and reset signals
    logic wr_en, rd_en;             // Write and read enable signals
    logic [7:0] data_in, data_out;  // Data input and output signals
    logic [7:0] wr_addr, rd_addr;   // Write and read addresses

    // Define modports
    modport WR_DRV_MP (
        output wr_en, wr_addr, data_in, clk, rst
    ); 

    modport WR_MON_MP (
        input wr_en, wr_addr, data_in, clk, rst
    );

    modport RD_DRV_MP (
        output rd_en, rd_addr, clk, rst
    ); 

    modport RD_MON_MP (
        input rd_en, rd_addr, data_out, clk, rst
    ); 
endinterface
