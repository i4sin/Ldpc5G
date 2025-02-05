package AXIS_VIP;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    
    import CONFIG_DB::*;
    import DRIVER::*;
    import MONITOR::*;
    import RANGE::*;
    import SEQUENCE::*;

    `include "AxisMasterItem.svh"
    `include "AxisMasterPacket.svh"
    `include "AxisSlaveItem.svh"
    `include "AxisTransaction.svh"
    
    `include "AxisMonitor.svh"
    `include "AxisMasterDriver.svh"
    `include "AxisMasterSeqr.svh"
    `include "AxisMasterAgent.svh"
    `include "AxisSlaveDriver.svh"
    `include "AxisSlaveSeqr.svh"
    `include "AxisSlaveAgent.svh"
endpackage
