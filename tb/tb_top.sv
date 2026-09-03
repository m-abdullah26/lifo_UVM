`timescale 1ns/1ps

import uvm_pkg::*;
import lifo_pkg::*;

`include "uvm_macros.svh"


module tb_top;

    parameter DEPTH  = 8;
    parameter DWIDTH = 16;


    // ============================================================
    // CLOCK
    // ============================================================

    logic clk;

    initial begin

        clk = 0;

        forever
            #5 clk = ~clk;

    end


    // ============================================================
    // LIFO INTERFACE
    // ============================================================

    inf_lifo #(
        .DWIDTH(DWIDTH)
    ) lifo_if (
        .clk(clk)
    );


    // ============================================================
    // LIFO DUT
    // ============================================================

    lifo #(
        .DEPTH(DEPTH),
        .DWIDTH(DWIDTH)
    ) dut (

        .clk   (clk),

        .rstn  (lifo_if.rstn),

        .push  (lifo_if.push),

        .pop   (lifo_if.pop),

        .din   (lifo_if.din),

        .dout  (lifo_if.dout),

        .empty (lifo_if.empty),

        .full  (lifo_if.full)

    );


    // ============================================================
    // RESET
    // ============================================================

    initial begin

        lifo_if.rstn = 0;

        lifo_if.push = 0;

        lifo_if.pop  = 0;

        lifo_if.din  = '0;


        // Hold reset for 12 ns
        #12;


        // Release reset
        lifo_if.rstn = 1;

    end


    // ============================================================
    // UVM CONFIGURATION
    // ============================================================

    initial begin

        uvm_config_db#(virtual inf_lifo)::set(
            null,
            "*",
            "vif",
            lifo_if
        );


        // Start UVM
        run_test();

    end


endmodule