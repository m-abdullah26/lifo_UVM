`ifndef LIFO_TEST_SV
`define LIFO_TEST_SV


// ============================================================
// LIFO BASIC TEST
// ============================================================

class lifo_test extends uvm_test;

    `uvm_component_utils(lifo_test)

    lifo_env env;
    virtual inf_lifo vif;


    function new(
        string name = "lifo_test",
        uvm_component parent = null
    );
        super.new(name, parent);
    endfunction


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


    task run_phase(uvm_phase phase);

        lifo_sequence seq;

        phase.raise_objection(this);

        wait (vif.rstn === 1'b1);
        @(negedge vif.clk);

        `uvm_info(
            "TEST",
            "Starting LIFO basic sequence",
            UVM_NONE
        )

        seq = lifo_sequence::type_id::create("seq");

        seq.start(
            env.agent.sequencer
        );

        @(negedge vif.clk);

        `uvm_info(
            "TEST",
            "LIFO basic sequence completed",
            UVM_NONE
        )

        phase.drop_objection(this);

    endtask

endclass



// ============================================================
// LIFO PUSH TEST
// ============================================================

class lifo_push_test extends uvm_test;

    `uvm_component_utils(lifo_push_test)

    lifo_env env;
    virtual inf_lifo vif;


    function new(
        string name = "lifo_push_test",
        uvm_component parent = null
    );
        super.new(name, parent);
    endfunction


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


    task run_phase(uvm_phase phase);

        lifo_push_sequence seq;

        phase.raise_objection(this);

        wait (vif.rstn === 1'b1);
        @(negedge vif.clk);

        `uvm_info(
            "TEST",
            "Starting LIFO push sequence",
            UVM_NONE
        )

        seq = lifo_push_sequence::type_id::create("seq");

        seq.start(
            env.agent.sequencer
        );

        @(negedge vif.clk);

        `uvm_info(
            "TEST",
            "LIFO push sequence completed",
            UVM_NONE
        )

        phase.drop_objection(this);

    endtask

endclass



// ============================================================
// LIFO POP TEST
// ============================================================

class lifo_pop_test extends uvm_test;

    `uvm_component_utils(lifo_pop_test)

    lifo_env env;
    virtual inf_lifo vif;


    function new(
        string name = "lifo_pop_test",
        uvm_component parent = null
    );
        super.new(name, parent);
    endfunction


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


    task run_phase(uvm_phase phase);

        lifo_pop_sequence seq;

        phase.raise_objection(this);

        wait (vif.rstn === 1'b1);
        @(negedge vif.clk);

        `uvm_info(
            "TEST",
            "Starting LIFO pop sequence",
            UVM_NONE
        )

        seq = lifo_pop_sequence::type_id::create("seq");

        seq.start(
            env.agent.sequencer
        );

        @(negedge vif.clk);

        `uvm_info(
            "TEST",
            "LIFO pop sequence completed",
            UVM_NONE
        )

        phase.drop_objection(this);

    endtask

endclass



// ============================================================
// LIFO FULL TEST
// ============================================================

class lifo_full_test extends uvm_test;

    `uvm_component_utils(lifo_full_test)

    lifo_env env;
    virtual inf_lifo vif;


    function new(
        string name = "lifo_full_test",
        uvm_component parent = null
    );
        super.new(name, parent);
    endfunction


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


    task run_phase(uvm_phase phase);

        lifo_full_sequence seq;

        phase.raise_objection(this);

        wait (vif.rstn === 1'b1);
        @(negedge vif.clk);

        `uvm_info(
            "TEST",
            "Starting LIFO full sequence",
            UVM_NONE
        )

        seq = lifo_full_sequence::type_id::create("seq");

        seq.start(
            env.agent.sequencer
        );

        @(negedge vif.clk);

        `uvm_info(
            "TEST",
            "LIFO full sequence completed",
            UVM_NONE
        )

        phase.drop_objection(this);

    endtask

endclass



// ============================================================
// LIFO EMPTY TEST
// ============================================================

class lifo_empty_test extends uvm_test;

    `uvm_component_utils(lifo_empty_test)

    lifo_env env;
    virtual inf_lifo vif;


    function new(
        string name = "lifo_empty_test",
        uvm_component parent = null
    );
        super.new(name, parent);
    endfunction


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


    task run_phase(uvm_phase phase);

        lifo_empty_sequence seq;

        phase.raise_objection(this);

        wait (vif.rstn === 1'b1);
        @(negedge vif.clk);

        `uvm_info(
            "TEST",
            "Starting LIFO empty sequence",
            UVM_NONE
        )

        seq = lifo_empty_sequence::type_id::create("seq");

        seq.start(
            env.agent.sequencer
        );

        @(negedge vif.clk);

        `uvm_info(
            "TEST",
            "LIFO empty sequence completed",
            UVM_NONE
        )

        phase.drop_objection(this);

    endtask

endclass



// ============================================================
// LIFO PUSH + POP TEST
// ============================================================

class lifo_push_pop_test extends uvm_test;

    `uvm_component_utils(lifo_push_pop_test)

    lifo_env env;
    virtual inf_lifo vif;


    function new(
        string name = "lifo_push_pop_test",
        uvm_component parent = null
    );
        super.new(name, parent);
    endfunction


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


    task run_phase(uvm_phase phase);

        lifo_push_pop_sequence seq;

        phase.raise_objection(this);

        wait (vif.rstn === 1'b1);
        @(negedge vif.clk);

        `uvm_info(
            "TEST",
            "Starting LIFO push/pop sequence",
            UVM_NONE
        )

        seq = lifo_push_pop_sequence::type_id::create("seq");

        seq.start(
            env.agent.sequencer
        );

        @(negedge vif.clk);

        `uvm_info(
            "TEST",
            "LIFO push/pop sequence completed",
            UVM_NONE
        )

        phase.drop_objection(this);

    endtask

endclass



// ============================================================
// LIFO SIMULTANEOUS TEST
// ============================================================

class lifo_simultaneous_test extends uvm_test;

    `uvm_component_utils(lifo_simultaneous_test)

    lifo_env env;
    virtual inf_lifo vif;


    function new(
        string name = "lifo_simultaneous_test",
        uvm_component parent = null
    );
        super.new(name, parent);
    endfunction


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


    task run_phase(uvm_phase phase);

        lifo_simultaneous_sequence seq;

        phase.raise_objection(this);

        wait (vif.rstn === 1'b1);
        @(negedge vif.clk);

        `uvm_info(
            "TEST",
            "Starting LIFO simultaneous push/pop sequence",
            UVM_NONE
        )

        seq = lifo_simultaneous_sequence::type_id::create("seq");

        seq.start(
            env.agent.sequencer
        );

        @(negedge vif.clk);

        `uvm_info(
            "TEST",
            "LIFO simultaneous push/pop sequence completed",
            UVM_NONE
        )

        phase.drop_objection(this);

    endtask

endclass



// ============================================================
// LIFO BOUNDARY TEST
// ============================================================

class lifo_boundary_test extends uvm_test;

    `uvm_component_utils(lifo_boundary_test)

    lifo_env env;
    virtual inf_lifo vif;


    function new(
        string name = "lifo_boundary_test",
        uvm_component parent = null
    );
        super.new(name, parent);
    endfunction


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


    task run_phase(uvm_phase phase);

        lifo_boundary_sequence seq;

        phase.raise_objection(this);

        wait (vif.rstn === 1'b1);
        @(negedge vif.clk);

        `uvm_info(
            "TEST",
            "Starting LIFO boundary sequence",
            UVM_NONE
        )

        seq = lifo_boundary_sequence::type_id::create("seq");

        seq.start(
            env.agent.sequencer
        );

        @(negedge vif.clk);

        `uvm_info(
            "TEST",
            "LIFO boundary sequence completed",
            UVM_NONE
        )

        phase.drop_objection(this);

    endtask

endclass



// ============================================================
// LIFO DATA TEST
// ============================================================

class lifo_data_test extends uvm_test;

    `uvm_component_utils(lifo_data_test)

    lifo_env env;
    virtual inf_lifo vif;


    function new(
        string name = "lifo_data_test",
        uvm_component parent = null
    );
        super.new(name, parent);
    endfunction


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


    task run_phase(uvm_phase phase);

        lifo_data_sequence seq;

        phase.raise_objection(this);

        wait (vif.rstn === 1'b1);
        @(negedge vif.clk);

        `uvm_info(
            "TEST",
            "Starting LIFO data pattern sequence",
            UVM_NONE
        )

        seq = lifo_data_sequence::type_id::create("seq");

        seq.start(
            env.agent.sequencer
        );

        @(negedge vif.clk);

        `uvm_info(
            "TEST",
            "LIFO data pattern sequence completed",
            UVM_NONE
        )

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


    function new(
        string name = "lifo_all_test",
        uvm_component parent = null
    );
        super.new(name, parent);
    endfunction


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
            "TEST 1: BASIC LIFO TEST STARTING",
            UVM_NONE
        )

        basic_seq =
            lifo_sequence::type_id::create("basic_seq");

        basic_seq.start(
            env.agent.sequencer
        );

        @(negedge vif.clk);

        `uvm_info(
            "ALL_TEST",
            "TEST 1: BASIC LIFO TEST COMPLETED",
            UVM_NONE
        )


        // ====================================================
        // TEST 2 - PUSH
        // ====================================================

        `uvm_info(
            "ALL_TEST",
            "TEST 2: PUSH TEST STARTING",
            UVM_NONE
        )

        push_seq =
            lifo_push_sequence::type_id::create("push_seq");

        push_seq.start(
            env.agent.sequencer
        );

        @(negedge vif.clk);

        `uvm_info(
            "ALL_TEST",
            "TEST 2: PUSH TEST COMPLETED",
            UVM_NONE
        )


        // ====================================================
        // TEST 3 - POP
        // ====================================================

        `uvm_info(
            "ALL_TEST",
            "TEST 3: POP TEST STARTING",
            UVM_NONE
        )

        pop_seq =
            lifo_pop_sequence::type_id::create("pop_seq");

        pop_seq.start(
            env.agent.sequencer
        );

        @(negedge vif.clk);

        `uvm_info(
            "ALL_TEST",
            "TEST 3: POP TEST COMPLETED",
            UVM_NONE
        )


        // ====================================================
        // TEST 4 - FULL
        // ====================================================

        `uvm_info(
            "ALL_TEST",
            "TEST 4: FULL CONDITION TEST STARTING",
            UVM_NONE
        )

        full_seq =
            lifo_full_sequence::type_id::create("full_seq");

        full_seq.start(
            env.agent.sequencer
        );

        @(negedge vif.clk);

        `uvm_info(
            "ALL_TEST",
            "TEST 4: FULL CONDITION TEST COMPLETED",
            UVM_NONE
        )


        // ====================================================
        // TEST 5 - EMPTY
        // ====================================================

        `uvm_info(
            "ALL_TEST",
            "TEST 5: EMPTY CONDITION TEST STARTING",
            UVM_NONE
        )

        empty_seq =
            lifo_empty_sequence::type_id::create("empty_seq");

        empty_seq.start(
            env.agent.sequencer
        );

        @(negedge vif.clk);

        `uvm_info(
            "ALL_TEST",
            "TEST 5: EMPTY CONDITION TEST COMPLETED",
            UVM_NONE
        )


        // ====================================================
        // TEST 6 - PUSH + POP
        // ====================================================

        `uvm_info(
            "ALL_TEST",
            "TEST 6: PUSH/POP TEST STARTING",
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

        `uvm_info(
            "ALL_TEST",
            "TEST 6: PUSH/POP TEST COMPLETED",
            UVM_NONE
        )


        // ====================================================
        // TEST 7 - SIMULTANEOUS
        // ====================================================

        `uvm_info(
            "ALL_TEST",
            "TEST 7: SIMULTANEOUS PUSH/POP TEST STARTING",
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

        `uvm_info(
            "ALL_TEST",
            "TEST 7: SIMULTANEOUS PUSH/POP TEST COMPLETED",
            UVM_NONE
        )


        // ====================================================
        // TEST 8 - BOUNDARY
        // ====================================================

        `uvm_info(
            "ALL_TEST",
            "TEST 8: BOUNDARY TEST STARTING",
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

        `uvm_info(
            "ALL_TEST",
            "TEST 8: BOUNDARY TEST COMPLETED",
            UVM_NONE
        )


        // ====================================================
        // TEST 9 - DATA PATTERN
        // ====================================================

        `uvm_info(
            "ALL_TEST",
            "TEST 9: DATA PATTERN TEST STARTING",
            UVM_NONE
        )

        data_seq =
            lifo_data_sequence::type_id::create(
                "data_seq"
            );

        data_seq.start(
            env.agent.sequencer
        );

        @(negedge vif.clk);

        `uvm_info(
            "ALL_TEST",
            "TEST 9: DATA PATTERN TEST COMPLETED",
            UVM_NONE
        )


        // ----------------------------------------------------
        // Final synchronization
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