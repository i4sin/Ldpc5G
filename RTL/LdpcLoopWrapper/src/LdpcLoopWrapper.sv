module LdpcLoopWrapper (
    AxisIf.slave s_axis_encoder_control,
    AxisIf.slave s_axis_decoder_control,
    AxisIf.slave s_axis_din,
    AxisIf.master m_axis_encoder_status,
    AxisIf.master m_axis_decoder_status,
    AxisIf.master m_axis_dout
);
    if (s_axis_encoder_control.DATA_WIDTH != m_axis_encoder_status.DATA_WIDTH) $error("error");
    if (s_axis_decoder_control.DATA_WIDTH != m_axis_decoder_status.DATA_WIDTH) $error("error");
    if (s_axis_encoder_control.DATA_WIDTH != m_axis_decoder_status.DATA_WIDTH) $error("error");
    if (s_axis_din.DATA_WIDTH != m_axis_dout.DATA_WIDTH) $error("error");

    localparam DATA_WIDTH = s_axis_din.DATA_WIDTH;

    bit clk;
    bit resetn;

    assign clk = s_axis_din.aclk;
    assign resetn = s_axis_din.aresetn;

    AxisIf #(
        .DATA_WIDTH(DATA_WIDTH)
    ) m_axis_encoder_dout (
        .aclk(clk),
        .aresetn(resetn)
    );
    AxisIf #(
        .DATA_WIDTH(DATA_WIDTH)
    ) s_axis_decoder_din (
        .aclk(clk),
        .aresetn(resetn)
    );
    AxisConnector data_connector (
        .s_axis(m_axis_encoder_dout),
        .m_axis(s_axis_decoder_din)
    );

    DummyEncoder encoder (
        .s_axis_control(s_axis_encoder_control),
        .s_axis_din(s_axis_din),
        .m_axis_status(m_axis_encoder_status),
        .m_axis_dout(m_axis_encoder_dout)
    );
    DummyDecoder decoder (
        .s_axis_control(s_axis_decoder_control),
        .s_axis_din(s_axis_decoder_din),
        .m_axis_status(m_axis_decoder_status),
        .m_axis_dout(m_axis_dout)
    );
endmodule
