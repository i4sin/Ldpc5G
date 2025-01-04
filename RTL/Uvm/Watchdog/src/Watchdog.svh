class Watchdog extends uvm_component;
    `uvm_component_utils(Watchdog)

    typedef virtual ClockIf ClockVif;

    ClockVif clock_vif;

    local int elapsed_clocks = 0;
    local longint watchdog_clocks;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        ConfigDb#(ClockVif)::get(this, "", "clock_vif", clock_vif);
        ConfigDb#(longint)::get(this, "", "watchdog_clocks", watchdog_clocks);
    endfunction

    virtual task run_phase(uvm_phase phase);
        forever begin
            @(posedge clock_vif.clk);
            elapsed_clocks++;
            if (elapsed_clocks >= watchdog_clocks)
                `uvm_fatal("WATCHDOG", "UVM Test Timed Out!")
        end
    endtask
endclass
