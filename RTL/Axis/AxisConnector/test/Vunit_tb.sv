`timescale 1ns/1ps
`define PERIOD 20ns/1ps

module AxisConnector_tb (
    string runner_cfg = "";
    module AxisConnectorTest #(
        .DATA_WIDTH(64)
    ) test (
        .runner_config(runner_cfg),
        .s_axis(s_axis),
        .m_axis(m_axis)
    );
    endmodule
    );
endmodule

module AxisConnectorTest();
    parameter DATA_WIDTH = 0;
    
    import vunit_pkg::*;
    `include "vunit_defines.svh"
    import uvm_pkg::*;
    `include “uvm_macros.svh”

    const int PACKETS_COUNT = 512;
    const long int WATCHDOG_CLOCKS = 5000000;

    bit clk = 0;
    bit resetn = 0;
    initial forever #(`PERIOD / 2) clk = ~clk;
    
    AxisIf #(
        .DATA_WIDTH(DATA_WIDTH)
    ) s_axis (
        .aclk(clk),
        .aresetn(resetn)
    );
    AxisIf #(
        .DATA_WIDTH(DATA_WIDTH)
    ) m_axis (
        .aclk(clk),
        .aresetn(resetn)
    );
    AxisConnector (
        .s_axis(s_axis),
        .m_axis(m_axis)
    );

    `TEST_SUITE_FROM_PARAMETERS(runner_config) begin
        `TEST_CASE_SETUP begin
            ConfigDb#(int)::set(null, "uvm_test_top.master_seq", "packets_count", PACKETS_COUNT);
            ConfigDb#(long int)::set(null, "uvm_test_top.watchdog", "watchdog_clocks", WATCHDOG_CLOCKS);
            ConfigDb#(virtual AxisIf#(DATA_WIDTH))::set(null, "uvm_test_top.env", "m_axis", m_axis);
            ConfigDb#(virtual AxisIf#(DATA_WIDTH))::set(null, "uvm_test_top.env", "m_axis", m_axis);
        end
        `TEST_CASE("random_test") begin
            run_test("Test#(%0d)", DATA_WIDTH);
        end
    end
endmodule
