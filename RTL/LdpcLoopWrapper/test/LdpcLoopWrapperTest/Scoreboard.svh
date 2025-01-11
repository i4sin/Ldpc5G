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
            ControlTransaction input_control;
            ControlTransaction output_control;
            DataTransaction input_data;
            DataTransaction output_data;
            input_control_fifo.get(input_control);
            output_control_fifo.get(output_control);
            input_data_fifo.get(input_data);
            output_data_fifo.get(output_data);
        end
    endtask
endclass