<body>
  <h1>RTL-to-GDSII Implementation and FPGA Prototyping of a Dual-Clock Traffic-Pedestrian Controller</h1>

  <p>
    This project implements a traffic light controller and a pedestrian walk controller that run on two different clocks.
    The work covered RTL design, cross-domain synchronization, verification, and the full ASIC flow to a final GDSII.
    The same RTL was also tested on a Basys-3 FPGA to validate behavior in real hardware.
  </p>

  <div class="section">
    <h2>1. Project summary</h2>
    <p>There are two parts in the design:</p>
    <ul>
      <li>
        <strong>Traffic controller</strong> - runs on <code>clk_main</code> and generates a sequence: Green → Yellow → Red.
      </li>
      <li>
        <strong>Pedestrian controller</strong> - runs on <code>clk_ped</code>, reads a button press and produces a <em>walk</em> signal only when traffic is Red.
      </li>
    </ul>
    <p class="muted">
      Because the two clocks are unrelated, signals crossing between domains must be synchronized.
      The design uses a toggle-based handshake (<code>req → grant → ack</code>) with 2-flip-flop synchronizers in both directions.
      That prevents lost requests and ensures the traffic domain only grants walk when safe.
    </p>
  </div>

  <div class="section">
    <h2>2. How the design works</h2>
    <h3>Traffic FSM (main clock domain)</h3>
    <ul>
      <li>Cycles Green → Yellow → Red.</li>
      <li>If a pedestrian request is granted, the traffic FSM stays in Red until the pedestrian acknowledges.</li>
    </ul>
    <h3>Pedestrian FSM (ped clock domain)</h3>
    <ul>
      <li>Detects button press and toggles a request bit.</li>
      <li>When a synchronized grant arrives, it generates a one-cycle <code>walk</code> pulse.</li>
      <li>It then toggles an acknowledge bit back to the traffic domain.</li>
    </ul>
    <p class="muted">
      Because all communication is via toggles and 2-FF synchronizers, the system avoids metastability and missed events.
    </p>
  </div>

  <div class="section">
    <h2>3. FPGA prototyping (Basys-3)</h2>
    <p>
      After simulation, the RTL was ported to a Basys-3 board using Vivado. LEDs were used for traffic lights and the walk signal;
      the onboard button was used for pedestrian requests. The hardware behavior matched simulation, confirming the CDC logic and FSMs are stable in real hardware.
    </p>
  </div>

  <div class="section">
    <h2>4. ASIC flow (RTL → GDSII)</h2>
    <p>After functional verification, the full ASIC flow was executed using Cadence tools. Key tools used:</p>
    <ul>
      <li>Simulation: Incisive</li>
      <li>Lint + CDC/RDC: JasperGold</li>
      <li>Synthesis: Genus</li>
      <li>Logic Equivalence Check: Conformal</li>
      <li>Gate-Level Simulation: Xcelium</li>
      <li>Floorplan / Placement / CTS / Routing: Innovus</li>
      <li>GDSII Viewing: Virtuoso</li>
    </ul>
    <p class="muted">Each PD step was driven by TCL scripts. The final output is a clean layout and a generated GDSII file.</p>
  </div>

  <div class="section">
    <h2>5. Repository structure</h2>
    <pre>
1_src/                              → Verilog source
2_tb/                               → Verilog testbench
3_sim/                              → simulation scripts and waveforms
4_superlint/                        → linting violations and fixed rtl
5_cdc_rdc/                          → CDC / RDC
6_xrop/                             → XPROP
7_synthesis/                        → Genus script, reports, netlist, sdc, sdf files
8_post_synthesis_LEC/               → Conformal LEC results
9_post_synthesis_GLS/               → gate-level simulation results and scripts
10_floorplanning/                   → Imported Design and layout screenshots
11_powerplanning/                   → Innovus TCL scripts, layout screenshots
12_placement/                       → Innovus TCL scripts, layout screenshots
13_clock_tree_synthesis/            → Innovus TCL scripts, layout screenshots
14_routing/                         → Innovus TCL scripts, layout screenshots
15_signoff/                         → Innovus TCL scripts, final GDSII files
16_import_to_virtuoso/              → Layout screenshots in Virtuoso
17_fpga/                            → FPGA RTL, XDC constraints
    </pre>
  </div>

  <div class="section">
    <h2>6. Tools used</h2>
    <ul>
      <li>Cadence Incisive</li>
      <li>Cadence JasperGold</li>
      <li>Cadence Genus</li>
      <li>Cadence Conformal</li>
      <li>Cadence Innovus</li>
      <li>Cadence Virtuoso</li>
      <li>Cadnece Xcelium</li>
      <li>Xilinx Vivado (Basys-3 FPGA)</li>
    </ul>
  </div>

  <div class="section">
    <h2>7. What this project demonstrates</h2>
    <ul>
      <li>Multi-clock RTL design</li>
      <li>CDC-safe communication using a toggle handshake</li>
      <li>Practical FSM design and verification</li>
      <li>FPGA bring-up and real hardware validation</li>
      <li>Complete ASIC backend flow up to GDSII</li>
    </ul>
    <p class="muted">This work helped me understand the entire path from RTL to hardware, both for FPGA and ASIC targets.</p>
  </div>

</body>
</html>
