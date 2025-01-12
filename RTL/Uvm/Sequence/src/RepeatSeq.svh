virtual class RepeatSeq #(
    type T,
    parameter string ITEM_NAME
) extends Seq #(T);
    `uvm_object_param_utils(RepeatSeq#(T, ITEM_NAME))

    function new(string name = "");
        super.new(name);
        assert (name != "");
    endfunction

    virtual protected task send_random_t();
        if (is_t_item()) send_random_item();
        else if (is_t_seq()) send_random_seq();
        else `uvm_fatal("RPT SEQ", $sformatf("The given type named %s, is not item, nor seq!", T::type_id::create("t").get_type_name()))
    endtask

    local function bit is_t_item();
        Item item;
        T t = new("t");
        return $cast(item,t);
    endfunction

    local function bit is_t_seq();
        uvm_sequence_base seq;
        T t = new("t");
        return $cast(seq,t);
    endfunction

    local task send_random_item();
        T item = T::type_id::create(ITEM_NAME, m_sequencer);
        start_item(item);
        assert (item.randomize());
        finish_item(item);
    endtask

    local task send_random_seq();
        T seq = T::type_id::create(ITEM_NAME, m_sequencer);
        seq.set_sequencer(m_sequencer);
        assert (seq.randomize());
        seq.start(m_sequencer, this);
    endtask
endclass
