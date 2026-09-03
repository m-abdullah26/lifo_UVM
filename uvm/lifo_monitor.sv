class lifo_monitor extends uvm_monitor;

    `uvm_component_utils(lifo_monitor)

    virtual inf_lifo vif;

    uvm_analysis_port #(lifo_seq_item) analysis_port;


    function new(
        string name = "lifo_monitor",
        uvm_component parent = null
    );

        super.new(name, parent);

        analysis_port =
            new("analysis_port", this);

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
                "MONITOR",
                "Virtual interface not found"
            )

    endfunction


    task run_phase(uvm_phase phase);

        lifo_seq_item item;


        forever begin

            @(posedge vif.clk);

            #1;


            if (!vif.rstn)
                continue;


            item =
                lifo_seq_item::type_id::create("item");


            item.push  = vif.push;
            item.pop   = vif.pop;
            item.din   = vif.din;

            item.dout  = vif.dout;
            item.empty = vif.empty;
            item.full  = vif.full;


            `uvm_info(
                "MONITOR",
                $sformatf(
                    "Observed: push=%0b pop=%0b din=0x%04h dout=0x%04h empty=%0b full=%0b",
                    item.push,
                    item.pop,
                    item.din,
                    item.dout,
                    item.empty,
                    item.full
                ),
                UVM_HIGH
            )


            analysis_port.write(item);

        end

    endtask

endclass