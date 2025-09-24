# Asynchronous-FIFO-Pre

A SystemVerilog-based verification environment for an asynchronous FIFO (First-In, First-Out) memory design.

## Overview

This repository contains the RTL and a UVM-style testbench for verifying an asynchronous FIFO design. The testbench infrastructure includes dedicated environments, agents, monitors, drivers, scoreboards, coverage, and sequence libraries for comprehensive verification.

## Repository Structure

- `async_fifo.sv` – RTL of the asynchronous FIFO (Design Under Test).
- `fifo_env.sv` – Testbench environment encapsulating all components.
- `fifo_common.sv` – Common definitions and utilities.
- `fifo_cov.sv` – Coverage collection module.
- `fifo_intrf.sv` – FIFO interface definition.
- `fifo_mon.sv` – Monitor for observing FIFO transactions.
- `fifo_sbd.sv` – Scoreboard for checking FIFO correctness.
- `fifo_tx.sv` – FIFO transaction (sequence item).
- `rd_agent.sv`, `rd_drv.sv`, `rd_sqr.sv` – Read agent, driver, and sequencer.
- `wr_agent.sv`, `wr_drv.sv`, `wr_sqr.sv` – Write agent, driver, and sequencer.
- `seq_lib.sv` – Library of test sequences and stimulus generators.
- `test_lib.sv` – Test class library for different scenarios.
- `top.sv` – Top-level testbench module.
- `run.do` – Simulation script for automated runs (for ModelSim/Questa).
- `1.vcd` – Example waveform dump from simulation.
- `.gitattributes` – Git attributes for repository configuration.
- `tr_db.log` – Example log file from simulation.

## Getting Started

### Prerequisites

- SystemVerilog simulator (e.g., ModelSim, Questa, VCS)
- UVM library (Universal Verification Methodology)

### How to Run

1. Clone the repository:
   ```
   git clone https://github.com/Aditya-kori/Asynchronous-FIFO-Pre.git
   cd Asynchronous-FIFO-Pre
   ```
2. Compile all `.sv` and `.v` files with your simulator, including the UVM library.
3. Use `run.do` if you are running with ModelSim/Questa, or set up your simulator accordingly.
4. Launch the simulation and review results in the waveform (`.vcd`) and log (`tr_db.log`) files.

## Customization

- Add or modify sequences in `seq_lib.sv` for new stimulus.
- Update `fifo_cov.sv` for additional coverage metrics.
- Extend `test_lib.sv` for more advanced test scenarios.

## License

This project does not currently contain a license file. For usage or contributions, please contact the repository owner.

## Author

- [Aditya-kori](https://github.com/Aditya-kori)

---

Contributions and issues are welcome!
