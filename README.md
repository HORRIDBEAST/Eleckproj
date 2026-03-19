# Verilog Codes

A comprehensive Verilog HDL practice repository covering digital design from basics to a simple processor model.

This folder contains:
- Fundamental combinational designs (gates, adders, muxes, decoders, encoders, comparator, barrel shifter)
- Sequential designs (counters, latches, flip-flops, shift registers, FIFOs)
- Finite state machines (Moore and Mealy sequence detectors)
- Memory designs (single-port and dual-port RAM variants)
- A custom processor + memory simulation setup

## Repository At A Glance

- Total files: `234`
- Verilog source/testbench files (`.v`): `134`
- Design modules (approx): `68`
- Testbenches (approx): `66`
- Generated simulation artifacts:
	- VCD waveforms (`.vcd`): `40`
	- Icarus runtime files (`.vvp`): `53`

Top-level Verilog distribution:
- `Basics`: 18 files
- `Combinational`: 42 files
- `Finite State Machines`: 5 files
- `Memories`: 16 files
- `Processor`: 3 files
- `Sequntial`: 50 files

## Folder Structure And Contents

### 1) Basics

Path: `Basics/`

Focus: entry-level logic building blocks.

- `Adders/Full Adder/`
	- `FA_behavioural.v`, `FA_dataflow.v`, `FA_using_HA.v`, `FullAdder.v`
	- Matching testbenches (`*_tb.v`)
- `Adders/Half Adder/`
	- Behavioural and structural styles
	- Matching testbenches
- `Gates/AndGate/`
	- `andGate.v`, `andGate_testbench.v`
- `Muxes/`
	- `mux_2_1.v`, `mux_2_1_testbench.v`

### 2) Combinational

Path: `Combinational/`

Focus: medium-complexity combinational circuits and multiple modeling styles.

- `4 Bit FA/`
	- Behavioural, Dataflow, Structural implementations + testbenches
- `ALU/`
	- `4bit.v` (`ALU_4bit`): logic, arithmetic, compare, shift, reduction ops
	- `tb.v`
- `Bareel-Shifter/`
	- Behavioural barrel shifter + testbench
- `Comparator/4bit/`
	- Behavioural and dataflow comparator variants
- `Decoder/2_4`, `Decoder/3_8`
	- Behavioural/dataflow decoders + testbenches
- `Encoder/4_2`
	- Standard and priority encoder variants + testbenches
- `Multiplexers/2`, `Multiplexers/4`
	- 2:1 and 4:1 mux implementations + testbenches

### 3) Finite State Machines

Path: `Finite State Machines/`

Focus: sequence detector FSM implementations.

- `Moore_001.v` + `Moore_001_tb.v`
- `seq_001.v` + `seq_001_tb.v`
- `ColoredBalls.v`

Notes:
- Both Moore and Mealy style detector examples are present.

### 4) Memories

Path: `Memories/`

Focus: RAM architecture variants.

- `Single_PORT_RAM/`
	- `v1.v` to `v4.v` variants (with corresponding testbenches)
- `Dual_PORT_RAM/`
	- `v1.v`, `v2.v`, `truev1.v`, `truev2.v` + testbenches

Typical features used across variants:
- Synchronous read/write logic
- Separate read and write addressing in several designs
- Testbench-driven memory access verification

### 5) Processor

Path: `Processor/`

Focus: simple processor-memory model with instruction execution flow.

- `processor.v`
	- Defines opcodes for arithmetic, logic, branch/jump, load/store, halt
	- Uses tasks like instruction fetch and execute flow
- `memory.v`
	- Byte-addressed memory model, supports read/write transactions
	- Loads initial contents via `$readmemh("memoryContents.out", ...)`
- `topTestbench.v`
	- Integrates processor and memory behavior for simulation

### 6) Sequntial

Path: `Sequntial/` (folder name intentionally kept as-is in repository)

Focus: sequential systems and timing behavior.

- `Counter/`
	- Basic up counter
	- Up/down and load counters
	- Range and modulus counters
	- Clock dividers (`CFD_2`, `CFD_3`, `CFD_4`)
	- Single and dual clock FIFO examples
- `Latch And Flipflops/`
	- `DFF/`: multiple DFF variants with resets/sets and testbenches
	- `DLatch/`: behavioural/dataflow latch variants and reset behavior
- `Register Set/`
	- Shift registers and universal shift register examples

## Modeling Styles Used

Throughout the repository, many designs are implemented in multiple styles:
- Behavioural modeling (`always` blocks, procedural logic)
- Dataflow modeling (`assign` and expressions)
- Structural/hierarchical composition (module instantiation)

This makes the repo useful for comparing coding style, readability, and synthesis interpretation.

## Naming Conventions

Common patterns used in files:
- `*_tb.v` -> testbench
- `Behavioural.v` / `Dataflow.v` / `Structural.v` -> style-specific implementation
- Generated files from simulation:
	- `*.vvp` -> compiled simulation executable (Icarus Verilog)
	- `*.vcd` -> waveform dump for GTKWave

## How To Run Simulations

These examples assume Icarus Verilog (`iverilog`, `vvp`) and GTKWave (`gtkwave`) are installed.

### Option A: Run a specific design + testbench

```bash
iverilog -o sim.vvp <design_file>.v <testbench_file>.v
vvp sim.vvp
gtkwave <wavefile>.vcd
```

Example (`Basics/Muxes`):

```bash
iverilog -o mux_2_1.vvp mux_2_1.v mux_2_1_testbench.v
vvp mux_2_1.vvp
gtkwave mux_2_1.vcd
```

### Option B: Run all `.v` files in one folder (quick experiment)

```bash
iverilog -o run.vvp *.v
vvp run.vvp
```

Note: This works only when there is a single intended top-level testbench in that folder.

## Suggested Learning Path Using This Repo

1. Start with `Basics/` (gates, half/full adder, 2:1 mux)
2. Move to `Combinational/` (decoders/encoders/comparator/ALU)
3. Practice timing with `Sequntial/Counter` and `Latch And Flipflops`
4. Study control flow via `Finite State Machines/`
5. Explore storage models in `Memories/`
6. Finish with `Processor/` for integrated architecture-level simulation

## Notes

- This repository contains both source and generated simulation outputs (`.vvp`, `.vcd`).
- Some folder/file names include spelling variations (for example `Sequntial`, `Bareel-Shifter`, `Universal_Shift_Reb`); they are preserved to avoid breaking references.
- Many modules are intentionally duplicated across modeling styles for learning and comparison.
