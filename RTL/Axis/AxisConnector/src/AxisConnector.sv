module AxisConnector (
    AxisIf.slave s_axis,
    AxisIf.master m_axis
);
    assign m_axis.tvalid = s_axis.tvalid;
    assign s_axis.tready = m_axis.tready;
    assign m_axis.tdata = s_axis.tdata;
    assign m_axis.tkeep = s_axis.tkeep;
    assign m_axis.tlast = s_axis.tlast;
endmodule
