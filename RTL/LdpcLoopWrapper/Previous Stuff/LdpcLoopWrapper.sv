`timescale 1ns/1ps
`define PERIOD 20ns/1ps

module LdpcLoopWrapper #(
    parameter DATA_WIDTH = 128,
    parameter CTRL_WIDTH = 40
) (
    input clk,
    input resetn,

    // Decoder Dout
    input [DATA_WIDTH-1:0] m_axis_dout_tdata,
    input m_axis_dout_tlast,
    output m_axis_dout_tready,
    input m_axis_dout_tvalid,

    // Decoder Status
    input [CTRL_WIDTH-1:0] decoder_status_tdata,
    output decoder_status_tready,
    input decoder_status_tvalid,

    // Encoder Din
    output [DATA_WIDTH-1:0] s_axis_din_tdata,
    output s_axis_din_tlast,
    input s_axis_din_tready,
    output s_axis_din_tvalid,

    // Encoder Status
    input [CTRL_WIDTH-1:0] encoder_status_tdata,
    output encoder_status_tready,
    input encoder_status_tvalid,

    // Encoder Ctrl
    output [CTRL_WIDTH-1:0] s_axis_ctrl_tdata,
    input s_axis_ctrl_tready,
    output s_axis_ctrl_tvalid
);
    typedef logic[DATA_WIDTH-1:0] TdataLogic;
    typedef logic[CTRL_WIDTH-1:0] StatusLogic;
    typedef TdataLogic TdataPacket[$];
    typedef TdataPacket TdataPacketQueue[$];
    typedef StatusLogic StatusQueue[$];

    function StatusLogic generate_encoder_ctrl();
        logic[2:0] z_j;
        logic[2:0] z_set;
        logic[2:0] bg;
        logic[3:0] ms_offset;
        logic hard_op;
        logic include_parity_op;
        logic term_on_pass;
        logic term_on_no_change;
        logic[5:0] max_iterations;
        logic[7:0] id;
        logic[5:0] mb;
        logic[2:0] max_schedule;
    endfunction

    function automatic CtrlLogic generate_encoder_ctrl();
        logic[2:0] max_schedule;
        logic[5:0] mb;
        logic[7:0] id;
        logic[14:0] reserved;
        logic[2:0] bg;
        logic[2:0] z_set;
        logic[2:0] z_j;
        // CtrlLogic ctrl_logic = {max_schedule, mb, id, reserved, bg, z_set, z_j};
        CtrlLogic ctrl_logic = 0;
        return ctrl_logic;
    endfunction

    function automatic CtrlLogic generate_encoder_ctrl();
        logic[2:0] max_schedule;
        logic[5:0] mb;
        logic[7:0] id;
        logic[5:0] max_iterations;
        logic term_on_no_change;
        logic term_on_pass;
        logic include_parity_op;
        logic hard_op;
        logic reserved;
        logic[3:0] ms_offset;
        logic[2:0] bg;
        logic[2:0] z_set;
        logic[2:0] z_j;
        // CtrlLogic ctrl_logic = {max_schedule, mb, id, max_iterations, term_on_no_change, term_on_pass, include_parity_op, hard_op, reserved, ms_offset, bg, z_set, z_j};
        CtrlLogic ctrl_logic = 0;
        return ctrl_logic;
    endfunction
endmodule
