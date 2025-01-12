class AxisSlaveDriver #(
    parameter DATA_WIDTH
) extends Driver #(virtual AxisIf#(DATA_WIDTH), AxisSlaveItem);
    `uvm_component_param_utils(AxisSlaveDriver#(DATA_WIDTH))

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual task run_phase(uvm_phase phase);
        forever begin
            Item item;
            seq_item_port.get_next_item(item);
            wait_for_tvalild();
            delay_transfer(item.delay);
            drive();
            seq_item_port.item_done();
        end
    endtask

    local task wait_for_tvalild();
        while (!vif.tvalid) @(posedge vif.aclk);
    endtask

    local task delay_transfer(int delay);
        repeat (delay) @(posedge vif.aclk);
    endtask

    local task drive();
        vif.tready <= 1;
        @(posedge vif.aclk);
        vif.tready <= 0;
    endtask
endclass
