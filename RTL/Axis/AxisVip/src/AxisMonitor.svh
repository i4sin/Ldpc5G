class AxisMonitor #(
    parameter DATA_WIDTH
) extends Monitor#(virtual AxisIf#(DATA_WIDTH), AxisTransaction#(DATA_WIDTH));
    `uvm_component_param_utils(AxisMonitor#(DATA_WIDTH))

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual task run_phase(uvm_phase phase);
        forever begin
            @(posedge vif.aclk);
            if (vif.transfer()) capture_transaction();
        end
    endtask

    virtual function void capture_transaction();
        Transaction transaction = Transaction::type_id::create("transaction", this);
        transaction.tdata = vif.tdata;
        transaction.tkeep = vif.tkeep;
        transaction.tlast = vif.tlast;
        port.write(transaction);
    endfunction
endclass
