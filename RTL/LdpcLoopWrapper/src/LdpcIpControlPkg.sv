package LDPC_IP_CONTROL_PKG;
    logic [2:0] MAX_SCHEDULE = 0;      // DeControl, EnControl          
    logic [5:0] MB = 8;                // DeControl, EnControl, DeStatus, EnStatus
    logic [7:0] ID;                    // DeControl, EnControl, DeStatus, EnStatus
    logic [5:0] MAX_ITERATIONS = 32;   // DeControl           , DeStatus
    logic TERM_ON_NO_CHANGE = 0;       // DeControl           , DeStatus
    logic TERM_ON_PASS = 0;            // DeControl           , DeStatus
    logic INCLUDE_PARITY_OP = 1;       // DeControl           , DeStatus
    logic HARD_OP = 0;                 // DeControl           , DeStatus, EnStatus
    logic OP;                          //                     , DeStatus, EnStatus
    logic [3:0] MS_OFFSET = 0;         // DeControl                     
    logic [2:0] BG = 0;                // DeControl, EnControl, DeStatus, EnStatus
    logic [2:0] Z_SET = 0;             // DeControl, EnControl, DeStatus, EnStatus
    logic [2:0] Z_J = 0;               // DeControl, EnControl, DeStatus, EnStatus
endpackage
