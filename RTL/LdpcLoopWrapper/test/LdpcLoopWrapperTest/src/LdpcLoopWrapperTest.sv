package LDPC_LOOP_WRAPPER_TEST;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    
    import ANALYSIS_MAP::*;
    import AXIS_VIP::*;
    import CONFIG_DB::*;
    import RESET_VIP::*;

    `include "Objects/ControlStatusTransaction.svh"

    `include "Components/ControlCfg.svh"
    `include "Components/ControlStatusMap.svh"

    `include "Objects/EncoderControlItem.svh"
    `include "Objects/DecoderControlItem.svh"

    `include "Scoreboard.svh"
    `include "Env.svh"
endpackage
