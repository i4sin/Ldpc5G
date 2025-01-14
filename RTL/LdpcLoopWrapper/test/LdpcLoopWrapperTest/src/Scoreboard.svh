class Scoreboard #(
    parameter CONTROL_STATUS_WIDTH,
    parameter DATA_WIDTH
) extends uvm_scoreboard;
    `uvm_component_param_utils(Scoreboard#(CONTROL_STATUS_WIDTH, DATA_WIDTH))

    typedef AxisTransaction#(CONTROL_STATUS_WIDTH) AxisControlStatusTransaction;
    typedef ControlStatusTransaction#(CONTROL_STATUS_WIDTH) ControlStatusTransaction;
    typedef AxisTransaction#(DATA_WIDTH) DataTransaction;
    typedef uvm_analysis_export #(AxisControlStatusTransaction) AxisControlStatusExport;
    typedef ControlStatusMap #(CONTROL_STATUS_WIDTH) ControlStatusMap;
    typedef uvm_tlm_analysis_fifo #(ControlStatusTransaction) ControlStatusAnalysisFifo;
    typedef uvm_tlm_analysis_fifo #(DataTransaction) DataAnalysisFifo;

    AxisControlStatusExport input_control_export;
    AxisControlStatusExport output_status_export;
    DataAnalysisFifo input_data_fifo;
    DataAnalysisFifo output_data_fifo;

    local ControlStatusMap input_control_map;
    local ControlStatusMap output_status_map;
    local ControlStatusAnalysisFifo input_control_fifo;
    local ControlStatusAnalysisFifo output_status_fifo;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        input_control_export = new("input_control_export", this);
        output_status_export = new("output_status_export", this);
        input_control_map = new("input_control_map", this);
        output_status_map = new("output_status_map", this);
        input_control_fifo = new("input_control_fifo", this);
        output_status_fifo = new("output_status_fifo", this);
        input_data_fifo = new("input_data_fifo", this);
        output_data_fifo = new("output_data_fifo", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        input_control_export.connect(input_control_map.imp);
        output_status_export.connect(output_status_map.imp);
        input_control_map.port.connect(input_control_fifo.analysis_export);
        output_status_map.port.connect(output_status_fifo.analysis_export);
    endfunction

    virtual task run_phase(uvm_phase phase);
        forever begin
            fork
                check_control_status();
                check_data();
            join
        end
    endtask

    virtual function void check_phase(uvm_phase phase);
        // if (input_control_fifo.used() != 0)
        //     `uvm_error("SCOREBOARD", $sformatf(
        //         "input_control_fifo is not empty! remained transactions: %0d", input_control_fifo.used()))
        // if (input_data_fifo.used() != 0)
        //     `uvm_error("SCOREBOARD", $sformatf(
        //         "input_data_fifo is not empty! remained transactions: %0d", input_data_fifo.used()))
        // if (output_status_fifo.used() != 0)
        //     `uvm_error("SCOREBOARD", $sformatf(
        //         "output_status_fifo is not empty! remained transactions: %0d", output_status_fifo.used()))
        // if (output_data_fifo.used() != 0)
        //     `uvm_error("SCOREBOARD", $sformatf(
        //         "output_data_fifo is not empty! remained transactions: %0d", output_data_fifo.used()))
    endfunction

    local task check_control_status();
        ControlStatusTransaction input_control;
        ControlStatusTransaction output_status;
        input_control_fifo.get(input_control);
        output_status_fifo.get(output_status);
        check_matching(input_control, output_status);
    endtask

    local task check_data();
        DataTransaction input_data;
        DataTransaction output_data;
        input_data_fifo.get(input_data);
        output_data_fifo.get(output_data);
        check_matching(input_data, output_data);
    endtask

    local function void check_matching(uvm_transaction in, uvm_transaction out);
        if (!in.compare(out)) begin
            `uvm_error("SCOREBOARD", $sformatf("transactions don't match! \nin: %s\nout: %s\n", in.sprint(), out.sprint()))
        end
    endfunction
endclass
