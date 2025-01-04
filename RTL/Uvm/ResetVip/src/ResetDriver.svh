class ResetDriver extends uvm_driver #(ResetItem);
    `uvm_component_utils(ResetDriver)

    typedef ResetItem Item;
    typedef virtual ResetIf Vif;

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
            drive(item.length);
            seq_item_port.item_done();
        end
    endtask

    local task drive(int length);
        vif.aresetn <= 0;
        repeat (length) @(posedge vif.aclk);
        vif.aresetn <= 1;
    endtask
endclass
