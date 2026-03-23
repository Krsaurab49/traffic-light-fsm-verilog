# 4-Way Traffic Light Controller — FSM Design

## Overview
A parameterised synchronous Mealy/Moore hybrid FSM 
managing four-intersection traffic phases. Implemented 
and validated on Xilinx Artix-7 (Basys 3).

## Key Results
- FSM Type: Synchronous Mealy/Moore Hybrid
- Clock Divider: 100 MHz scaled to ~1 Hz for LED output
- Zero glitch conditions — verified via ModelSim
- All state transitions synchronous and registered
- Validated against timing spec with zero deviations

## Tools Used
- Language: Verilog HDL
- Simulation: ModelSim
- Synthesis: Xilinx Vivado
- Board: Basys 3 (Artix-7)

## Design Flow
Architecture Spec → FSM Design → ModelSim Simulation
→ Vivado Synthesis → Bitstream → Basys 3 Validation

## Contact
Kumar Saurab
krsaurab62@gmail.com
linkedin.com/in/kumarsaurab49
