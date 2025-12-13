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
      <b> <li>Simulation: Incisive</li> </b> <br>
      <img height="150" alt="Screenshot from 2025-10-07 16-47-42" src="https://github.com/user-attachments/assets/316722fe-6357-46ae-92d9-f82b166e2c46" />
      <img height="150" alt="Screenshot from 2025-10-07 16-47-26" src="https://github.com/user-attachments/assets/2ae22b10-7404-4b0d-a70b-43cb18f6b41e" />
      <img height="150" alt="Screenshot from 2025-10-07 16-46-50" src="https://github.com/user-attachments/assets/d4bfb231-7676-49fe-ac10-02bb6cda4199" />
      <img height="150" alt="Screenshot from 2025-10-07 16-46-25" src="https://github.com/user-attachments/assets/9fd9d0e0-2350-47a9-b7cb-b1e02a6d43f4" />
      <img height="150" alt="Screenshot from 2025-10-07 16-41-37" src="https://github.com/user-attachments/assets/606ce04c-2af9-435d-b7b7-080aa2825127" />
      <b> <li>Lint: JasperGold</li> </b> <br>
      <img height="150" alt="violation_list_fixed" src="https://github.com/user-attachments/assets/ef0a1ded-cc46-4ffb-ab2c-a2c78d21d638" />
      <b> <li>CDC/RDC: JasperGold</li> </b> <br>
      <b> <li>Xprop : JasperGold</li> </b> <br>
      <img height="131" alt="op" src="https://github.com/user-attachments/assets/f41899d5-fadf-452f-9e4d-2329f9388534" />
      <b> <li>Synthesis: Genus</li> </b> <br>
      <img width="1667" height="574" alt="op" src="https://github.com/user-attachments/assets/28940c2a-ecc4-499b-b85c-62055f6a40bd" />
      <b> <li>Logic Equivalence Check: Conformal</li> </b> <br>
      <img width="1100" height="303" alt="op" src="https://github.com/user-attachments/assets/941fc604-4464-46a0-a94e-c83018d215f6" />
      <b> <li>Gate-Level Simulation: Xcelium</li> </b> <br>
        <b>&emsp; Zero Delay Simulation </b> 
        <p> <br> </p>
        <img width="958" height="219" alt="op_4" src="https://github.com/user-attachments/assets/a9b73838-ef39-473d-a749-e406a3341bc2" />
        <img width="961" height="215" alt="op_3" src="https://github.com/user-attachments/assets/a23229b0-b633-4fe3-aea8-47cd8bf817d8" />
        <img width="963" height="222" alt="op_2" src="https://github.com/user-attachments/assets/b149014a-1d0a-4362-8034-2f0a48ee6e34" />
        <img width="961" height="212" alt="op_1" src="https://github.com/user-attachments/assets/7e50f37a-ea37-4c18-9300-70c764159f35" />
      <p> <br> </p>
        <b>&emsp; Unit Delay Simulation</b>
      <p> <br> </p>
        <img width="969" height="228" alt="op_3" src="https://github.com/user-attachments/assets/02817c4f-8e2c-406c-9315-53817850ef99" />
        <img width="955" height="234" alt="op_2" src="https://github.com/user-attachments/assets/c5fa8ae2-8936-4a3d-8af8-00fc869ee65e" />
        <img width="962" height="215" alt="op_1" src="https://github.com/user-attachments/assets/5c042e8e-1f88-45f3-83ad-c235067da5cd" />
      <p> <br> </p>
        <b>&emsp; SDF Simulation</b>
      <p> <br> </p>
        <img width="1871" height="287" alt="op_1" src="https://github.com/user-attachments/assets/405799e9-d216-4a1b-b636-67e44e646f6f" />
        <img width="1872" height="245" alt="op_3" src="https://github.com/user-attachments/assets/65542b0b-f1f8-4fee-9996-f8bae942c72a" />
        <img width="1875" height="307" alt="op_2" src="https://github.com/user-attachments/assets/971fcb12-32f1-4482-b9c7-c5e0d8608f4d" />
      <p> <br> </p>
      <b> <li>Floorplan: Innovus</li> </b> <br>
      <img height="650" alt="after filler and gap" src="https://github.com/user-attachments/assets/2fb11bd3-6037-46d6-97c1-30d9bfcdec15" />
      <b> <li>Powerplanning: Innovus</li> </b> <br>
      <img height="650" alt="op" src="https://github.com/user-attachments/assets/2a2b5ce6-93b5-4ccb-9a83-3e339ee44713" />
      <b> <li>Placement: Innovus</li> </b> <br>
      <img height="650" alt="op_1" src="https://github.com/user-attachments/assets/40ce75e1-c747-4425-bb71-ebc357bb174d" />
      <b> <li>CTS: Innovus</li> </b> <br>
      </ul><img height="650" alt="op_1" src="https://github.com/user-attachments/assets/16d6c1b7-d233-4c60-aded-a4fe1c13446e" />
      <b> <li>Routing: Innovus</li> </b> <br>
      <img height="650" alt="op_1" src="https://github.com/user-attachments/assets/4ac0c134-a737-48c3-90ee-6340310a0e2c" />
      <b> <li>GDSII Importing: Virtuoso</li> </b> <br>
      <img height="650" alt="Screenshot from 2025-12-11 15-36-45" src="https://github.com/user-attachments/assets/00628faa-e582-4b57-ad53-c554c785a651" />
      <img height="650" alt="Screenshot from 2025-12-11 15-36-57" src="https://github.com/user-attachments/assets/17220688-0853-4dd6-9b1e-15d72f5f231a" />
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
