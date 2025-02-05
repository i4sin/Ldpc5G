virtual class Driver #(
    type Vif,
    type Item
) extends uvm_driver #(Item);
    `uvm_component_param_utils(Driver#(Vif, Item))

    protected Vif vif;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void set_vif(Vif vif);
        this.vif = vif;
    endfunction

    virtual function void post_connect_phase(uvm_phase phase);
        assert (vif != null);
    endfunction
endclass
