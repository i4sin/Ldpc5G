class Range extends uvm_component;
    `uvm_component_utils(Range)

    local int min;
    local int max;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void set_min(int min);
        this.min = min;
    endfunction

    function void set_max(int max);
        this.max = max;
    endfunction

    function int get_min();
        return min;
    endfunction

    function int get_max();
        return max;
    endfunction

    static function Range build_range(string name, int min, int max);
        Range range = new(name, null);
        range.set_min(min);
        range.set_max(max);
        return range;
    endfunction

    virtual function void do_print(uvm_printer printer);
        super.do_print(printer);
        printer.print_field_int("min", min, $bits(min), UVM_DEC);
        printer.print_field_int("max", max, $bits(max), UVM_DEC);
    endfunction
endclass
