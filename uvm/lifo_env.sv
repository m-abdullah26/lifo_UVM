class lifo_env extends uvm_env;

    `uvm_component_utils(lifo_env)


    lifo_agent      agent;
    lifo_scoreboard scoreboard;
    lifo_coverage   coverage;


    function new(
        string name = "lifo_env",
        uvm_component parent = null
    );

        super.new(name, parent);

    endfunction


    function void build_phase(uvm_phase phase);

        super.build_phase(phase);


        agent =
            lifo_agent::type_id::create(
                "agent",
                this
            );


        scoreboard =
            lifo_scoreboard::type_id::create(
                "scoreboard",
                this
            );


        coverage =
            lifo_coverage::type_id::create(
                "coverage",
                this
            );

    endfunction


    function void connect_phase(uvm_phase phase);

        super.connect_phase(phase);


        agent.monitor.analysis_port.connect(
            scoreboard.analysis_export
        );


        agent.monitor.analysis_port.connect(
            coverage.analysis_export
        );

    endfunction

endclass