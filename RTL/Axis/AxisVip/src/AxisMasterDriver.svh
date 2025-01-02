class AxisMasterDriver #(
    parameter DATA_WIDTH
) extends uvm_driver #(AxisMasterItem#(DATA_WIDTH));
    `uvm_component_param_utils(AxisMasterDriver#(DATA_WIDTH))

    typedef AxisMasterItem#(DATA_WIDTH) Item;
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
            delay_transfer(item.delay);
            drive(item);
            seq_item_port.item_done();
        end
    endtask

    local task delay_transfer(int delay);
        repeat (delay) @(posedge vif.aclk);
    endtask

    local task drive(Item item);
        vif.tvalid <= 1;
        vif.tdata <= item.tdata;
        vif.tkeep <= item.tkeep;
        vif.tlast <= item.tlast;
        @(posedge vif.aclk);
        vif.tvalid <= 0;
    endtask
endclass
