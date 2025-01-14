module LdpcLoopWrapper (
    AxisIf.slave s_axis_encoder_control,
    AxisIf.slave s_axis_din,
    AxisIf.master m_axis_decoder_status,
    AxisIf.master m_axis_dout
);
    if (s_axis_encoder_control.DATA_WIDTH != m_axis_decoder_status.DATA_WIDTH) $error("error");
    if (s_axis_din.DATA_WIDTH != m_axis_dout.DATA_WIDTH) $error("error");

    AxisConnector ctrl_connector (
        .s_axis(s_axis_encoder_control),
        .m_axis(m_axis_decoder_status)
    );
    AxisConnector data_connector (
        .s_axis(s_axis_din),
        .m_axis(m_axis_dout)
    );
endmodule
