class Scoreboard #(
    parameter CONTROL_WIDTH,
    parameter DATA_WIDTH
) extends uvm_scoreboard;
    `uvm_component_param_utils(Scoreboard#(CONTROL_WIDTH, DATA_WIDTH))

    typedef AxisTransaction#(CONTROL_WIDTH) ControlTransaction;
    typedef AxisTransaction#(DATA_WIDTH) DataTransaction;
    typedef uvm_tlm_analysis_fifo #(ControlTransaction) ControlAnalysisFifo;
    typedef uvm_tlm_analysis_fifo #(DataTransaction) DataAnalysisFifo;

    ControlAnalysisFifo input_control_fifo;
    ControlAnalysisFifo output_control_fifo;
    DataAnalysisFifo input_data_fifo;
    DataAnalysisFifo output_data_fifo;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        input_control_fifo = new("input_control_fifo", this);
        output_control_fifo = new("output_control_fifo", this);
        input_data_fifo = new("input_data_fifo", this);
        output_data_fifo = new("output_data_fifo", this);
    endfunction

    virtual task run_phase(uvm_phase phase);
        forever begin
            fork
                check_control();
                check_data();
            join
        end
    endtask

    virtual function void check_phase(uvm_phase phase);
        if (input_control_fifo.used() != 0)
            `uvm_error("SCOREBOARD", $sformatf(
                "input_control_fifo is not empty! remained transactions: %0d", input_control_fifo.used()))
        if (input_data_fifo.used() != 0)
            `uvm_error("SCOREBOARD", $sformatf(
                "input_data_fifo is not empty! remained transactions: %0d", input_data_fifo.used()))
        if (output_control_fifo.used() != 0)
            `uvm_error("SCOREBOARD", $sformatf(
                "output_control_fifo is not empty! remained transactions: %0d", output_control_fifo.used()))
        if (output_data_fifo.used() != 0)
            `uvm_error("SCOREBOARD", $sformatf(
                "output_data_fifo is not empty! remained transactions: %0d", output_data_fifo.used()))
    endfunction

    local task check_control();
        ControlTransaction input_control;
        ControlTransaction output_control;
        input_control_fifo.get(input_control);
        output_control_fifo.get(output_control);
        check_control_matching(input_control, output_control);
    endtask

    local task check_data();
        DataTransaction input_data;
        DataTransaction output_data;
        input_data_fifo.get(input_data);
        output_data_fifo.get(output_data);
        check_data_matching(input_data, output_data);
    endtask

    local function void check_control_matching(ControlTransaction in, ControlTransaction out);
        if (!in.compare(out)) begin
            `uvm_error("SCOREBOARD", $sformatf("transactions don't match! \nin: %s\nout: %s\n", in.sprint(), out.sprint()))
        end
    endfunction

    local function void check_data_matching(DataTransaction in, DataTransaction out);
        if (!in.compare(out)) begin
            `uvm_error("SCOREBOARD", $sformatf("transactions don't match! \nin: %s\nout: %s\n", in.sprint(), out.sprint()))
        end
    endfunction
endclass
