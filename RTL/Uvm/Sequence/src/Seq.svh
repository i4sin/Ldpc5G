virtual class Seq #(
    type REQ,
    type RSP = REQ
) extends uvm_sequence #(REQ, RSP);
    `uvm_object_param_utils(Seq#(REQ, RSP))

    function new(string name = "");
        super.new(name);
        assert (name != "");
    endfunction

    function void pre_randomize();
        configure();
    endfunction

    virtual function void configure();
    endfunction
endclass
