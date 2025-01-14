class ControlStatusMap #(
    parameter WIDTH = 40
) extends AnalysisMap#(AxisTransaction#(WIDTH), ControlStatusTransaction #(WIDTH));
    `uvm_component_param_utils(ControlStatusMap#(WIDTH))

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void write(FROM_T from);
        TO_T to = TO_T::type_id::create("to", this);
        to.max_schedule = from.tdata[39:38];
        to.mb = from.tdata[37:32];
        to.id = from.tdata[31:24];
        to.max_iterations = from.tdata[23:18];
        to.term_on_no_change = from.tdata[17];
        to.term_on_pass = from.tdata[16];
        to.include_parity_op = from.tdata[15];
        to.hard_op = from.tdata[14];
        to.op = from.tdata[13];
        to.ms_offset = from.tdata[12:9];
        to.bg = from.tdata[8:6];
        to.z_set = from.tdata[5:3];
        to.z_j = from.tdata[2:0];
        port.write(to);
    endfunction
endclass
