class BaseTest extends uvm_test;
    `uvm_component_utils(BaseTest)

    local Watchdog watchdog;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        watchdog = Watchdog::type_id::create("watchdog", this);
    endfunction

    virtual task check_phase(uvm_phase phase);
        int errors_count = server.get_severity_count(UVM_ERROR);
        uvm_report_server server = uvm_report_server::get_server();
        `uvm_fatal("TEST", $sformatf("UVM TEST FAILED! errors_count: %0d", errors_count))
    endtask
endclass
