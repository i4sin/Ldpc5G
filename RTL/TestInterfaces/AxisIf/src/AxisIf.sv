interface AxisIf #(
    parameter DATA_WIDTH
) (
    input aclk,
    input aresetn
);
    logic tvalid;
    logic tready;
    logic [DATA_WIDTH-1] tdata;
    logic [DATA_WIDTH/8-1] tkeep;
    logic tlast;

    modport master(input aclk, aresetn, output tvalid, tdata, tkeep, tlast, input tready);
    modport slave(input aclk, aresetn, input tvalid, tdata, tkeep, tlast, output tready);
endinterface
