class lifo_driver extends uvm_driver #(lifo_seq_item);

    `uvm_component_utils(lifo_driver)

    virtual inf_lifo vif;


    function new(
        string name = "lifo_driver",
        uvm_component parent = null
    );

        super.new(name, parent);

    endfunction


    function void build_phase(uvm_phase phase);

        super.build_phase(phase);

        if (!uvm_config_db#(virtual inf_lifo)::get(
                this,
                "",
                "vif",
                vif
            ))

            `uvm_fatal(
                "DRIVER",
                "Virtual interface not found"
            )

    endfunction


    task run_phase(uvm_phase phase);

        lifo_seq_item req;


        vif.push = 0;
        vif.pop  = 0;
        vif.din  = 0;


        forever begin

            seq_item_port.get_next_item(req);


            @(negedge vif.clk);

            vif.push = req.push;
            vif.pop  = req.pop;
            vif.din  = req.din;


            `uvm_info(
                "DRIVER",
                $sformatf(
                    "Driving: push=%0b pop=%0b din=0x%04h",
                    req.push,
                    req.pop,
                    req.din
                ),
                UVM_HIGH
            )


            @(posedge vif.clk);


            seq_item_port.item_done();


            @(negedge vif.clk);

            vif.push = 0;
            vif.pop  = 0;

        end

    endtask

endclass