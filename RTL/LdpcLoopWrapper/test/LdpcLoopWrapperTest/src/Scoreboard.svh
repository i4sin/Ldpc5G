class Scoreboard #(
    parameter CONTROL_STATUS_WIDTH,
    parameter DATA_WIDTH
) extends uvm_scoreboard;
    `uvm_component_param_utils(Scoreboard#(CONTROL_STATUS_WIDTH, DATA_WIDTH))

    typedef AxisTransaction#(CONTROL_STATUS_WIDTH) AxisControlStatusTransaction;
    typedef ControlStatusTransaction#(CONTROL_STATUS_WIDTH) ControlStatusTransaction;
    typedef AxisTransaction#(DATA_WIDTH) DataTransaction;
    typedef uvm_analysis_export #(AxisControlStatusTransaction) AxisControlStatusExport;
    typedef uvm_analysis_export #(DataTransaction) DataExport;
    typedef ControlStatusMap #(CONTROL_STATUS_WIDTH) ControlStatusMap;
    typedef uvm_tlm_analysis_fifo #(ControlStatusTransaction) ControlStatusAnalysisFifo;
    typedef uvm_tlm_analysis_fifo #(DataTransaction) DataAnalysisFifo;

    AxisControlStatusExport encoder_control_export;
    AxisControlStatusExport decoder_control_export;
    AxisControlStatusExport encoder_status_export;
    AxisControlStatusExport decoder_status_export;
    DataExport input_data_export;
    DataExport output_data_export;

    local ControlStatusMap encoder_control_map;
    local ControlStatusMap decoder_control_map;
    local ControlStatusMap encoder_status_map;
    local ControlStatusMap decoder_status_map;

    local ControlStatusAnalysisFifo encoder_control_fifo;
    local ControlStatusAnalysisFifo decoder_control_fifo;
    local ControlStatusAnalysisFifo encoder_status_fifo;
    local ControlStatusAnalysisFifo decoder_status_fifo;
    local DataAnalysisFifo input_data_fifo;
    local DataAnalysisFifo output_data_fifo;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        encoder_control_export = new("encoder_control_export", this);
        decoder_control_export = new("decoder_control_export", this);
        encoder_status_export = new("encoder_status_export", this);
        decoder_status_export = new("decoder_status_export", this);
        input_data_export = new("input_data_export", this);
        output_data_export = new("output_data_export", this);
        encoder_control_map = new("encoder_control_map", this);
        decoder_control_map = new("decoder_control_map", this);
        encoder_status_map = new("encoder_status_map", this);
        decoder_status_map = new("decoder_status_map", this);
        encoder_control_fifo = new("encoder_control_fifo", this);
        decoder_control_fifo = new("decoder_control_fifo", this);
        encoder_status_fifo = new("encoder_status_fifo", this);
        decoder_status_fifo = new("decoder_status_fifo", this);
        input_data_fifo = new("input_data_fifo", this);
        output_data_fifo = new("output_data_fifo", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        encoder_control_export.connect(encoder_control_map.imp);
        decoder_control_export.connect(decoder_control_map.imp);
        encoder_status_export.connect(encoder_status_map.imp);
        decoder_status_export.connect(decoder_status_map.imp);
        encoder_control_map.port.connect(encoder_control_fifo.analysis_export);
        decoder_control_map.port.connect(decoder_control_fifo.analysis_export);
        encoder_status_map.port.connect(encoder_status_fifo.analysis_export);
        decoder_status_map.port.connect(decoder_status_fifo.analysis_export);
        input_data_export.connect(input_data_fifo.analysis_export);
        output_data_export.connect(output_data_fifo.analysis_export);
    endfunction

    virtual task run_phase(uvm_phase phase);
        fork
            check_encoder();
            check_decoder();
            check_data();
        join
    endtask

    virtual function void check_phase(uvm_phase phase);
        check_fifo_empty(encoder_control_fifo);
        check_fifo_empty(decoder_control_fifo);
        check_fifo_empty(encoder_status_fifo);
        check_fifo_empty(decoder_status_fifo);
        check_fifo_empty(input_data_fifo);
        check_fifo_empty(output_data_fifo);
    endfunction

    local task check_encoder();
        forever begin
            ControlStatusTransaction input_control;
            ControlStatusTransaction output_status;
            encoder_control_fifo.get(input_control);
            encoder_status_fifo.get(output_status);
            check_matching(input_control, output_status);
        end
    endtask

    local task check_decoder();
        forever begin
            ControlStatusTransaction input_control;
            ControlStatusTransaction output_status;
            decoder_control_fifo.get(input_control);
            decoder_status_fifo.get(output_status);
            check_matching(input_control, output_status);
        end
    endtask

    local task check_data();
        forever begin
            DataTransaction input_data;
            DataTransaction output_data;
            input_data_fifo.get(input_data);
            output_data_fifo.get(output_data);
            check_matching(input_data, output_data);
        end
    endtask

    local function void check_matching(uvm_transaction in, uvm_transaction out);
        if (!in.compare(out)) begin
            `uvm_error("SCOREBOARD", $sformatf("transactions don't match! \nin: %s\nout: %s\n", in.sprint(), out.sprint()))
        end
    endfunction

    local function void check_fifo_empty(uvm_tlm_analysis_fifo fifo);
        if (fifo.used() != 0)
            `uvm_error("SCOREBOARD", $sformatf("%s is not empty! remained transactions: %0d", fifo.get_name(), fifo.used()))
    endfunction
endclass
