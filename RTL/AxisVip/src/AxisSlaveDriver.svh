class AxisSlaveDriver extends uvm_driver #(AxisSlaveItem);
    `uvm_component_utils(AxisSlaveDriver)

    typedef AxisSlaveItem Item;
    typedef virtual AxisIf#(DATA_WIDTH) Vif;

    local Vif vif;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction
    
    virtual function void build_phase(uvm_phase phase);
        ConfigDb#(Vif)::get(this, "", "vif", vif);
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
