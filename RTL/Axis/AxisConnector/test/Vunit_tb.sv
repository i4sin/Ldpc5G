`timescale 1ns/1ps
`define PERIOD 20ns/1ps

module AxisConnector_tb();
    parameter string runner_cfg = "";
    AxisConnectorTest #(
        .DATA_WIDTH(64),
        .runner_config(runner_cfg)
    ) test();
endmodule

module AxisConnectorTest();
    parameter DATA_WIDTH = 0;
    
    import vunit_pkg::*;
    import uvm_pkg::*;
    `include "vunit_defines.svh"

    import CONFIG_DB::*;
    import TEST_CASES::*;

    typedef uvm_component_registry#(Test#(DATA_WIDTH), $sformatf("Test#(%0d)",DATA_WIDTH)) TestCase;

    const int PACKETS_COUNT = 512;
    const longint WATCHDOG_CLOCKS = 5000000;

    ClockIf clock_if ();
    initial clock_if.clk = 0;
    always #(`PERIOD / 2) clock_if.clk = ~clock_if.clk;
    
    ResetIf reset_if (clock_if.clk);

    AxisIf #(
        .DATA_WIDTH(DATA_WIDTH)
    ) s_axis (
        .aclk(clock_if.clk),
        .aresetn(reset_if.resetn)
    );
    AxisIf #(
        .DATA_WIDTH(DATA_WIDTH)
    ) m_axis (
        .aclk(clock_if.clk),
        .aresetn(reset_if.resetn)
    );
    AxisConnector dut (
        .s_axis(s_axis),
        .m_axis(m_axis)
    );

    `TEST_SUITE_FROM_PARAMETER(runner_config) begin
        `TEST_CASE_SETUP begin
            uvm_top.finish_on_completion = 0;
            ConfigDb#(longint)::set(null, "uvm_test_top.watchdog", "watchdog_clocks", WATCHDOG_CLOCKS);
            ConfigDb#(virtual ClockIf)::set(null, "uvm_test_top.watchdog", "clock_vif", clock_if);
            ConfigDb#(virtual ResetIf)::set(null, "uvm_test_top.env", "reset_vif", reset_if);
            ConfigDb#(virtual AxisIf#(DATA_WIDTH))::set(null, "uvm_test_top.env", "s_axis_vif", s_axis);
            ConfigDb#(virtual AxisIf#(DATA_WIDTH))::set(null, "uvm_test_top.env", "m_axis_vif", m_axis);
        end
        `TEST_CASE("random_test") begin
            run_test($sformatf("Test#(%0d)", DATA_WIDTH));
        end
    end
endmodule
