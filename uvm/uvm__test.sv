`ifndef LIFO_TEST_SV
`define LIFO_TEST_SV


// ============================================================
// LIFO BASIC TEST
// ============================================================

class lifo_test extends uvm_test;

    `uvm_component_utils(lifo_test)

    lifo_env env;
    virtual inf_lifo vif;


    // --------------------------------------------------------
    // Constructor
    // --------------------------------------------------------

    function new(
        string name = "lifo_test",
        uvm_component parent = null
    );

        super.new(name, parent);

    endfunction


    // --------------------------------------------------------
    // Build Phase
    // --------------------------------------------------------

    function void build_phase(uvm_phase phase);

        super.build_phase(phase);


        env = lifo_env::type_id::create(
            "env",
            this
        );


        if (!uvm_config_db#(virtual inf_lifo)::get(
                this,
                "",
                "vif",
                vif
            )
        )

            `uvm_fatal(
                "TEST",
                "Virtual interface not found"
            )


    endfunction


    // --------------------------------------------------------
    // Run Phase
    // --------------------------------------------------------

    task run_phase(uvm_phase phase);

        lifo_sequence seq;


        phase.raise_objection(this);


        // Wait until reset is released
        wait (vif.rstn === 1'b1);


        // Synchronize with clock
        @(negedge vif.clk);


        `uvm_info(
            "TEST",
            "Starting LIFO basic sequence",
            UVM_LOW
        )


        seq = lifo_sequence::type_id::create("seq");


        seq.start(
            env.agent.sequencer
        );


        // Allow monitor/scoreboard to capture
        // the final transaction
        @(negedge vif.clk);


        phase.drop_objection(this);


    endtask

endclass



// ============================================================
// LIFO ALL TEST
// ============================================================

class lifo_all_test extends uvm_test;

    `uvm_component_utils(lifo_all_test)

    lifo_env env;
    virtual inf_lifo vif;


    // --------------------------------------------------------
    // Constructor
    // --------------------------------------------------------

    function new(
        string name = "lifo_all_test",
        uvm_component parent = null
    );

        super.new(name, parent);

    endfunction


    // --------------------------------------------------------
    // Build Phase
    // --------------------------------------------------------

    function void build_phase(uvm_phase phase);

        super.build_phase(phase);


        env = lifo_env::type_id::create(
            "env",
            this
        );


        if (!uvm_config_db#(virtual inf_lifo)::get(
                this,
                "",
                "vif",
                vif
            )
        )

            `uvm_fatal(
                "TEST",
                "Virtual interface not found"
            )


    endfunction


    // --------------------------------------------------------
    // Run Phase
    // --------------------------------------------------------

    task run_phase(uvm_phase phase);

        lifo_sequence               basic_seq;
        lifo_push_sequence          push_seq;
        lifo_pop_sequence           pop_seq;
        lifo_full_sequence          full_seq;
        lifo_empty_sequence         empty_seq;
        lifo_push_pop_sequence      push_pop_seq;
        lifo_simultaneous_sequence  simultaneous_seq;
        lifo_boundary_sequence      boundary_seq;
        lifo_data_sequence          data_seq;


        phase.raise_objection(this);


        // ----------------------------------------------------
        // Wait for reset release
        // ----------------------------------------------------

        wait (vif.rstn === 1'b1);

        @(negedge vif.clk);


        `uvm_info(
            "ALL_TEST",
            "================================================",
            UVM_NONE
        )

        `uvm_info(
            "ALL_TEST",
            "        STARTING LIFO ALL TEST",
            UVM_NONE
        )

        `uvm_info(
            "ALL_TEST",
            "================================================",
            UVM_NONE
        )


        // ====================================================
        // TEST 1 - BASIC
        // ====================================================

        `uvm_info(
            "ALL_TEST",
            "TEST 1: BASIC LIFO TEST",
            UVM_NONE
        )


        basic_seq =
            lifo_sequence::type_id::create("basic_seq");

        basic_seq.start(
            env.agent.sequencer
        );


        @(negedge vif.clk);


        // ====================================================
        // TEST 2 - PUSH
        // ====================================================

        `uvm_info(
            "ALL_TEST",
            "TEST 2: PUSH TEST",
            UVM_NONE
        )


        push_seq =
            lifo_push_sequence::type_id::create("push_seq");

        push_seq.start(
            env.agent.sequencer
        );


        @(negedge vif.clk);


        // ====================================================
        // TEST 3 - POP
        // ====================================================

        `uvm_info(
            "ALL_TEST",
            "TEST 3: POP TEST",
            UVM_NONE
        )


        pop_seq =
            lifo_pop_sequence::type_id::create("pop_seq");

        pop_seq.start(
            env.agent.sequencer
        );


        @(negedge vif.clk);


        // ====================================================
        // TEST 4 - FULL
        // ====================================================

        `uvm_info(
            "ALL_TEST",
            "TEST 4: FULL CONDITION TEST",
            UVM_NONE
        )


        full_seq =
            lifo_full_sequence::type_id::create("full_seq");

        full_seq.start(
            env.agent.sequencer
        );


        @(negedge vif.clk);


        // ====================================================
        // TEST 5 - EMPTY
        // ====================================================

        `uvm_info(
            "ALL_TEST",
            "TEST 5: EMPTY CONDITION TEST",
            UVM_NONE
        )


        empty_seq =
            lifo_empty_sequence::type_id::create("empty_seq");

        empty_seq.start(
            env.agent.sequencer
        );


        @(negedge vif.clk);


        // ====================================================
        // TEST 6 - PUSH + POP
        // ====================================================

        `uvm_info(
            "ALL_TEST",
            "TEST 6: PUSH/POP TEST",
            UVM_NONE
        )


        push_pop_seq =
            lifo_push_pop_sequence::type_id::create(
                "push_pop_seq"
            );

        push_pop_seq.start(
            env.agent.sequencer
        );


        @(negedge vif.clk);


        // ====================================================
        // TEST 7 - SIMULTANEOUS
        // ====================================================

        `uvm_info(
            "ALL_TEST",
            "TEST 7: SIMULTANEOUS PUSH/POP TEST",
            UVM_NONE
        )


        simultaneous_seq =
            lifo_simultaneous_sequence::type_id::create(
                "simultaneous_seq"
            );

        simultaneous_seq.start(
            env.agent.sequencer
        );


        @(negedge vif.clk);


        // ====================================================
        // TEST 8 - BOUNDARY
        // ====================================================

        `uvm_info(
            "ALL_TEST",
            "TEST 8: BOUNDARY TEST",
            UVM_NONE
        )


        boundary_seq =
            lifo_boundary_sequence::type_id::create(
                "boundary_seq"
            );

        boundary_seq.start(
            env.agent.sequencer
        );


        @(negedge vif.clk);


        // ====================================================
        // TEST 9 - DATA PATTERN
        // ====================================================

        `uvm_info(
            "ALL_TEST",
            "TEST 9: DATA PATTERN TEST",
            UVM_NONE
        )


        data_seq =
            lifo_data_sequence::type_id::create(
                "data_seq"
            );

        data_seq.start(
            env.agent.sequencer
        );


        // ----------------------------------------------------
        // IMPORTANT
        // ----------------------------------------------------
        // Give the monitor one complete clock opportunity
        // to observe the final transaction.
        // ----------------------------------------------------

        @(negedge vif.clk);


        `uvm_info(
            "ALL_TEST",
            "================================================",
            UVM_NONE
        )

        `uvm_info(
            "ALL_TEST",
            "        LIFO ALL TEST COMPLETED",
            UVM_NONE
        )

        `uvm_info(
            "ALL_TEST",
            "================================================",
            UVM_NONE
        )


        phase.drop_objection(this);


    endtask

endclass


`endif