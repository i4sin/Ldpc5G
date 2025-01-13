class ControlCfg extends uvm_component;
    `uvm_component_utils(ControlCfg)

    rand logic [1:0] max_schedule;
    rand logic [5:0] mb;
    rand logic [5:0] max_iterations;
    rand logic term_on_no_change;
    rand logic term_on_pass;
    rand logic include_parity_op;
    rand logic hard_op;
    rand logic [3:0] ms_offset;
    rand logic [2:0] bg;
    rand logic [2:0] z_set;
    rand logic [2:0] z_j;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void do_print(uvm_printer printer);
        super.do_print(printer);
        printer.print_field("max_schedule", max_schedule, $bits(max_schedule), UVM_HEX);
        printer.print_field("mb", mb, $bits(mb), UVM_HEX);
        printer.print_field("max_iterations", max_iterations, $bits(max_iterations), UVM_HEX);
        printer.print_field("term_on_no_change", term_on_no_change, $bits(term_on_no_change), UVM_HEX);
        printer.print_field("term_on_pass", term_on_pass, $bits(term_on_pass), UVM_HEX);
        printer.print_field("include_parity_op", include_parity_op, $bits(include_parity_op), UVM_HEX);
        printer.print_field("hard_op", hard_op, $bits(hard_op), UVM_HEX);
        printer.print_field("ms_offset", ms_offset, $bits(ms_offset), UVM_HEX);
        printer.print_field("bg", bg, $bits(bg), UVM_HEX);
        printer.print_field("z_set", z_set, $bits(z_set), UVM_HEX);
        printer.print_field("z_j", z_j, $bits(z_j), UVM_HEX);
    endfunction
endclass
