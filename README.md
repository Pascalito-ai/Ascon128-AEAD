# ASCON-128 AEAD in SystemVerilog

## Description
This project implements the **ASCON-128 AEAD (Authenticated Encryption with Associated Data)** algorithm in **SystemVerilog**.  
ASCON is a lightweight cipher and was selected by **NIST as the standard for lightweight AEAD and hashing (2023)**.  
The goal of this project is to provide an efficient hardware implementation suitable for FPGA/ASIC integration.

## Features
- Full implementation of **ASCON-128 AEAD**.
- Encryption authenticated data.
- Modular and well-structured SystemVerilog code.
- Testbench included with official test vectors.



## Usage

### Simulation
1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/ascon128-aead-sv.git
   cd ascon128-aead-sv
Compile and run with Icarus Verilog (or another SystemVerilog simulator):

bash
iverilog -g2012 -o ascon_tb tb/tb_ascon.sv src/*.sv
vvp ascon_tb
Check results in the console or waveform (.vcd).

FPGA Synthesis
The design can be synthesized with tools like Xilinx Vivado or Intel Quartus.
Refer to the docs/ folder for example scripts.

Parameters
Key size: 128 bits

Nonce: 128 bits

Tag size: 128 bits

References
ASCON Official Website

NIST Lightweight Cryptography Project

Original ASCON Paper (2015)

Author
Mickaël GARDES

Contact: Mickaa.gardes@gmail.com

License
This project is released under the MIT License.

