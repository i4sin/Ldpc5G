module LdpcLoopWrapper (
    AxisIf.slave s_axis_ctrl,
    AxisIf.slave s_axis_din,
    AxisIf.master m_axis_status,
    AxisIf.master m_axis_dout
);
    if (s_axis_ctrl.DATA_WIDTH != m_axis_status.DATA_WIDTH) $error("error");
    if (s_axis_din.DATA_WIDTH != m_axis_dout.DATA_WIDTH) $error("error");

    AxisConnector ctrl_connector (
        .s_axis(s_axis_ctrl),
        .m_axis(m_axis_status)
    );
    AxisConnector data_connector (
        .s_axis(s_axis_din),
        .m_axis(m_axis_dout)
    );
endmodule
