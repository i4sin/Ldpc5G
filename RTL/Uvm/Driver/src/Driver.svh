virtual class Driver #(
    type Vif,
    type Item
) extends uvm_driver #(Item);
    `uvm_component_param_utils(Driver#(Vif, Item))

    protected Vif vif;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        ConfigDb#(Vif)::get(this, "", "vif", vif);
    endfunction

    virtual function void post_connect_phase(uvm_phase phase);
        assert (vif != null);
    endfunction
endclass
