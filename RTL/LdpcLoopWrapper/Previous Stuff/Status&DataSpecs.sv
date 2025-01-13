encoder_status:
    logic[1:0] reserved_1;
    logic[5:0] mb;
    logic[7:0] id;
    logic[8:0] reserved_2;
    logic hard_op;
    logic op;
    logic[3:0] reserved_3;
    logic[2:0] bg;
    logic[2:0] z_set;
    logic[2:0] z_j;
    StatusLogic status_logic = 0;
    // status_logic = {reserved_1, mb, id, dec_iter, term_no_change, term_pass, pass, hard_op, op, reserved_2, bg, z_set, z_j};
    return status_logic;

decoder_status:
    logic[1:0] reserved_1;
    logic[5:0] mb;
    logic[7:0] id;
    logic[5:0] dec_iter;
    logic term_no_change;
    logic term_pass;
    logic pass;
    logic hard_op;
    logic op;
    logic[3:0] reserved_3;
    logic[2:0] bg;
    logic[2:0] z_set;
    logic[2:0] z_j;
    StatusLogic status_logic = 0;
    // status_logic = {reserved_1, mb, id, dec_iter, term_no_change, term_pass, pass, hard_op, op, reserved_2, bg, z_set, z_j};
    return status_logic;

encoder_ctrl:
    logic[2:0] max_schedule;
    logic[5:0] mb;
    logic[7:0] id;
    logic[14:0] reserved;
    logic[2:0] bg;
    logic[2:0] z_set;
    logic[2:0] z_j;
    CtrlLogic ctrl_logic = 0;
    // CtrlLogic ctrl_logic = {max_schedule, mb, id, reserved, bg, z_set, z_j};
    return ctrl_logic;

decoder_ctrl:
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
    CtrlLogic ctrl_logic = 0;
    // CtrlLogic ctrl_logic = {max_schedule, mb, id, max_iterations, term_on_no_change, term_on_pass, include_parity_op, hard_op, reserved, ms_offset, bg, z_set, z_j};
    return ctrl_logic;
