# Synchronous LIFO — UVM Verification

A SystemVerilog **UVM-based verification environment** for a synchronous LIFO (Last-In, First-Out). The project verifies reset behavior, push/pop operations, empty and full conditions, boundary behavior, simultaneous push/pop operations, data integrity, and functional coverage.

## 📌 Project Overview

The DUT is a parameterized synchronous LIFO controlled by reset, push, pop, and input data.

| Condition | Operation |
|---|---|
| `rstn = 0` | LIFO resets |
| `rstn = 1, push = 1, full = 0` | Pushes `din` onto the stack |
| `rstn = 1, pop = 1, empty = 0` | Pops the top stack entry to `dout` |
| `empty = 1` | Pop operation is blocked |
| `full = 1` | Push operation is blocked |
| `push = 1, pop = 1` | Simultaneous push/pop operation |

The current DUT configuration uses a depth of **8 entries** and a data width of **16 bits**.

## 🧩 DUT

The LIFO uses a stack pointer (`sp`) to track the number of stored entries.

```text
sp = 0       → Empty
0 < sp < 8   → Partially Occupied
sp = 8       → Full
```

## 🧩 Complete DUT

The following is the complete LIFO RTL used in this project:

```systemverilog
`timescale 1ns/1ps

module lifo #(
    parameter DEPTH  = 8,
    parameter DWIDTH = 16
)(
    input logic              clk,
    input logic              rstn,
    input logic              push,
    input logic              pop,
    input logic [DWIDTH-1:0] din,
    output logic [DWIDTH-1:0] dout,
    output logic              empty,
    output logic              full
);

    logic [DWIDTH-1:0] stack [0:DEPTH-1];
    logic [$clog2(DEPTH+1)-1:0] sp;

    assign empty = (sp == 0);
    assign full  = (sp == DEPTH);

    always_ff @(posedge clk) begin
        if (!rstn) begin
            sp   <= '0;
            dout <= '0;
        end
        else begin
            case ({push, pop})

                2'b10: begin
                    if (!full) begin
                        stack[sp] <= din;
                        sp        <= sp + 1'b1;
                    end
                end

                2'b01: begin
                    if (!empty) begin
                        sp   <= sp - 1'b1;
                        dout <= stack[sp - 1'b1];
                    end
                end

                2'b11: begin
                    if (!empty && !full) begin
                        stack[sp - 1'b1] <= din;
                        dout             <= stack[sp - 1'b1];
                    end
                    else if (empty) begin
                        stack[sp] <= din;
                        sp        <= sp + 1'b1;
                    end
                    else if (full) begin
                        sp   <= sp - 1'b1;
                        dout <= stack[sp - 1'b1];
                    end
                end

                default: begin
                end

            endcase
        end
    end

    initial begin
        $monitor(
            "[%0t] [LIFO] push=%0b din=0x%0h pop=%0b dout=0x%0h empty=%0b full=%0b",
            $time,
            push,
            din,
            pop,
            dout,
            empty,
            full
        );
    end

endmodule
```

### DUT Interface

| Signal | Direction | Description |
|---|---|---|
| `clk` | Input | System clock |
| `rstn` | Input | Active-low reset |
| `push` | Input | Push data onto the LIFO |
| `pop` | Input | Pop the top entry from the LIFO |
| `din` | Input | Input data |
| `dout` | Output | Popped/output data |
| `empty` | Output | Indicates LIFO is empty |
| `full` | Output | Indicates LIFO is full |

### DUT Operation

The LIFO uses the `sp` stack pointer to track the number of valid entries.

```text
push = 1, pop = 0
    |
    +-- If not full → store din and increment sp


push = 0, pop = 1
    |
    +-- If not empty → output top entry and decrement sp


push = 1, pop = 1
    |
    +-- Normal state → replace top entry and output previous top
    +-- Empty       → push din
    +-- Full        → pop top entry
```

## 🏗️ UVM Testbench Architecture

```text
tb_top
  |
  +-- DUT
  |
  +-- inf_lifo
  |
  +-- lifo_all_test
          |
          +-- lifo_env
                  |
                  +-- lifo_agent
                  |       |
                  |       +-- sequencer
                  |       +-- driver
                  |       +-- monitor
                  |
                  +-- scoreboard
                  |
                  +-- coverage
```

### Transaction Flow

```text
Sequence
   |
   v
Sequencer
   |
   v
Driver
   |
   v
DUT
   |
   v
Monitor
   |
   +-----------> Scoreboard
   |
   +-----------> Functional Coverage
```

## 📁 Project Structure

```text
lifo_UVM/
│
├── rtl/
│   └── dut.sv
│
├── uvm/
│   ├── inf_lifo.sv
│   ├── lifo_pkg.sv
│   ├── lifo_seq_item.sv
│   ├── lifo_sequence.sv
│   ├── lifo_sequencer.sv
│   ├── lifo_driver.sv
│   ├── lifo_monitor.sv
│   ├── lifo_coverage.sv
│   ├── lifo_scoreboard.sv
│   ├── lifo_agent.sv
│   ├── lifo_env.sv
│   └── lifo_test.sv
│
└── tb/
    └── tb_top.sv
```

## 🧪 Verification Tests and Sequences

| Sequence | Verification Scenario |
|---|---|
| `lifo_sequence` | Basic push, full, pop, and empty behavior |
| `lifo_push_sequence` | Push operation and full boundary |
| `lifo_pop_sequence` | Push entries followed by pop operations |
| `lifo_full_sequence` | Fill LIFO and verify blocked pushes |
| `lifo_empty_sequence` | Verify blocked pops when LIFO is empty |
| `lifo_push_pop_sequence` | Sequential push and pop operations |
| `lifo_simultaneous_sequence` | Simultaneous push/pop operation |
| `lifo_boundary_sequence` | Empty/full boundary conditions |
| `lifo_data_sequence` | Data-pattern and LIFO data-integrity testing |

## 🧪 Separate UVM Tests

| Test | Purpose |
|---|---|
| `lifo_test` | Basic LIFO verification |
| `lifo_push_test` | Push operation verification |
| `lifo_pop_test` | Pop operation verification |
| `lifo_full_test` | Full-condition verification |
| `lifo_empty_test` | Empty-condition verification |
| `lifo_push_pop_test` | Sequential push/pop verification |
| `lifo_simultaneous_test` | Simultaneous push/pop verification |
| `lifo_boundary_test` | Boundary-condition verification |
| `lifo_data_test` | Data-pattern verification |
| `lifo_all_test` | Executes all nine reusable sequences |

## 🔍 Scoreboard

The scoreboard implements a reference stack to model the expected LIFO contents.

### Push Checking

For a valid push:

```text
push = 1 AND LIFO is not full
```

The input data is pushed onto the reference stack.

### Pop Checking

For a valid pop:

```text
pop = 1 AND LIFO is not empty
```

The expected top element is removed from the reference stack and compared with `dout`.

```text
Expected LIFO Data
       |
       v
Reference Stack
       |
       v
Compare with DUT dout
```

The scoreboard also checks the expected `empty` and `full` status based on reference-stack occupancy.

## 📊 Functional Coverage

The coverage model monitors LIFO inputs, outputs, occupancy, and important corner cases.

### Input Coverage

- `push`
- `pop`
- `din` data patterns
- Push/pop combinations

### Output Coverage

- `empty`
- `full`
- `dout` data patterns

### Occupancy Coverage

```text
0       → Empty
1       → One entry
2-3     → Low occupancy
4-5     → Mid occupancy
6-7     → High occupancy
8       → Full
```

### Cross Coverage

The environment covers:

- Push × Pop
- Operation × LIFO state
- Full × Push
- Empty × Pop

## 🚧 Boundary Verification

### Empty Boundary

```text
LIFO empty
   |
   +-- pop = 1
   |
   +-- Pop must be blocked
```

No invalid data should be consumed when the LIFO is empty.

### Full Boundary

```text
LIFO full
   |
   +-- push = 1
   |
   +-- Push must be blocked
```

Additional pushes must not overwrite existing stack entries.

## 🔄 Simultaneous Push/Pop

The verification environment explicitly tests:

```text
push = 1
pop  = 1
```

The scoreboard checks the resulting stack state and output data according to the DUT behavior.

## 🔢 Data Integrity

The data-pattern sequence verifies LIFO ordering using:

```text
0x0000
0x0001
0xAAAA
0x5555
0xFFFF
0x1234
0xDEAD
0xBEEF
```

Expected LIFO behavior:

```text
Last Write   → First Read
Second Last  → Second Read
Third Last   → Third Read
...
```

Example:

```text
Push: 0000
Push: 0001
Push: AAAA
Push: 5555

Pop → 5555
Pop → AAAA
Pop → 0001
Pop → 0000
```

## 🔄 Reset Verification

The LIFO reset is active-low:

```systemverilog
if (!rstn) begin
    sp   <= '0;
    dout <= '0;
end
```

Reset verification ensures that:

- The stack pointer returns to zero.
- The LIFO becomes empty.
- The output is cleared.

## ▶️ Running the Simulation

The simulation flow:

1. Creates/uses the script
2. Compiles the LIFO RTL
3. Compiles the LIFO interface
4. Compiles the UVM package and components
5. Compiles the testbench top
6. Starts the UVM simulation
7. Runs the selected LIFO test
8. Displays scoreboard and coverage results
9. Allows LIFO signals to be viewed in the waveform window

### Run the Complete Test

```text
+UVM_TESTNAME=lifo_all_test
```

### Run Individual Tests

```text
+UVM_TESTNAME=lifo_test
+UVM_TESTNAME=lifo_push_test
+UVM_TESTNAME=lifo_pop_test
+UVM_TESTNAME=lifo_full_test
+UVM_TESTNAME=lifo_empty_test
+UVM_TESTNAME=lifo_push_pop_test
+UVM_TESTNAME=lifo_simultaneous_test
+UVM_TESTNAME=lifo_boundary_test
+UVM_TESTNAME=lifo_data_test
```

## 📈 Expected Results

A successful verification run should show:

```text
UVM_ERROR  : 0
UVM_FATAL  : 0
```

The scoreboard should report successful push/pop comparisons and correct empty/full status.

The coverage component reports functional coverage during `report_phase()`.

## 🛠️ Tools & Technologies

- SystemVerilog
- UVM
- RTL Simulation
- Functional Coverage
- Reference-Model Scoreboarding
- Sequence-Based Verification

## 👨‍💻 Author

**M. Abdullah**

Digital IC Design Verification Engineer

SystemVerilog • UVM • RTL Verification
