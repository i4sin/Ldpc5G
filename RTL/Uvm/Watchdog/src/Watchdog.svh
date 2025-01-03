class Watchdog extends uvm_component;
    `uvm_component_utils(Watchdog)

    typedef virtual ClockIf Vif;

    Vif vif;

    local int elapsed_clocks = 0;
    local long int watchdog_clocks;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        ConfigDb#(Vif)::get(this, "", "vif", vif);
        ConfigDb#(long int)::get(this, "", "watchdog_clocks", watchdog_clocks);
    endfunction

    virtual task run_phase(uvm_phase phase);
        forever begin
            @(posedge vif.clk);
            elapsed_clocks++;
            if (elapsed_clocks == watchdog_clocks)
                `uvm_fatal("WATCHDOG", "UVM Test Timed Out!")
        end
    endtask
endclass
