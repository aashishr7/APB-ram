module apb_single_port_ram #(
    parameter ADDR_WIDTH = 8,    // 256 locations
    parameter DATA_WIDTH = 32
)(
    input  logic                   PCLK,
    input  logic                   PRESETn,

    // APB interface
    input  logic                   PSEL,
    input  logic                   PENABLE,
    input  logic                   PWRITE,
    input  logic [ADDR_WIDTH-1:0]  PADDR,
    input  logic [DATA_WIDTH-1:0]  PWDATA,

    output logic [DATA_WIDTH-1:0]  PRDATA,
    output logic                   PREADY,
    output logic                   PSLVERR
);

    // Internal memory (Single-Port RAM)
    logic [DATA_WIDTH-1:0] mem [0:(1 << ADDR_WIDTH)-1];

    // Track valid access
    logic access_valid;

    // Always ready (no wait state)
    assign PREADY  = 1'b1;
    assign PSLVERR = 1'b0;

    // Capture valid transaction
    always @(posedge PCLK or negedge PRESETn) begin
        if (!PRESETn)
            access_valid <= 1'b0;
        else
            access_valid <= PSEL && PENABLE;
    end

    // Handle write transaction
    always @(posedge PCLK) begin
        if (access_valid && PWRITE) begin
            mem[PADDR] <= PWDATA;
          //$display("\nRTL: PADDR = %0d PWDATA = %0d\n",PADDR, PWDATA);
        end
    end

    // Handle read transaction
    always @(posedge PCLK) begin
        if (access_valid && !PWRITE) begin
            PRDATA = mem[PADDR];
         // $display("\nRTL: access_valid = %0d, PWRITE= %0d \n",access_valid, PWRITE);
         ////// $display("\nRTL: mem[%0d] = %0d, PRDATA= %0d \n",PADDR, mem[PADDR], PRDATA);
        end
    end

endmodule

