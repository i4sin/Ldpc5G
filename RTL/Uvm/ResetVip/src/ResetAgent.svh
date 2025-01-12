class ResetAgent extends uvm_agent;
    `uvm_component_utils(ResetAgent)

    typedef virtual ResetIf Vif;
    typedef ResetDriver Driver;
    typedef ResetSeqr Seqr;

    local Driver driver;
    local Seqr seqr;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction
    
    virtual function void build_phase(uvm_phase phase);
        driver = Driver::type_id::create("driver", this);
        seqr = Seqr::type_id::create("seqr", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        driver.seq_item_port.connect(seqr.seq_item_export);
    endfunction

    function void set_vif(Vif vif);
        driver.set_vif(vif);
    endfunction

    function Seqr get_seqr();
        return seqr;
    endfunction
endclass
