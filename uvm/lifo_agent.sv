class lifo_agent extends uvm_agent;

    `uvm_component_utils(lifo_agent)


    lifo_sequencer sequencer;
    lifo_driver    driver;
    lifo_monitor   monitor;


    function new(
        string name = "lifo_agent",
        uvm_component parent = null
    );

        super.new(name, parent);

    endfunction


    function void build_phase(uvm_phase phase);

        super.build_phase(phase);


        sequencer =
            lifo_sequencer::type_id::create(
                "sequencer",
                this
            );


        driver =
            lifo_driver::type_id::create(
                "driver",
                this
            );


        monitor =
            lifo_monitor::type_id::create(
                "monitor",
                this
            );

    endfunction


    function void connect_phase(uvm_phase phase);

        super.connect_phase(phase);


        driver.seq_item_port.connect(
            sequencer.seq_item_export
        );

    endfunction

endclass