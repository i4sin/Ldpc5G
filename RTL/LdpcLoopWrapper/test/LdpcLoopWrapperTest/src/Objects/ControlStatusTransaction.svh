class ControlStatusTransaction #(
    parameter WIDTH = 40
) extends uvm_transaction;
    `uvm_object_param_utils(ControlStatusTransaction#(WIDTH))

    typedef ControlStatusTransaction#(WIDTH) Transaction;

    logic [1:0] max_schedule;
    logic [5:0] mb;
    logic [7:0] id;
    logic [5:0] max_iterations;
    logic term_on_no_change;
    logic term_on_pass;
    logic include_parity_op;
    logic hard_op;
    logic op;
    logic [3:0] ms_offset;
    logic [2:0] bg;
    logic [2:0] z_set;
    logic [2:0] z_j;

    function new(string name = "");
        super.new(name);
        assert (name != "");
    endfunction

    function bit compare_control(Transaction transaction);
        bit result = (max_schedule == transaction.max_schedule);
        result = result && (mb == transaction.mb);
        result = result && (bg == transaction.bg);
        result = result && (z_set == transaction.z_set);
        result = result && (z_j == transaction.z_j);
        return result;
    endfunction

    function bit compare_status(Transaction transaction);
        bit result = (mb == transaction.mb);
        result = result && (hard_op == transaction.hard_op);
        result = result && (op == transaction.op);
        result = result && (bg == transaction.bg);
        result = result && (z_set == transaction.z_set);
        result = result && (z_j == transaction.z_j);
        return result;
    endfunction

    function bit check_encoder_io_matching(Transaction transaction);
        bit result = (mb == transaction.mb);
        result = result && (id == transaction.id);
        result = result && (bg == transaction.bg);
        result = result && (z_set == transaction.z_set);
        result = result && (z_j == transaction.z_j);
        return result;
    endfunction

    function bit check_decoder_io_matching(Transaction transaction);
        bit result = (mb == transaction.mb);
        result = result && (id == transaction.id);
        result = result && (term_on_no_change == transaction.term_on_no_change);
        result = result && (term_on_pass == transaction.term_on_pass);
        result = result && (include_parity_op == transaction.include_parity_op);
        result = result && (hard_op == transaction.hard_op);
        result = result && (bg == transaction.bg);
        result = result && (z_set == transaction.z_set);
        result = result && (z_j == transaction.z_j);
        return result;
    endfunction

    virtual function bit do_compare(uvm_object rhs, uvm_comparer comparer);
        bit result;
        Transaction transaction;
        if (!$cast(transaction, rhs))
            `uvm_error("CONTROL STATUS TRANSACTION", "The types are not matching to compare!")
        result = super.do_compare(rhs, comparer);
        result = result && (mb == transaction.mb);
        result = result && (bg == transaction.bg);
        result = result && (z_set == transaction.z_set);
        result = result && (z_j == transaction.z_j);
        return result;
    endfunction

    virtual function void do_print(uvm_printer printer);
        super.do_print(printer);
        printer.print_field("max_schedule", max_schedule, $bits(max_schedule), UVM_HEX);
        printer.print_field("mb", mb, $bits(mb), UVM_HEX);
        printer.print_field("id", id, $bits(id), UVM_HEX);
        printer.print_field("max_iterations", max_iterations, $bits(max_iterations), UVM_HEX);
        printer.print_field("term_on_no_change", term_on_no_change, $bits(term_on_no_change), UVM_HEX);
        printer.print_field("term_on_pass", term_on_pass, $bits(term_on_pass), UVM_HEX);
        printer.print_field("include_parity_op", include_parity_op, $bits(include_parity_op), UVM_HEX);
        printer.print_field("hard_op", hard_op, $bits(hard_op), UVM_HEX);
        printer.print_field("op", op, $bits(op), UVM_HEX);
        printer.print_field("ms_offset", ms_offset, $bits(ms_offset), UVM_HEX);
        printer.print_field("bg", bg, $bits(bg), UVM_HEX);
        printer.print_field("z_set", z_set, $bits(z_set), UVM_HEX);
        printer.print_field("z_j", z_j, $bits(z_j), UVM_HEX);
    endfunction
endclass
