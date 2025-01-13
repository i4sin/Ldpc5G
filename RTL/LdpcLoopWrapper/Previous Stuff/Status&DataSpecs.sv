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
