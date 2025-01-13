package LDPC_LOOP_WRAPPER_TEST;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    
    import AXIS_VIP::*;
    import CONFIG_DB::*;
    import RESET_VIP::*;

    `include "Components/ControlCfg.svh"

    `include "Objects/DecoderControlItem.svh"
    `include "Objects/EncoderControlItem.svh"

    `include "Scoreboard.svh"
    `include "Env.svh"
endpackage
