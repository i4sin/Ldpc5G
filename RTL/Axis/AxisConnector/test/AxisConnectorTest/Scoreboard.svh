class Scoreboard #(
    parameter DATA_WIDTH
) extends uvm_scoreboard;
    `uvm_component_param_utils(Scoreboard#(DATA_WIDTH))

    typedef AxisTransaction#(DATA_WIDTH) Transaction;
    typedef uvm_tlm_analysis_fifo #(Transaction) AnalysisFifo;

    AnalysisFifo input_fifo;
    AnalysisFifo output_fifo;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        input_fifo = new("input_fifo", this);
        output_fifo = new("output_fifo", this);
    endfunction

    virtual task run_phase(uvm_phase phase);
        forever begin
            Transaction input_transaction;
            Transaction output_transaction;
            input_fifo.get(input_transaction);
            output_fifo.get(output_transaction);
            check_matching(input_transaction, output_transaction);
        end
    endtask

    virtual function void check_phase(uvm_phase phase);
        if (input_fifo.used() != 0)
            `uvm_error("SCOREBOARD", $sformatf(
                "input_fifo is not empty! remained transactions: %0d", input_fifo.used()))
        if (output_fifo.used() != 0)
            `uvm_error("SCOREBOARD", $sformatf(
                "output_fifo is not empty! remained transactions: %0d", output_fifo.used()))
    endfunction

    local function void check_matching(Transaction input_transaction, Transaction output_transaction);
        if (!input_transaction.compare(output_transaction)) begin
            `uvm_error("SCOREBOARD", $sformatf("transactions don't match! \ninput_transaction: %s\noutput_transaction: %s\n", input_transaction.sprint(), output_transaction.sprint()))
        end
    endfunction
endclass