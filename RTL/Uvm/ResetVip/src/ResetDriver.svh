class ResetDriver extends Driver #(virtual ResetIf, ResetItem);
    `uvm_component_utils(ResetDriver)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual task run_phase(uvm_phase phase);
        forever begin
            Item item;
            seq_item_port.get_next_item(item);
            drive(item.length);
            seq_item_port.item_done();
        end
    endtask

    local task drive(int length);
        vif.resetn <= 0;
        repeat (length) @(posedge vif.clk);
        vif.resetn <= 1;
    endtask
endclass
