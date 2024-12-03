within PowerGridsMC.Examples;
package PFT
  extends Modelica.Icons.ExamplesPackage;

  package BasicGrid
    model PowerFlow "Usa ModifiedPG PVBus"
      extends Modelica.Icons.Example;
      PowerGridsMC.Electrical.Buses.Bus NTLV(SNom = 5e+8, UNom = 21e3,
         portVariablesPhases = true, portVariablesPu = true)  annotation (
        Placement(visible = true, transformation(origin={-30,-10},  extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio TGEN( R = 0.15e-2 * 419 ^ 2 / 500,
        SNom=500e6,
        UNomA=21e3,
        UNomB=419e3,
        X = 16e-2 * 419 ^ 2 / 500,
        portVariablesPhases = true,
        showPortData=true,  portVariablesPu = true, rFixed = 419 / 21)  annotation (
        Placement(visible = true, transformation(origin={0,-10},  extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Buses.Bus NTHV(SNom = 5e+8, UNom = 380e3,
         portVariablesPhases = true, portVariablesPu = true)  annotation (
        Placement(visible = true, transformation(origin={30,-10},  extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      inner PowerGridsMC.Electrical.System systemPowerGrids annotation (
        Placement(visible = true, transformation(origin={40,28},     extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.PowerFlow.PQBusW GRIDL(
        P=475000000,
        Q=76000000,
        SNom=500000000,
        UNom=380000,
        portVariablesPhases=true,
        portVariablesPu=true) annotation (Placement(visible=true,
            transformation(
            origin={60,-24},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      PowerGridsMC.Electrical.PowerFlow.SlackBusW GRID(
        SNom=500000000,
        U=398000,
        UNom=380000,
        portVariablesPhases=true,
        portVariablesPu=true) annotation (Placement(visible=true,
            transformation(
            origin={54,2},
            extent={{-10,-10},{10,10}},
            rotation=-90)));
      PowerGridsMC.Electrical.PowerFlow.PVBusW GEN(
        UNom=21000,
        SNom=500000000,
        P=-475000000,
        U=20825.8) annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=0,
            origin={-46,18})));
    equation
      connect(NTLV.terminal, TGEN.terminalA) annotation (
        Line(points={{-30,-10},{-10,-10}}));
      connect(TGEN.terminalB, NTHV.terminal) annotation (
        Line(points={{10,-10},{30,-10}}));
      connect(NTHV.terminal, GRID.terminal)
        annotation (Line(points={{30,-10},{38,-10},{38,2},{54,2}}));
      connect(GRIDL.terminal, NTHV.terminal)
        annotation (Line(points={{60,-24},{38,-24},{38,-10},{30,-10}}));
      connect(GEN.terminal, NTLV.terminal) annotation (Line(points={{-46,18},{-46,
              -10},{-30,-10}}, color={0,0,0}));
      annotation (
        Icon(coordinateSystem( extent={{-100,-100},{100,100}})),
        Diagram(coordinateSystem(extent={{-60,-40},{80,40}}),
            graphics={Text(
              extent={{-26,24},{-6,16}},
              lineColor={238,46,47},
              textString="Scrive dati:
U, UPhase, P, Q,
UPu, PPu,QPu"),   Text(
              extent={{-32,-24},{32,-30}},
              lineColor={238,46,47},
              textString="File scambio dati: 
\"instance\".mat")}),
        experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-6, Interval = 0.002),
        __OpenModelica_commandLineOptions = "--daeMode --tearingMethod=minimalTearing",
        __OpenModelica_simulationFlags(nls="kinsol", lv="LOG_INIT_HOMOTOPY", homotopyOnFirstTry="()"),
        Documentation(info="<html>
<p>Library PowerGridsMC was forked from https://github.com/PowerGrids/PowerGrids on 22 November 2024.</p>
<p>Folder PFT was not present in the original PowerGrids library</p>
<p>************************** </p>
<p>PowerFlow contains a Basic grid twhere we can perform PowerFlow studied.</p>
<p>The most relevant PowerFlow data can be read directly on the model&apos;s diagram, while all the other data are available from the full list of the modelica ouput. It contains special models for the PQ,m PV, Slack components, which save the PF ouput on disk, for future reuse. These are characterided by a red &quot;W&quot; (for write) on their icons. and are: SlackBusW, PQBusW, PVBusW.</p>
</html>"));
    end PowerFlow;

    model LoadChangeUnreg "System operating in steady-state with given inputs"
      extends Modelica.Icons.Example;
      inner PowerGridsMC.Electrical.System systemPowerGrids annotation (
        Placement(visible = true, transformation(origin={30,30},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Machines.SynchronousMachine4WindingsR GEN(
        H=4,
        SNom=500000000,
        Tpd0=5.143,
        Tppd0=0.042,
        Tppq0=0.083,
        Tpq0=2.16,
        UNom=21000,
        portVariablesPhases=true,
        raPu=0,
        xdPu=2,
        xlPu=0.15,
        xpdPu=0.35,
        xppdPu=0.25,
        xppqPu=0.3,
        xpqPu=0.5,
        xqPu=1.8) annotation (Placement(visible=true, transformation(
            origin={-32,0},
            extent={{-10,10},{10,-10}},
            rotation=0)));
      PowerGridsMC.Electrical.Buses.Bus NTLV(SNom = 5e+08, UNom = 21000, portVariablesPhases = true, portVariablesPu = true)  annotation (
        Placement(visible = true, transformation(origin={-6,-18},   extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      PowerGridsMC.Electrical.Buses.Bus NTHV(SNom = 5e+08, UNom = 380000, portVariablesPhases = true, portVariablesPu = true)  annotation (
        Placement(visible = true, transformation(origin={30,-18},    extent = {{-10, 10}, {10, -10}}, rotation = 90)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio TGEN( R = 0.15e-2 * 419 ^ 2 / 500,
        SNom=500000000,
        UNomA=21000,
        UNomB=419000,                                                                                                                      X = 16e-2 * 419 ^ 2 / 500, portVariablesPhases = true,
        showPFdata=true,                                                                                                                                                                          portVariablesPu = true, rFixed = 419 / 21)  annotation (
        Placement(visible = true, transformation(origin={12,-18},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Buses.EquivalentGridR GRID(
        R_X=1/10,
        SNom=500000000,
        SSC=2500000000,
        UNom=380000,
        c=1.1,
        portVariablesPhases=true,
        portVariablesPu=true) annotation (Placement(visible=true,
            transformation(
            origin={56,-8},
            extent={{-10,-10},{10,10}},
            rotation=0)));

      PowerGridsMC.Electrical.Loads.LoadPQVoltageDependenceR GRIDL(
        alpha=2,
        beta=2,
        SNom=500000000,
        UNom=380000,
        portVariablesPhases=true) annotation (Placement(visible=true,
            transformation(
            origin={66,-30},
            extent={{-10,-10},{10,10}},
            rotation=0)));
    //    URef=GRIDL_.y[1, 1],              port.U
    //    UStart=GRIDL_.y[1, 1],            port.U
    //    UPhaseStart=GRIDL_.y[1, 2],       port.UPhase
    //    PStart=GRIDL_.y[1, 3],            port.P
    //    PRefConst=GRIDL_.y[1, 3],         port.P
    //    QStart=GRIDL_.y[1, 4],            port.Q
    //    QRefConst=GRIDL_.y[1, 4],         port.Q
    //    y[1,5]=port.VPu;
    //    y[1,6]=port.PPu;
    //    y[1,7]=port.QPu;

      Modelica.Blocks.Sources.RealExpression PmPu(y=-GEN.PFout[1, 6])
        annotation (Placement(visible=true, transformation(
            origin={-64,-10},
            extent={{-10,-10},{10,10}},
            rotation=0)));
      Modelica.Blocks.Sources.RealExpression ufPuIn(y=GEN.ufPuInStart)
        annotation (Placement(visible=true, transformation(
            origin={-66,4},
            extent={{-10,-10},{10,10}},
            rotation=0)));
      PowerGridsMC.Electrical.Loads.LoadPQVoltageDependenceInputs Grid2(
        UNom=380000,
        SNom=500000000,
        alpha=2,
        beta=2)
        annotation (Placement(transformation(extent={{34,-46},{54,-26}})));
      Modelica.Blocks.Sources.Step stepQ(height=76e6, startTime=1)
        annotation (Placement(transformation(extent={{-2,-52},{6,-44}})));
      Modelica.Blocks.Sources.Step stepP(height=500e6, startTime=1)
        annotation (Placement(transformation(extent={{10,-44},{18,-36}})));
    equation
      connect(PmPu.y, GEN.PmPu) annotation (Line(points={{-53,-10},{-48,-10},{-48,
              -3.4},{-42.4,-3.4}}, color={0,0,127}));
      connect(ufPuIn.y, GEN.ufPuIn)
        annotation (Line(points={{-55,4},{-42.4,4}}, color={0,0,127}));
      connect(GRIDL.terminal, NTHV.terminal)
        annotation (Line(points={{66,-30},{66,-18},{30,-18}}));
      connect(GEN.terminal, NTLV.terminal)
        annotation (Line(points={{-32,0},{-32,-18},{-6,-18}}));
      connect(NTLV.terminal, TGEN.terminalA) annotation (
        Line(points={{-6,-18},{2,-18}}));
      connect(TGEN.terminalB, NTHV.terminal) annotation (
        Line(points={{22,-18},{30,-18}}));
      connect(NTHV.terminal, GRID.terminal)
        annotation (Line(points={{30,-18},{56,-18},{56,-8}}));
      connect(Grid2.terminal, NTHV.terminal)
        annotation (Line(points={{44,-36},{44,-18},{30,-18}}, color={0,0,0}));
      connect(Grid2.QRefIn, stepQ.y) annotation (Line(points={{34,-46},{30,-46},
              {30,-48},{6.4,-48}}, color={0,0,127}));
      connect(stepP.y, Grid2.PRefIn)
        annotation (Line(points={{18.4,-40},{34,-40}}, color={0,0,127}));
      annotation (
        Icon(coordinateSystem(grid={2,2}, extent={{-100,-100},{100,100}})),
        Diagram(coordinateSystem(                   extent={{-80,-60},{80,40}}),
            graphics={Text(
              extent={{-10,20},{10,12}},
              lineColor={238,46,47},
              textString="Legge dati:
U, UPhase, P, Q,
UPu, PPu,QPu"),       Text(
              extent={{46,10},{66,2}},
              lineColor={0,0,0},
              textString="Calcola i parametri in modo che
con URef genera PStart, QStart")}),
        experiment(
          StopTime=15,
          Interval=0.004,
          Tolerance=1e-06,
          __Dymola_Algorithm="Dassl"),
        __OpenModelica_commandLineOptions = "--daeMode --tearingMethod=minimalTearing",
        __OpenModelica_simulationFlags(nls="kinsol", lv="LOG_INIT_HOMOTOPY", homotopyOnFirstTry="()"),
        Documentation(info="<html>
<p>Library PowerGridsMC was forked from https://github.com/PowerGrids/PowerGrids on 22 November 2024.</p>
<p>Folder PFT was not present in the original PowerGrids library</p>
<p>************************** </p>
<p>LoadChangeUnreg a transient on the BasicGrid considered in the Basicgrid folder, starting from the initial operating point as computed runnint PowerFlow model. In the first part of the transient, all the data are exactly the same as the power flow output this can be easily checked looking at the on-diagram numerical outputs, stopping the simulation bbefore the load change takes place, i.e. before t=1s, e.g. at t=0.5s. then, the load change occurs at t=1s.</p>
<p>This model shows the usage of the following new components, not existing in the original Powergirds library: </p>
<p>LoadPQVoltageDependenceR, SynchronousMachine4WindingR, EquivalentGridR</p>
</html>"));
    end LoadChangeUnreg;

    model LoadChangeReg "Regulated verion"
       extends Modelica.Icons.Example;
    /*  The following variables are taken from disk inside GEN_:  
    UStart=GEN_.y[1, 1],
    UPhaseStart=GEN_.y[1, 2],
    PStart=GEN_.y[1, 3],
    QStart=GEN_.y[1, 4],
*/

      PowerGridsMC.Examples.IEEE14bus.ControlledGenNoPSS_R GEN(GEN(
          H=4,
          SNom=500000000,
          Tpd0=5.143,
          Tppd0=0.042,
          Tppq0=0.083,
          Tpq0=2.16,
          UNom=21000,
          portVariablesPhases=true,
          raPu=0,
          xdPu=2,
          xlPu=0.15,
          xpdPu=0.35,
          xppdPu=0.25,
          xppqPu=0.3,
          xpqPu=0.5,
          xqPu=1.8))
        annotation (Placement(transformation(extent={{-48,0},{-28,20}})));
      PowerGridsMC.Electrical.Buses.Bus NTLV(
        SNom=5e+08,
        UNom=21000,
        portVariablesPhases=true,
        portVariablesPu=true)  annotation (
        Placement(visible = true, transformation(origin={-18,10},   extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      PowerGridsMC.Electrical.Buses.Bus NTHV(
        SNom=5e+08,
        UNom=380000,
        portVariablesPhases=true,
        portVariablesPu=true)   annotation (
        Placement(visible = true, transformation(origin={20,10},     extent={{-10,-10},
                {10,10}},                                                                             rotation = 90)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio TGEN(
        R=0.15e-2*419^2/500,
        SNom=500000000,
        UNomA=21000,
        UNomB=419000,
        X=16e-2*419^2/500,
        portVariablesPhases=true,
        showPortData=true,
        portVariablesPu=true,
        rFixed=419/21)   annotation (
        Placement(visible = true, transformation(origin={0,10},      extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Buses.EquivalentGridR GRID(
        R_X=1/10,
        SNom=500000000,
        SSC=2500000000,
        UNom=380000,
        c=1.1,
        portVariablesPhases=true,
        portVariablesPu=true) annotation (Placement(visible=true,
            transformation(
            origin={38,20},
            extent={{-10,-10},{10,10}},
            rotation=0)));
      PowerGridsMC.Electrical.Loads.LoadPQVoltageDependenceR GRIDL(
        alpha=2,
        beta=2,
        SNom=500000000,
        UNom=380000,
        portVariablesPhases=true) annotation (Placement(visible=true,
            transformation(
            origin={50,-6},
            extent={{-10,-10},{10,10}},
            rotation=0)));
      PowerGridsMC.Electrical.Loads.LoadPQVoltageDependenceInputs Grid2(
        UNom=380000,
        SNom=500000000,
        alpha=2,
        beta=2)
        annotation (Placement(transformation(extent={{20,-22},{40,-2}})));
      Modelica.Blocks.Sources.Step stepQ(height=76e6, startTime=1)
        annotation (Placement(transformation(extent={{-16,-28},{-8,-20}})));
      Modelica.Blocks.Sources.Step stepP(height=500e6, startTime=1)
        annotation (Placement(transformation(extent={{-4,-20},{4,-12}})));
    equation
      connect(GRIDL.terminal, NTHV.terminal)
        annotation (Line(points={{50,-6},{50,10},{20,10}}));
      connect(GEN.terminal, NTLV.terminal)
        annotation (Line(points={{-38,10},{-18,10}}));
      connect(NTLV.terminal,TGEN. terminalA) annotation (
        Line(points={{-18,10},{-10,10}}));
      connect(TGEN.terminalB,NTHV. terminal) annotation (
        Line(points={{10,10},{20,10}}));
      connect(NTHV.terminal, GRID.terminal)
        annotation (Line(points={{20,10},{38,10},{38,20}}));
      connect(Grid2.QRefIn,stepQ. y) annotation (Line(points={{20,-22},{16,-22},
              {16,-24},{-7.6,-24}},color={0,0,127}));
      connect(stepP.y,Grid2. PRefIn)
        annotation (Line(points={{4.4,-16},{20,-16}},  color={0,0,127}));
      connect(Grid2.terminal, NTHV.terminal)
        annotation (Line(points={{30,-12},{30,10},{20,10}}, color={0,0,0}));
      annotation (experiment(
          StopTime=15,
          Interval=0.004,
          Tolerance=1e-06,
          __Dymola_Algorithm="Dassl"), Documentation(info="<html>
<p>Library PowerGridsMC was forked from https://github.com/PowerGrids/PowerGrids on 22 November 2024.</p>
<p>Folder PFT was not present in the original PowerGrids library</p>
<p>************************** </p>
<p>LoadChangeReg contains the same transient as LoadChangeUnreg, but here the generator contains power and excitation regulators.</p>
<p>This model shows the usage of the following new components, not existing in the original Powergirds library: </p>
<p>LoadPQVoltageDependenceR, SynchronousMachine4WindingR, EquivalentGridR, ControlledGeneratorR.</p>
</html>"),
        Diagram(coordinateSystem(extent={{-60,-40},{60,40}})));
    end LoadChangeReg;
    annotation (Documentation(info="<html>
<p><i><span style=\"font-family: Arial; font-size: 12pt;\">Library PowerGridsMC was forked from https://github.com/PowerGrids/PowerGrids on 22 November 2024.</span></i></p>
<p><i><span style=\"font-size: 12pt;\">Folder PFT was not present in the original PowerGrids library</span></i></p>
<p>************************** </p>
<p>PFT.BasicGrid folder contains a first simple example of the usage of the PowerFlow-&gt;Transient (i.e. PFT) simulation chain:</p>
<ul>
<li>PowerFlow, which is the Power Flow bcase which constitutes the base of all the other models in the folder, which contain transients</li>
<li>LoadChangeUnreg, contains a transient in qhich a generator hreceives constant input power and excitation voltage. In the first part of the transient, all the data are exactly the same as the power flow output this can be easily checked looking at the on-diagram numerical outputs, stopping the simulation before the load change takes place, i.e. before t=1s, e.g. at t=0.5s. then, the load change occurs at t=1s,</li>
<li>LoadChangeReg, containing the same transient as for the previous bullet, but here the generator contains power and excitation regulators.</li>
</ul>
</html>"));
  end BasicGrid;

  record Line
    parameter Real Rd = 0.05732 / 1000 "Direct-circuit Resistance per unit length";
    parameter Real Xd = 0.4005 / 1000 "DIrect-circuit Reactance per unit length";
    parameter Real R0 = 0.2054 / 1000 "0-Circuit Resistance per unit length";
    parameter Real X0 = 1.405 / 1000 "0-Circuit Reactance per unit length";
    parameter Real Yd = 2.8257e-6 / 1000 "Direct-Circuit Admittance per unit length";
    parameter Real Y0 = 1.6306e-6 / 1000 "0-Circuit Admittance per unit length";
    annotation (
      Icon(coordinateSystem(extent = {{-100, -130}, {100, 100}})));
  end Line;

  package FourATbus "Network with four AT buses"
    model PowerFlowSI
      "Modello Paris SI con tensioni ai morsetti delle macchine unitarie"
        extends Modelica.Icons.Example;
      PowerGridsMC.Electrical.PowerFlow.SlackBusW gen42x2(
        SNom(displayUnit="MVA") = 100000000,
        U(displayUnit="kV") = 15700,
        UNom(displayUnit="kV") = 15700) annotation (Placement(visible=true,
            transformation(
            origin={56,-70},
            extent={{-10,10},{10,-10}},
            rotation=90)));
      PowerGridsMC.Electrical.PowerFlow.PVBusW gen33x2(
        P(displayUnit="MW") = -100000000,
        SNom(displayUnit="MVA") = 120000000,
        U(displayUnit="kV") = 13800,
        UNom(displayUnit="kV") = 13800,
        portVariablesPhases=true) annotation (Placement(visible=true,
            transformation(
            origin={-96,58},
            extent={{-10,10},{10,-10}},
            rotation=0)));
      PowerGridsMC.Electrical.PowerFlow.PQBusW pq31(
        P(displayUnit="MW") = 200000000,
        Q(displayUnit="MVA") = 100000000,
        SNom(displayUnit="MVA") = 100000000,
        UNom(displayUnit="kV") = 129000) annotation (Placement(visible=true,
            transformation(
            origin={-100,-42},
            extent={{-10,-10},{10,10}},
            rotation=0)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio T4_iX2(
           SNom(displayUnit = "MW") = 190e6 * 2,
           UNomA(displayUnit = "kV") = 236100,
           UNomB(displayUnit = "kV") = 236100,
           X = 0.04828 * 220 ^ 2 / 100 / 2) annotation (
        Placement(visible = true, transformation(origin={0,-54},    extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      PowerGridsMC.Electrical.Branches.LineConstantImpedance L3_2(
            B = 75e3 * line.Yd, R = 75e3 * line.Rd,
            SNom(displayUnit = "MW") = 100000000,
            UNom(displayUnit = "kV") = 220000,
            UNomA(displayUnit = "kV") = 220000,
            UNomB(displayUnit = "kV") = 220000,
            X = 75e3 * line.Xd,
            showPortData = true) annotation (
        Placement(visible = true, transformation(origin={-22,10},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.PowerFlow.PVBusW gen11x2(
            P(displayUnit="MW") = -200000000,
            SNom(displayUnit="MVA") = 200000000,
            U(displayUnit="kV") = 13800,
            UNom(displayUnit="kV") = 13800,
            portVariablesPhases=true) annotation (Placement(visible=true,
            transformation(
            origin={0,108},
            extent={{-10,10},{10,-10}},
            rotation=0)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio T1_11_2(
            R = 377 / 110e3 * 240 ^ 2 / 110,
            SNom(displayUnit = "MW") = 110000000,
            UNomA(displayUnit = "kV") = 13800,
            UNomB(displayUnit = "kV") = 240000,
            X = 0.0999 * 240 ^ 2 / 110,
            rFixed = 240 / 13.8) annotation (
        Placement(visible = true, transformation(origin={10,72},    extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      PowerGridsMC.Electrical.Branches.LineConstantImpedance L2_1(
            B = 200e3 * line.Yd, R = 200e3 * line.Rd,
            SNom(displayUnit = "MW") = 100000000,
            UNom(displayUnit = "kV") = 220000,
            UNomA(displayUnit = "kV") = 220000,
            UNomB(displayUnit = "kV") = 220000, X = 200e3 * line.Xd,
            showPortData=true)                                                                                                                                                                                                         annotation (
        Placement(visible = true, transformation(origin={0,28},    extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      PowerGridsMC.Electrical.Branches.LineConstantImpedance L4_2(
            B = 90e3 * line.Yd, R = 90e3 * line.Rd,
            SNom(displayUnit = "MW") = 100000000,
            UNom(displayUnit = "V") = 1,
            UNomA(displayUnit = "kV") = 220000,
            UNomB(displayUnit = "kV") = 220000,
            X = 90e3 * line.Xd,
            showPortData = true) annotation (
        Placement(visible = true, transformation(origin={0,-8},    extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      PowerGridsMC.Electrical.Branches.LineConstantImpedance L3_4(
            B = 50e3 * line.Yd, R = 50e3 * line.Rd,
            SNom(displayUnit = "MW") = 100000000,
            UNom(displayUnit = "kV") = 220000,
            UNomA(displayUnit = "kV") = 220000,
            UNomB(displayUnit = "kV") = 220000, X = 50e3 * line.Xd,
            showPortData=true)                                                                                                                                                                                                         annotation (
        Placement(visible = true, transformation(origin={-22,-24},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio T41_iX2(
            SNom(displayUnit = "MW") = 190e6 * 2,
            UNomA(displayUnit = "kV") = 236100,
            UNomB(displayUnit = "kV") = 127900,
            X = 0.02476 * 119 ^ 2 / 100 / 2,
            rFixed = 127.9 / 236.1) annotation (
        Placement(visible = true, transformation(origin={0,-80},    extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio T31_33_1(
            R = 273 / 75e3 * 132 ^ 2 / 75,
            SNom(displayUnit = "MW") = 75000000,
            UNomA(displayUnit = "kV") = 13800,
            UNomB(displayUnit = "kV") = 132000,
            X = 0.0965 * 132 ^ 2 / 75, rFixed = 132 / 13.8,
            showPortData = true) annotation (
        Placement(visible = true, transformation(origin={-106,12},    extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio T2_i(SNom(displayUnit = "MW") = 125000000, UNomA(displayUnit = "kV") = 230000, UNomB(displayUnit = "kV") = 230000, X = 71.884e-3 * 220 ^ 2 / 100) annotation (
        Placement(visible = true, transformation(origin={56,24},    extent = {{10, -10}, {-10, 10}}, rotation = 90)));
      PowerGridsMC.Electrical.PowerFlow.PVBusW sc22(
        P(displayUnit="MW") = 0,
        SNom(displayUnit="MVA") = 39000000,
        U(displayUnit="kV") = 10000,
        UNom(displayUnit="kV") = 10000) annotation (Placement(visible=true,
            transformation(
            origin={106,28},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio T22_i(SNom(displayUnit = "MW") = 39000000, UNomA(displayUnit = "kV") = 230000, UNomB(displayUnit = "kV") = 10500, X = 0.1635 * 10.04 ^ 2 / 100, rFixed = 10.5 / 230, showPortData = true) annotation (
        Placement(visible = true, transformation(origin={74,28},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio T42_iX2(SNom(displayUnit = "MW") = 190e6 * 2, UNomA(displayUnit = "V") = 236.1, UNomB(displayUnit = "V") = 15.75, X = 0.017488 * 14.7 ^ 2 / 100 / 2, rFixed = 15.75 / 236.1, showPortData = true) annotation (
        Placement(visible = true, transformation(origin={30,-70},    extent = {{10, -10}, {-10, 10}}, rotation = 180)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio Teq31_3(R = 0.0948 * 230 ^ 2 / 160 / 30, SNom(displayUnit = "MW") = 160000000, UNomA(displayUnit = "kV") = 135000, UNomB(displayUnit = "kV") = 230000, X = 0.0948 * 230 ^ 2 / 160, rFixed = 230 / 135,
        showPortData=true)                                                                                                                                                                                                         annotation (
        Placement(visible = true, transformation(origin={-70,-12},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.PowerFlow.PQBusW pq41(
        P(displayUnit="MW") = 100000000,
        Q(displayUnit="MVA") = 50000000,
        SNom(displayUnit="MVA") = 100000000,
        UNom(displayUnit="kV") = 119000) annotation (Placement(visible=true,
            transformation(
            origin={0,-98},
            extent={{-10,-10},{10,10}},
            rotation=0)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio Teq2_21(R = 435 / 125e3 * 126.9 ^ 2 / 100, SNom(displayUnit = "MW") = 125000000, UNomA(displayUnit = "kV") = 230000, UNomB(displayUnit = "kV") = 132700, X = 0.0875 * 126.9 ^ 2 / 100, rFixed = 132.7 / 230) annotation (
        Placement(visible = true, transformation(origin={36,32},    extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      PFTdemo.Line line annotation (Placement(visible=true, transformation(
            origin={-60,-68.6957},
            extent={{-9.99999,-11.3043},{9.99999,8.69565}},
            rotation=0)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio T21_i(SNom(displayUnit = "MW") = 125000000, UNomA(displayUnit = "kV") = 230000, UNomB(displayUnit = "kV") = 132700, X = 4.624e-3 * 126.9 ^ 2 / 100, rFixed = 132.7 / 230) annotation (
        Placement(visible = true, transformation(origin={56,50},    extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      PowerGridsMC.Electrical.PowerFlow.PQBusW pq21(
        P(displayUnit="MW") = 200000000,
        Q(displayUnit="MVA") = 100000000,
        SNom(displayUnit="MVA") = 100000000,
        UNom(displayUnit="kV") = 127000) annotation (Placement(visible=true,
            transformation(
            origin={36,82},
            extent={{-10,10},{10,-10}},
            rotation=0)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio T31_33_2(R = 273 / 75e3 * 132 ^ 2 / 75, SNom(displayUnit = "MW") = 75000000, UNomA(displayUnit = "kV") = 13800, UNomB(displayUnit = "kV") = 132000, X = 0.0965 * 132 ^ 2 / 75, rFixed = 132 / 13.8,
        showPortData=true)                                                                                                                                                                                                         annotation (
        Placement(visible = true, transformation(origin={-88,14},    extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio T1_11_1(R = 377 / 110e3 * 240 ^ 2 / 110, SNom(displayUnit = "MW") = 110000000, UNomA(displayUnit = "kV") = 13800, UNomB(displayUnit = "kV") = 240000, X = 0.0999 * 240 ^ 2 / 110, rFixed = 240 / 13.8, showPortData = true) annotation (
        Placement(visible = true, transformation(origin={-10,72},    extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      PowerGridsMC.Electrical.Buses.Bus bus3(
        SNom(displayUnit="V.A") = 100e6,
        UNom(displayUnit="V") = 220e3,
        portVariablesPhases=true,
        portVariablesPu=true)                                                                                                                                        annotation (
        Placement(visible = true, transformation(origin={-47.5,-11.5},    extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      PowerGridsMC.Electrical.Buses.Bus bus33(
        SNom(displayUnit="V.A") = 100e6,
        UNom(displayUnit="V") = 13.8e3,
        portVariablesPhases=true,
        portVariablesPu=true) annotation (Placement(visible=true, transformation(
            origin={-95.5,40.5},
            extent={{-10,-10},{10,10}},
            rotation=0)));
      PowerGridsMC.Electrical.Buses.Bus bus4(
        SNom(displayUnit="V.A") = 100e6,
        UNom(displayUnit="V") = 220e3,
        portVariablesPhases=true,
        portVariablesPu=true)                                                                                                                                        annotation (
        Placement(visible = true, transformation(origin={0.5,-35.5},      extent = {{-10, -10}, {10, 10}}, rotation=0)));
      PowerGridsMC.Electrical.Buses.Bus bus31(
        SNom(displayUnit="V.A") = 100e6,
        UNom(displayUnit="V") = 135e3,
        portVariablesPhases=true,
        portVariablesPu=true) annotation (Placement(visible=true, transformation(
            origin={-99.5,-27.5},
            extent={{-10,-10},{10,10}},
            rotation=0)));
      PowerGridsMC.Electrical.Buses.Bus bus11(UNom(displayUnit="kV") = 13800,
          SNom(displayUnit="MVA") = 100000000)
        annotation (Placement(transformation(extent={{-10,82},{10,102}})));
      PowerGridsMC.Electrical.Buses.Bus bus22(
        SNom(displayUnit="V.A") = 10E6,
        UNom(displayUnit="V") = 10E3,
        portVariablesPhases=true,
        portVariablesPu=true) annotation (Placement(visible=true, transformation(
            origin={92.5,28.5},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      PowerGridsMC.Electrical.Buses.Bus bus1(
        SNom(displayUnit="V.A") = 100e6,
        UNom(displayUnit="V") = 220e3,
        portVariablesPhases=true,
        portVariablesPu=true)                                                                                                                                        annotation (
        Placement(visible = true, transformation(origin={0.5,46.5},       extent = {{-10, -10}, {10, 10}}, rotation=0)));
      PowerGridsMC.Electrical.Buses.Bus bus2(
        SNom(displayUnit="V.A") = 100e6,
        UNom(displayUnit="V") = 220e3,
        portVariablesPhases=true,
        portVariablesPu=true)                                                                                                                                        annotation (
        Placement(visible = true, transformation(origin={20.5,8.5},       extent = {{-10, -10}, {10, 10}}, rotation=90)));
    equation
      connect(L3_2.terminalB, L2_1.terminalB) annotation (
        Line(points={{-12,10},{0,10},{0,18}}));
      connect(L2_1.terminalB, L4_2.terminalA) annotation (
        Line(points={{0,18},{0,2}}));
      connect(L3_4.terminalB, L4_2.terminalB) annotation (
        Line(points={{-12,-24},{0,-24},{0,-18}}));
      connect(T31_33_1.terminalB, Teq31_3.terminalA) annotation (
        Line(points={{-106,2},{-106,-12},{-80,-12}}));
      connect(T31_33_2.terminalB, Teq31_3.terminalA) annotation (
        Line(points={{-88,4},{-88,-12},{-80,-12}}));
      connect(T21_i.terminalA, T2_i.terminalA) annotation (
        Line(points={{56,40},{56,34}}));
      connect(T22_i.terminalA, T2_i.terminalA) annotation (
        Line(points={{64,28},{60,28},{60,34},{56,34}}));
      connect(Teq2_21.terminalA, T2_i.terminalB) annotation (
        Line(points={{36,22},{36,8},{56,8},{56,14}}));
      connect(T21_i.terminalB, Teq2_21.terminalB) annotation (
        Line(points={{56,60},{56,72},{36,72},{36,42}}));
      connect(pq21.terminal, T21_i.terminalB)
        annotation (Line(points={{36,82},{36,72},{56,72},{56,60}}));
      connect(gen42x2.terminal, T42_iX2.terminalB)
        annotation (Line(points={{56,-70},{40,-70}}));
      connect(T42_iX2.terminalA, T41_iX2.terminalA) annotation (
        Line(points={{20,-70},{0,-70}}));
      connect(T41_iX2.terminalA, T4_iX2.terminalA) annotation (
        Line(points={{0,-70},{0,-64}}));
      connect(T41_iX2.terminalB, pq41.terminal)
        annotation (Line(points={{0,-90},{0,-98}}));
      connect(T31_33_2.terminalA, T31_33_1.terminalA) annotation (Line(points={{-88,24},
              {-88,30},{-106,30},{-106,22}},     color={0,0,0}));
      connect(bus3.terminal, Teq31_3.terminalB) annotation (Line(points={{-47.5,
              -11.5},{-54,-11.5},{-54,-12},{-60,-12}}, color={0,0,0}));
      connect(L3_2.terminalA, bus3.terminal) annotation (Line(points={{-32,10},{
              -42,10},{-42,-11.5},{-47.5,-11.5}}, color={0,0,0}));
      connect(L3_4.terminalA, bus3.terminal) annotation (Line(points={{-32,-24},{
              -42,-24},{-42,-12},{-48,-12},{-48,-11.5},{-47.5,-11.5}}, color={0,0,
              0}));
      connect(gen33x2.terminal, bus33.terminal) annotation (Line(points={{-96,58},
              {-95.5,58},{-95.5,40.5}}, color={0,0,0}));
      connect(T31_33_2.terminalA, bus33.terminal) annotation (Line(points={{-88,
              24},{-88,30},{-95.5,30},{-95.5,40.5}}, color={0,0,0}));
      connect(T4_iX2.terminalB, bus4.terminal)
        annotation (Line(points={{0,-44},{0.5,-44},{0.5,-35.5}}, color={0,0,0}));
      connect(L4_2.terminalB, bus4.terminal)
        annotation (Line(points={{0,-18},{0,-35.5},{0.5,-35.5}}, color={0,0,0}));
      connect(pq31.terminal, bus31.terminal) annotation (Line(points={{-100,-42},
              {-100,-27.5},{-99.5,-27.5}}, color={0,0,0}));
      connect(bus31.terminal, Teq31_3.terminalA) annotation (Line(points={{-99.5,
              -27.5},{-99.5,-12},{-80,-12}}, color={0,0,0}));
      connect(T22_i.terminalB, bus22.terminal) annotation (Line(points={{84,28},
              {90,28},{90,28.5},{92.5,28.5}},color={0,0,0}));
      connect(bus22.terminal, sc22.terminal) annotation (Line(points={{92.5,
              28.5},{92.5,28},{106,28}},
                                   color={0,0,0}));
      connect(T1_11_1.terminalA, T1_11_2.terminalA) annotation (Line(points={{-10,82},
              {-10,86},{10,86},{10,82}},         color={0,0,0}));
      connect(gen11x2.terminal, bus11.terminal)
        annotation (Line(points={{0,108},{0,92}}, color={0,0,0}));
      connect(bus11.terminal, T1_11_2.terminalA) annotation (Line(points={{0,92},{
              0,86},{10,86},{10,82}},  color={0,0,0}));
      connect(T1_11_1.terminalB, T1_11_2.terminalB) annotation (Line(points={{
              -10,62},{-10,56},{10,56},{10,62}}, color={0,0,0}));
      connect(bus1.terminal, T1_11_2.terminalB) annotation (Line(points={{0.5,
              46.5},{0.5,52},{0,52},{0,56},{10,56},{10,62}}, color={0,0,0}));
      connect(L2_1.terminalA, bus1.terminal)
        annotation (Line(points={{0,38},{0.5,38},{0.5,46.5}}, color={0,0,0}));
      connect(bus2.terminal, L2_1.terminalB)
        annotation (Line(points={{20.5,8.5},{0,8.5},{0,18}}, color={0,0,0}));
      connect(bus2.terminal, T2_i.terminalB) annotation (Line(points={{20.5,8.5},{56,
              8.5},{56,14}},           color={0,0,0}));
      annotation (
        Diagram(coordinateSystem(extent={{-120,-120},{120,120}}),   graphics={Text(origin={64,-24}, lineColor = {238, 46, 47}, extent = {{-28, 6}, {28, -6}}, textString = "V. Info"),
            Rectangle(extent={{42,66},{82,2}},   lineColor={256,0,00})}),
        Documentation(info="<html>
<p>In this example the network is analysed throgh a Power Flow, in which all e PV voltages are set to be equal to the corresponding nominal values. Therefore on the corresponding busbars we read in diagram voltages all equal to 1.</p>
<p>The numerical data on diagram are in pw of the nominal values of the corresponding components. </p>
<p>Data of all components (resistances, inductances, etc.) are all written in SI units.</p>
<p>Names of buses with a two digit numerical code are inteded as submodels. For instance bus31, bus32, bus33 are intended as submodels of bus3: this because bus3.1, bus3.2, bus3.3 would have not been legal Modelica instance names.</p>
</html>"));
    end PowerFlowSI;

    model PowerFlowPU
      extends Modelica.Icons.Example;
      PowerGridsMC.Electrical.PowerFlow.SlackBusW Bus42(UNom(displayUnit = "V") = 1, SNom(displayUnit = "VA") = 1, U(displayUnit = "V") = 1.08) annotation (
        Placement(visible = true, transformation(origin={54,-46},    extent = {{-10, 10}, {10, -10}}, rotation = 90)));
      PowerGridsMC.Electrical.PowerFlow.PVBusW pv33(P(displayUnit = "W") = -1, SNom(displayUnit = "V.A") = 1,
        U(displayUnit="V") = 1.04,                                                                                                      UNom(displayUnit = "V") = 1, portVariablesPhases = true) annotation (
        Placement(visible = true, transformation(origin={-106,56},    extent={{-10,10},
                {10,-10}},                                                                             rotation = 0)));
      PowerGridsMC.Electrical.PowerFlow.PQBusW pq31(P(displayUnit = "W") = 2, Q(displayUnit = "var") = 1, SNom(displayUnit = "V.A") = 1, UNom(displayUnit = "V") = 1,
        showPortData=true)                                                                                                                                              annotation (
        Placement(visible = true, transformation(origin={-106,-38},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio T4_42x2(
        SNom(displayUnit="W") = 1,
        UNomA(displayUnit="V") = 1,
        UNomB(displayUnit="V") = 1,
        X=0.052545,
        showPortData=true)
                    annotation (Placement(visible=true, transformation(
            origin={0,-46},
            extent={{10,-10},{-10,10}},
            rotation=0)));
      PowerGridsMC.Electrical.Branches.LineConstantImpedance L3_2(B = 0.10257, R = 0.0088822, SNom(displayUnit = "W") = 1, UNom(displayUnit = "V") = 1, UNomA(displayUnit = "V") = 1, UNomB(displayUnit = "V") = 1, X = 0.062069, showPortData = true) annotation (
        Placement(visible = true, transformation(origin={-38,22},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.PowerFlow.PVBusW pv11(P(displayUnit = "W") = -2, SNom(displayUnit = "V.A") = 1,
        U(displayUnit="V") = 1.05,                                                                                                      UNom(displayUnit = "V") = 1, portVariablesPhases = true) annotation (
        Placement(visible = true, transformation(origin={-8,106},   extent={{-10,10},
                {10,-10}},                                                                           rotation = 0)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio T11_1x2(
        SNom(displayUnit="W") = 1,
        UNomA(displayUnit="V") = 1,
        UNomB(displayUnit="V") = 1,
        X=0.05404,
        showPortData=true) annotation (Placement(visible=true, transformation(
            origin={-8,70},
            extent={{-10,-10},{10,10}},
            rotation=-90)));
      PowerGridsMC.Electrical.Branches.LineConstantImpedance L2_1(B = 0.27353, R = 0.023686, SNom(displayUnit = "W") = 1, UNom(displayUnit = "V") = 1, UNomA(displayUnit = "V") = 1, UNomB(displayUnit = "V") = 1, X = 0.16552, showPortData = true) annotation (
        Placement(visible = true, transformation(origin={-8,40},    extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      PowerGridsMC.Electrical.Branches.LineConstantImpedance L4_2(B = 0.12309, R = 0.10659, SNom(displayUnit = "W") = 1, UNom(displayUnit = "V") = 1, UNomA(displayUnit = "V") = 1, UNomB(displayUnit = "V") = 1, X = 0.074482, showPortData = true) annotation (
        Placement(visible = true, transformation(origin={-8,-6},     extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      PowerGridsMC.Electrical.Branches.LineConstantImpedance L3_4(B = 0.068382, R = 0.0059215, SNom(displayUnit = "W") = 1, UNom(displayUnit = "V") = 1, UNomA(displayUnit = "V") = 1, UNomB(displayUnit = "V") = 1, X = 0.041479, showPortData = true) annotation (
        Placement(visible = true, transformation(origin={-40,-30},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio T4_41x2(
        SNom(displayUnit="W") = 1,
        UNomA(displayUnit="V") = 1,
        UNomB(displayUnit="V") = 1,
        X=0.074412) annotation (Placement(visible=true, transformation(
            origin={-22,-66},
            extent={{10,-10},{-10,10}},
            rotation=-90)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio T31_33x2(
        SNom(displayUnit="W") = 1,
        UNomA(displayUnit="V") = 1,
        UNomB(displayUnit="V") = 1,
        X=0.06736,
        rFixed=1,
        showPortData=true) annotation (Placement(visible=true, transformation(
            origin={-106,10},
            extent={{-10,-10},{10,10}},
            rotation=-90)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio T2_21d(SNom(displayUnit = "W") = 1, UNomA(displayUnit = "V") = 1, UNomB(displayUnit = "V") = 1, X = 0.07775) annotation (
        Placement(visible = true, transformation(origin={46,28},    extent = {{-10, -10}, {10, 10}}, rotation=90)));
      PowerGridsMC.Electrical.PowerFlow.PQBusW pq21(P(displayUnit = "W") = 2, Q(displayUnit = "var") = 1, SNom(displayUnit = "V.A") = 1, UNom(displayUnit = "V") = 1) annotation (
        Placement(visible = true, transformation(origin={26,54},    extent = {{-10, -10}, {10, 10}}, rotation=180)));
      PowerGridsMC.Electrical.PowerFlow.PVBusW pv22(P(displayUnit = "W") = 0, SNom(displayUnit = "V.A") = 1,
        U(displayUnit="V") = 0.98,                                                                                                    UNom(displayUnit = "V") = 1) annotation (
        Placement(visible = true, transformation(origin={108,14},    extent = {{-10, -10}, {10, 10}}, rotation=90)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio T2_22(SNom(displayUnit = "W") = 1, UNomA(displayUnit = "V") = 1, UNomB(displayUnit = "V") = 1, X = 2.7775,
        showPortData=true)                                                                                                                                              annotation (
        Placement(visible = true, transformation(origin={64,0},     extent = {{10, -10}, {-10, 10}}, rotation=180)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio T22_21(SNom(displayUnit = "W") = 1, UNomA(displayUnit = "V") = 1, UNomB(displayUnit = "V") = 1, X = 0.17867,
        showPortData=true)                                                                                                                                                annotation (
        Placement(visible = true, transformation(origin={64,40},    extent = {{-10, -10}, {10, 10}}, rotation=0)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio T41_42x2(
        SNom(displayUnit="W") = 1,
        UNomA(displayUnit="V") = 1,
        UNomB(displayUnit="V") = 1,
        X=0.026926,
        showPortData=true)
                    annotation (Placement(visible=true, transformation(
            origin={18,-64},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio Teq31_3(SNom(displayUnit = "W") = 1, UNomA(displayUnit = "V") = 1, UNomB(displayUnit = "V") = 1,
        X=0.064909)                                                                                                                                                      annotation (
        Placement(visible = true, transformation(origin={-82,-12},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.PowerFlow.PQBusW pq41(P(displayUnit = "W") = 1, Q(displayUnit = "var") = 0.5, SNom(displayUnit = "V.A") = 1, UNom(displayUnit = "V") = 1) annotation (
        Placement(visible = true, transformation(origin={-22,-86},   extent = {{-10, -10}, {10, 10}}, rotation=0)));
      inner PowerGridsMC.Electrical.System systemPowerGrids annotation (
        Placement(visible = true, transformation(origin={-70,98},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio Teq2_21u(SNom(displayUnit = "W") = 1, UNomA(displayUnit = "V") = 1, UNomB(displayUnit = "V") = 1,
        X=0.076469)                                                                                                                                                        annotation (
        Placement(visible = true, transformation(origin={16,32},    extent = {{-10, -10}, {10, 10}}, rotation=90)));
      PowerGridsMC.Electrical.Buses.Bus bus33(UNom(displayUnit="V") = 1, SNom(
            displayUnit="W") = 1)
        annotation (Placement(transformation(extent={{-116,26},{-96,46}})));
      PowerGridsMC.Electrical.Buses.Bus bus22(UNom(displayUnit="V") = 1, SNom(
            displayUnit="W") = 1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={92,14})));
      PowerGridsMC.Electrical.Buses.Bus bus11(UNom(displayUnit="V") = 1, SNom(
            displayUnit="W") = 1)
        annotation (Placement(transformation(extent={{-18,78},{2,98}})));
      PowerGridsMC.Electrical.Buses.Bus bus31(UNom(displayUnit="V") = 1, SNom(
            displayUnit="W") = 1)
        annotation (Placement(transformation(extent={{-116,-34},{-96,-14}})));
    equation
      connect(T11_1x2.terminalB, L2_1.terminalA)
        annotation (Line(points={{-8,60},{-8,50}}));
      connect(L3_2.terminalB, L2_1.terminalB) annotation (
        Line(points={{-28,22},{-8,22},{-8,30}}));
      connect(L2_1.terminalB, L4_2.terminalA) annotation (
        Line(points={{-8,30},{-8,4}}));
      connect(T2_21d.terminalA, L2_1.terminalB) annotation (
        Line(points={{46,18},{46,12},{-8,12},{-8,30}}));
      connect(T2_21d.terminalB, pq21.terminal) annotation (
        Line(points={{46,38},{46,48},{26,48},{26,54}}));
      connect(T22_21.terminalA, T2_21d.terminalB) annotation (
        Line(points={{54,40},{46,40},{46,38}}));
      connect(L3_4.terminalB, L4_2.terminalB) annotation (
        Line(points={{-30,-30},{-8,-30},{-8,-16}}));
      connect(T31_33x2.terminalB, Teq31_3.terminalA)
        annotation (Line(points={{-106,0},{-106,-12},{-92,-12}}));
      connect(L3_4.terminalA, Teq31_3.terminalB) annotation (
        Line(points={{-50,-30},{-58,-30},{-58,-12},{-72,-12}}));
      connect(L3_2.terminalA, Teq31_3.terminalB) annotation (
        Line(points={{-48,22},{-58,22},{-58,-12},{-72,-12}}));
      connect(T4_42x2.terminalA, Bus42.terminal)
        annotation (Line(points={{10,-46},{54,-46}}));
      connect(T4_42x2.terminalB, T4_41x2.terminalB)
        annotation (Line(points={{-10,-46},{-22,-46},{-22,-56}}));
      connect(T4_42x2.terminalB, L3_4.terminalB)
        annotation (Line(points={{-10,-46},{-22,-46},{-22,-30},{-30,-30}}));
      connect(T41_42x2.terminalA, T4_42x2.terminalA)
        annotation (Line(points={{18,-54},{18,-46},{10,-46}}));
      connect(pq41.terminal, T4_41x2.terminalA)
        annotation (Line(points={{-22,-86},{-22,-76}}));
      connect(T2_21d.terminalA, T2_22.terminalA) annotation (
        Line(points={{46,18},{46,0},{54,0}}));
      connect(Teq2_21u.terminalA, L2_1.terminalB) annotation (Line(points={{16,22},{
              16,12},{-8,12},{-8,30}},    color={0,0,0}));
      connect(Teq2_21u.terminalB, pq21.terminal) annotation (Line(points={{16,42},{16,
              48},{26,48},{26,54}},         color={0,0,0}));
      connect(pv33.terminal, bus33.terminal)
        annotation (Line(points={{-106,56},{-106,36}}, color={0,0,0}));
      connect(bus33.terminal, T31_33x2.terminalA)
        annotation (Line(points={{-106,36},{-106,20}}, color={0,0,0}));
      connect(T22_21.terminalB, T2_22.terminalB)
        annotation (Line(points={{74,40},{80,40},{80,0},{74,0}},   color={0,0,0}));
      connect(bus22.terminal, T2_22.terminalB)
        annotation (Line(points={{92,14},{80,14},{80,0},{74,0}},   color={0,0,0}));
      connect(pv22.terminal, bus22.terminal)
        annotation (Line(points={{108,14},{92,14}}, color={0,0,0}));
      connect(T11_1x2.terminalA, bus11.terminal)
        annotation (Line(points={{-8,80},{-8,88}}, color={0,0,0}));
      connect(pv11.terminal, bus11.terminal)
        annotation (Line(points={{-8,106},{-8,88}}, color={0,0,0}));
      connect(T41_42x2.terminalB, pq41.terminal)
        annotation (Line(points={{18,-74},{18,-86},{-22,-86}}, color={0,0,0}));
      connect(pq31.terminal, bus31.terminal)
        annotation (Line(points={{-106,-38},{-106,-24}}, color={0,0,0}));
      connect(bus31.terminal, Teq31_3.terminalA)
        annotation (Line(points={{-106,-24},{-106,-12},{-92,-12}}, color={0,0,0}));
      annotation (
        Diagram(coordinateSystem(extent={{-120,120},{120,-100}}),      graphics={
            Text(
              extent={{-18,58},{-12,52}},
              lineColor={0,0,0},
              textString="1"),
            Text(
              extent={{-16,20},{-10,14}},
              lineColor={0,0,0},
              textString="2"),
            Text(
              extent={{-66,-4},{-60,-10}},
              lineColor={0,0,0},
              textString="3"),
            Text(
              extent={{-16,-22},{-10,-28}},
              lineColor={0,0,0},
              textString="4"),
            Rectangle(extent={{34,52},{86,-10}}, lineColor={256,0,00}),
            Rectangle(extent={{-30,-36},{30,-82}}, lineColor={256,0,00})}),
          Documentation(info="<html>
<p>This example show that PowerGridsMC can be used also when the system is already seccribed as PU in a unuque basel so that in the ingle-line direct sequenxe diagram all ideal transformers are omitted.</p>
<p>this is very useful for teahching. </p>
<p>Aa important advantage is that the on-line numerical values are much easily compared to each other, since all voltages represent their PUI value witreference to the corresponding nominal value and all active and reactive powers are in PU of the unique MVA system base.</p>
<p>The parameters included here are derived from those in model PowerFlowSI using the following base for PU: </p>
<p><u>Unique power</u>: 100 MVA</p>
<p><u>Voltages</u>: </p>
<p>220 kV (nodes 1, 2, 3, 4)     12.65 kV (node 11)      13.50 kV (node 33</p>
<p>129.1 kV (node 31)             6.026 kV (node 32)      10.04 kV (node 22)</p>
<p>10.04 kV (node 23)            126.9 kV (node 21)</p>
</html>"));
    end PowerFlowPU;

    model Bus1FaultSI
      parameter Real alpha = 2;
      parameter Real beta = 2;
      extends Modelica.Icons.Example;
      PFTdemo.Line line annotation (Placement(visible=true, transformation(
            origin={-109.75,-108.413},
            extent={{-10.25,-11.5871},{10.25,8.91309}},
            rotation=0)));
      PowerGridsMC.Electrical.Branches.LineConstantImpedance L2_1(B = 200e3 * line.Yd, R = 200e3 * line.Rd, SNom(displayUnit = "MW") = 100000000, UNom(displayUnit = "kV") = 220000, UNomA(displayUnit = "kV") = 220000, UNomB(displayUnit = "kV") = 220000, X = 200e3 * line.Xd,
        showPortData=false)                                                                                                                                                                                                         annotation (
        Placement(visible = true, transformation(origin={-52.5,-6.5},     extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio T1_11_2(R = 377 / 110e3 * 240 ^ 2 / 110, SNom(displayUnit = "MW") = 110000000, UNomA(displayUnit = "kV") = 13800, UNomB(displayUnit = "kV") = 240000, X = 0.0999 * 240 ^ 2 / 110, rFixed = 240 / 13.8) annotation (
        Placement(visible = true, transformation(origin={-45,32.5},    extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio T1_11_1(R = 377 / 110e3 * 240 ^ 2 / 110, SNom(displayUnit = "MW") = 110000000, UNomA(displayUnit = "kV") = 13800, UNomB(displayUnit = "kV") = 240000, X = 0.0999 * 240 ^ 2 / 110, rFixed = 240 / 13.8, showPortData = false) annotation (
        Placement(visible = true, transformation(origin={-61.5,31.5},    extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      PowerGridsMC.Electrical.Branches.LineConstantImpedance L3_2(B = 75e3 * line.Yd, R = 75e3 * line.Rd, SNom(displayUnit = "MW") = 100000000, UNom(displayUnit = "kV") = 220000, UNomA(displayUnit = "kV") = 220000, UNomB(displayUnit = "kV") = 220000, X = 75e3 * line.Xd,
        showPortData=false)                                                                                                                                                                                                        annotation (
        Placement(visible = true, transformation(origin={-71,-33},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Branches.LineConstantImpedance L4_2(B = 90e3 * line.Yd, R = 90e3 * line.Rd, SNom(displayUnit = "MW") = 100000000, UNom(displayUnit = "V") = 1, UNomA(displayUnit = "kV") = 220000, UNomB(displayUnit = "kV") = 220000, X = 90e3 * line.Xd,
        showPortData=false)                                                                                                                                                                                                        annotation (
        Placement(visible = true, transformation(origin={-52,-47},    extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      PowerGridsMC.Electrical.Branches.LineConstantImpedance L3_4(B = 50e3 * line.Yd, R = 50e3 * line.Rd, SNom(displayUnit = "MW") = 100000000, UNom(displayUnit = "kV") = 220000, UNomA(displayUnit = "kV") = 220000, UNomB(displayUnit = "kV") = 220000, X = 50e3 * line.Xd,
        showPortData=false)                                                                                                                                                                                                        annotation (
        Placement(visible = true, transformation(origin={-71.5,-67},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      inner PowerGridsMC.Electrical.System systemPowerGrids(initOpt = PowerGridsMC.Types.Choices.InitializationOption.globalSteadyStateFixedPowerFlow, referenceFrequency = PowerGridsMC.Types.Choices.ReferenceFrequency.fixedReferenceGenerator) annotation (
        Placement(visible = true, transformation(origin = {62, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.RealExpression uf11(y=gen11x2.ufPuInStart)
        annotation (Placement(visible=true, transformation(
            origin={-120,58},
            extent={{-16,-8},{16,8}},
            rotation=0)));
      Modelica.Blocks.Sources.RealExpression pm42(y=-gen42x2_.PStart/gen42x2_.SNom)
        annotation (Placement(visible=true, transformation(
            origin={-1,-117},
            extent={{-7,-9},{7,9}},
            rotation=0)));
      PowerGridsMC.Electrical.Machines.SynchronousMachine4WindingsR gen11x2(
        H=4,
        PStart(displayUnit="W"),
        SNom=2*110e6,
        Tpd0=5.143,
        Tppd0=0.042,
        Tppq0=0.083,
        Tpq0=2.16,
        UNom(displayUnit="V") = 13.8e3,
        UPhaseStart(displayUnit="rad"),
        UStart(displayUnit="V"),
        portVariablesPhases=true,
        raPu=0,
        xdPu=2,
        xlPu=0.15,
        xpdPu=0.35,
        xppdPu=0.25,
        xppqPu=0.3,
        xpqPu=0.5,
        xqPu=1.8) annotation (Placement(visible=true, transformation(
            origin={-78,56},
            extent={{-10,-10},{10,10}},
            rotation=-90)));
      PowerGridsMC.Electrical.Machines.SynchronousMachine4WindingsR gen33x2(
        H=4,
        PStart(displayUnit="W"),
        SNom=2*78.1e6,
        Tpd0=5.143,
        Tppd0=0.042,
        Tppq0=0.083,
        Tpq0=2.16,
        UNom(displayUnit="V") = 13.8e3,
        UStart(displayUnit="V"),
        portVariablesPhases=true,
        raPu=0,
        xdPu=2,
        xlPu=0.15,
        xpdPu=0.35,
        xppdPu=0.25,
        xppqPu=0.3,
        xpqPu=0.5,
        xqPu=1.8,
        showPortData=false)
                  annotation (Placement(visible=true, transformation(
            origin={-110,22},
            extent={{-10,10},{10,-10}},
            rotation=0)));
      PowerGridsMC.Electrical.Machines.SynchronousMachine4WindingsR gen42x2_(
        H=4,
        SNom=206*2e6,
        Tpd0=5.143,
        Tppd0=0.042,
        Tppq0=0.083,
        Tpq0=2.16,
        UNom=15700,
        portVariablesPhases=true,
        raPu=0,
        xdPu=2,
        xlPu=0.15,
        xpdPu=0.35,
        xppdPu=0.25,
        xppqPu=0.3,
        xpqPu=0.5,
        xqPu=1.8) annotation (Placement(visible=true, transformation(
            origin={34,-106},
            extent={{-10,-10},{10,10}},
            rotation=0)));
      PowerGridsMC.Electrical.Machines.SynchronousMachine4WindingsR sc22(
        H=4,
        SNom=40000000,
        Tpd0=5.143,
        Tppd0=0.042,
        Tppq0=0.083,
        Tpq0=2.16,
        UNom=13800,
        portVariablesPhases=true,
        raPu=0,
        xdPu=2,
        xlPu=0.15,
        xpdPu=0.35,
        xppdPu=0.25,
        xppqPu=0.3,
        xpqPu=0.5,
        xqPu=1.8,
        showPortData=false)
                  annotation (Placement(visible=true, transformation(
            origin={32,18},
            extent={{10,10},{-10,-10}},
            rotation=0)));
      Modelica.Blocks.Sources.RealExpression pm11(y=-gen11x2.PStart/gen11x2.SNom)
        annotation (Placement(visible=true, transformation(
            origin={-126,72},
            extent={{-22,-8},{22,8}},
            rotation=0)));
      Modelica.Blocks.Sources.RealExpression uf42(y=gen42x2_.ufPuInStart)
        annotation (Placement(visible=true, transformation(
            origin={0,-132},
            extent={{-8,-10},{8,10}},
            rotation=0)));
      PowerGridsMC.Electrical.Loads.LoadPQVoltageDependenceR pq31(
        SNom(displayUnit="V.A") = 100000000,
        UNom(displayUnit="V") = 129e3,
        UPhaseStart(displayUnit="rad"),
        UStart(displayUnit="V"),
        alpha=alpha,
        beta=beta,
        portVariablesPhases=true) annotation (Placement(visible=true,
            transformation(
            origin={-140.5,-73},
            extent={{-10,-10},{10,10}},
            rotation=0)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio Teq31_3(R = 0.0948 * 230 ^ 2 / 160 / 30, SNom(displayUnit = "MW") = 160000000, UNomA(displayUnit = "kV") = 135000, UNomB(displayUnit = "kV") = 230000, X = 0.0948 * 230 ^ 2 / 160, rFixed = 230 / 135,
        showPortData=false)                                                                                                                                                                                                         annotation (
        Placement(visible = true, transformation(origin={-116,-50},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio T31_33_1(R = 273 / 75e3 * 132 ^ 2 / 75, SNom(displayUnit = "MW") = 75000000, UNomA(displayUnit = "kV") = 13800, UNomB(displayUnit = "kV") = 132000, X = 0.0965 * 132 ^ 2 / 75, rFixed = 132 / 13.8, showPortData = false) annotation (
        Placement(visible = true, transformation(origin={-148,-28},    extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio T31_33_2(R = 273 / 75e3 * 132 ^ 2 / 75, SNom(displayUnit = "MW") = 75000000, UNomA(displayUnit = "kV") = 13800, UNomB(displayUnit = "kV") = 132000, X = 0.0965 * 132 ^ 2 / 75, rFixed = 132 / 13.8,
        showPortData=false)                                                                                                                                                                                                         annotation (
        Placement(visible = true, transformation(origin={-130,-28},    extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Sources.RealExpression uf33(y=gen33x2.ufPuInStart)
        annotation (Placement(visible=true, transformation(
            origin={-145,30},
            extent={{-9,-10},{9,10}},
            rotation=0)));
      Modelica.Blocks.Sources.RealExpression pm33(y=-gen33x2.PStart/gen33x2.SNom)
        annotation (Placement(visible=true, transformation(
            origin={-142,14},
            extent={{-12,-8},{12,8}},
            rotation=0)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio T2_i(SNom(displayUnit = "MW") = 125000000, UNomA(displayUnit = "kV") = 230000, UNomB(displayUnit = "kV") = 230000, X = 71.884e-3 * 220 ^ 2 / 100,
        showPortData=false)                                                                                                                                                                                      annotation (
        Placement(visible = true, transformation(origin={-2,-22},    extent = {{10, -10}, {-10, 10}}, rotation = 90)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio Teq2_21(R = 435 / 125e3 * 126.9 ^ 2 / 100, SNom(displayUnit = "MW") = 125000000, UNomA(displayUnit = "kV") = 230000, UNomB(displayUnit = "kV") = 132700, X = 0.0875 * 126.9 ^ 2 / 100, rFixed = 132.7 / 230,
        showPortData=false)                                                                                                                                                                                                         annotation (
        Placement(visible = true, transformation(origin={-26,-8},     extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio T22_i(SNom(displayUnit = "MW") = 39000000, UNomA(displayUnit = "kV") = 230000, UNomB(displayUnit = "kV") = 10500, X = 0.1635 * 10.04 ^ 2 / 100, rFixed = 10.5 / 230,
        showPortData=false)                                                                                                                                                                                                       annotation (
        Placement(visible = true, transformation(origin={16,-12},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio T21_i(SNom(displayUnit = "MW") = 125000000, UNomA(displayUnit = "kV") = 230000, UNomB(displayUnit = "kV") = 132700, X = 4.624e-3 * 126.9 ^ 2 / 100, rFixed = 132.7 / 230,
        showPortData=false)                                                                                                                                                                                                         annotation (
        Placement(visible = true, transformation(origin={-2,10},    extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      Modelica.Blocks.Sources.RealExpression pmSc(y = 0) annotation (
        Placement(visible = true, transformation(origin={62,9},     extent = {{8, -9}, {-8, 9}}, rotation = 0)));
      Modelica.Blocks.Sources.RealExpression ufSC(y=sc22.ufPuInStart) annotation (
         Placement(visible=true, transformation(
            origin={60,33},
            extent={{8,-9},{-8,9}},
            rotation=0)));
      PowerGridsMC.Electrical.Buses.BusFault bus1(R = 1, SNom(displayUnit = "V.A") = 500000000, UNom(displayUnit = "V") = 234000, X = 0, portVariablesPhases = true, portVariablesPu = true,
        startTime=0.5,
        stopTime=0.6)                                                                                                                                                                                                       annotation (
        Placement(visible = true, transformation(origin={-52,12},   extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio T42_iX2(
        SNom(displayUnit="MW") = 190e6*2,
        UNomA(displayUnit="V") = 236.1,
        UNomB(displayUnit="V") = 15.75,
        X=0.017488*14.7^2/100/2,
        rFixed=15.75/236.1,
        showPortData=false)   annotation (Placement(visible=true, transformation(
            origin={-4,-84},
            extent={{10,-10},{-10,10}},
            rotation=180)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio T4_iX2(SNom(displayUnit = "MW") = 190e6 * 2, UNomA(displayUnit = "kV") = 236100, UNomB(displayUnit = "kV") = 236100, X = 0.04828 * 220 ^ 2 / 100 / 2,
        showPortData=false)                                                                                                                                                                                          annotation (
        Placement(visible = true, transformation(origin={-28,-70},    extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      PowerGridsMC.Electrical.Buses.ReferenceBusR gen42x2(
        SNom(displayUnit="V.A") = 5e+08,
        UNom(displayUnit="V") = 15700,
        portVariablesPhases=true,
        portVariablesPu=true) annotation (Placement(visible=true,
            transformation(
            origin={16,-84},
            extent={{-10,10},{10,-10}},
            rotation=90)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio T41_iX2(SNom(displayUnit = "MW") = 190e6 * 2, UNomA(displayUnit = "kV") = 236100, UNomB(displayUnit = "kV") = 127900, X = 0.02476 * 119 ^ 2 / 100 / 2, rFixed = 127.9 / 236.1,
        showPortData=false)                                                                                                                                                                                                         annotation (
        Placement(visible = true, transformation(origin = {-28, -94}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      PowerGridsMC.Electrical.Buses.Bus bus3(SNom(displayUnit = "V.A") = 100e6, UNom(displayUnit = "V") = 220e3, portVariablesPhases = true, portVariablesPu = true) annotation (
        Placement(visible = true, transformation(origin={-95.5,-49.5},    extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      PowerGridsMC.Electrical.Loads.LoadPQVoltageDependenceR pq21(
        SNom(displayUnit="V.A") = 100000000,
        UNom(displayUnit="V") = 127000,
        UPhaseStart(displayUnit="rad"),
        UStart(displayUnit="V"),
        alpha=alpha,
        beta=beta) annotation (Placement(visible=true, transformation(
            origin={-6,32},
            extent={{-10,10},{10,-10}},
            rotation=0)));
      PowerGridsMC.Electrical.Loads.LoadPQVoltageDependenceR pq41(
        SNom(displayUnit="V.A") = 100000000,
        UNom(displayUnit="V") = 119000,
        UPhaseStart(displayUnit="rad"),
        UStart(displayUnit="V"),
        alpha=alpha,
        beta=beta) annotation (Placement(visible=true, transformation(
            origin={-44,-112},
            extent={{-10,10},{10,-10}},
            rotation=90)));
      PowerGridsMC.Electrical.Buses.Bus bus3_3(
        SNom(displayUnit="V.A") = 100e6,
        UNom(displayUnit="V") = 13.8e3,
        portVariablesPhases=true,
        portVariablesPu=true) annotation (Placement(visible=true, transformation(
            origin={-109.5,4.5},
            extent={{-10,-10},{10,10}},
            rotation=0)));
      PowerGridsMC.Electrical.Buses.Bus bus31(
        SNom(displayUnit="V.A") = 100e6,
        UNom(displayUnit="V") = 135e3,
        portVariablesPhases=true,
        portVariablesPu=true) annotation (Placement(visible=true, transformation(
            origin={-139.5,-59.5},
            extent={{-10,-10},{10,10}},
            rotation=0)));
    equation
      connect(T1_11_2.terminalA, T1_11_1.terminalA) annotation (
        Line(points={{-45,42.5},{-45,44},{-61.5,44},{-61.5,41.5}}));
      connect(T1_11_2.terminalB, T1_11_1.terminalB) annotation (
        Line(points={{-45,22.5},{-45,21.5},{-61.5,21.5}}));
      connect(L3_2.terminalB, L2_1.terminalB) annotation (
        Line(points={{-61,-33},{-52.5,-33},{-52.5,-16.5}},        color = {0, 0, 0}));
      connect(L2_1.terminalB, L4_2.terminalA) annotation (
        Line(points={{-52.5,-16.5},{-52.5,-37},{-52,-37}}));
      connect(L4_2.terminalB, L3_4.terminalB) annotation (
        Line(points={{-52,-57},{-51.75,-57},{-51.75,-67},{-61.5,-67}}));
      connect(gen42x2_.PmPu, pm42.y) annotation (Line(points={{23.6,-102.6},{16,
              -102.6},{16,-117},{6.7,-117}}, color={0,0,127}));
      connect(gen42x2_.ufPuIn, uf42.y) annotation (Line(points={{23.6,-110},{22,
              -110},{22,-132},{8.8,-132}}, color={0,0,127}));
      connect(gen42x2_.omega, systemPowerGrids.omegaRefIn) annotation (Line(
            points={{44.3,-100.1},{50.1,-100.1},{50.1,-99.8},{52.2,-99.8}},
            color={0,0,127}));
      connect(pm11.y, gen11x2.PmPu) annotation (Line(points={{-101.8,72},{-74.6,
              72},{-74.6,66.4}}, color={0,0,127}));
      connect(uf11.y, gen11x2.ufPuIn) annotation (Line(points={{-102.4,58},{-96,
              58},{-96,70},{-82,70},{-82,66.4}}, color={0,0,127}));
      connect(T31_33_2.terminalB, Teq31_3.terminalA) annotation (
        Line(points={{-130,-38},{-130,-50},{-126,-50}}));
      connect(T31_33_1.terminalB, Teq31_3.terminalA) annotation (
        Line(points={{-148,-38},{-148,-50},{-126,-50}}));
      connect(pm33.y, gen33x2.PmPu) annotation (Line(points={{-128.8,14},{-126,14},
              {-126,18},{-120.4,18},{-120.4,18.6}}, color={0,0,127}));
      connect(gen33x2.ufPuIn, uf33.y) annotation (Line(points={{-120.4,26},{-130,
              26},{-130,30},{-135.1,30}}, color={0,0,127}));
      connect(T22_i.terminalA, T2_i.terminalA) annotation (
        Line(points={{6,-12},{-2,-12}}));
      connect(Teq2_21.terminalA, T2_i.terminalB) annotation (
        Line(points={{-26,-18},{-26,-38},{-2,-38},{-2,-32}}));
      connect(T21_i.terminalA, T2_i.terminalA) annotation (
        Line(points={{-2,0},{-2,-12}}));
      connect(T21_i.terminalB, Teq2_21.terminalB) annotation (
        Line(points={{-2,20},{-26,20},{-26,2}}));
      connect(sc22.terminal, T22_i.terminalB)
        annotation (Line(points={{32,18},{32,-12},{26,-12}}));
      connect(sc22.PmPu, pmSc.y) annotation (Line(points={{42.4,14.6},{50,14.6},{
              50,9},{53.2,9}}, color={0,0,127}));
      connect(ufSC.y, sc22.ufPuIn) annotation (Line(points={{51.2,33},{51.2,22},{
              42.4,22}}, color={0,0,127}));
      connect(T1_11_1.terminalB, bus1.terminal) annotation (
        Line(points={{-61.5,21.5},{-52,21.5},{-52,12}}));
      connect(L2_1.terminalA, bus1.terminal) annotation (
        Line(points={{-52.5,3.5},{-52.5,8},{-52,8},{-52,12}}));
      connect(T42_iX2.terminalB, gen42x2.terminal)
        annotation (Line(points={{6,-84},{16,-84}}));
      connect(T42_iX2.terminalA, T41_iX2.terminalA)
        annotation (Line(points={{-14,-84},{-28,-84}}));
      connect(T41_iX2.terminalA, T4_iX2.terminalA) annotation (
        Line(points={{-28,-84},{-28,-80}}));
      connect(T4_iX2.terminalB, L4_2.terminalB) annotation (
        Line(points={{-28,-60},{-52,-60},{-52,-57}}));
      connect(gen42x2.terminal, gen42x2_.terminal)
        annotation (Line(points={{16,-84},{34,-84},{34,-106}}));
      connect(Teq31_3.terminalB, bus3.terminal) annotation (
        Line(points={{-106,-50},{-102,-50},{-102,-49.5},{-95.5,-49.5}}));
      connect(L3_2.terminalA, bus3.terminal) annotation (
        Line(points={{-81,-33},{-88,-33},{-88,-49.5},{-95.5,-49.5}}));
      connect(L3_4.terminalA, bus3.terminal) annotation (
        Line(points={{-81.5,-67},{-88,-67},{-88,-49.5},{-95.5,-49.5}}));
      connect(pq21.terminal, T21_i.terminalB)
        annotation (Line(points={{-6,32},{-6,20},{-2,20}}));
      connect(T41_iX2.terminalB, pq41.terminal)
        annotation (Line(points={{-28,-104},{-28,-112},{-44,-112}}));
      connect(gen11x2.terminal, T1_11_1.terminalA) annotation (Line(points={{-78,
              56},{-52,56},{-52,44},{-61.5,44},{-61.5,41.5}}));
      connect(Teq2_21.terminalA, L2_1.terminalB) annotation (Line(points={{-26,-18},
              {-26,-26},{-52.5,-26},{-52.5,-16.5}},      color={0,0,0}));
      connect(gen33x2.terminal, bus3_3.terminal) annotation (Line(points={{-110,
              22},{-110,4.5},{-109.5,4.5}}, color={0,0,0}));
      connect(pq31.terminal, bus31.terminal) annotation (Line(points={{-140.5,
              -73},{-139.5,-73},{-139.5,-59.5}},
                                           color={0,0,0}));
      connect(bus31.terminal, Teq31_3.terminalA) annotation (Line(points={{-139.5,
              -59.5},{-139.5,-50},{-126,-50}},
                                        color={0,0,0}));
      connect(T31_33_1.terminalA, T31_33_2.terminalA) annotation (Line(points={{-148,
              -18},{-148,-12},{-130,-12},{-130,-18}}, color={0,0,0}));
      connect(bus3_3.terminal, T31_33_2.terminalA) annotation (Line(points={{-109.5,
              4.5},{-109.5,-6},{-138,-6},{-138,-12},{-130,-12},{-130,-18}}, color={0,
              0,0}));
      annotation (
        Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}})),
        Diagram(coordinateSystem(extent = {{-160, 80}, {80, -140}}), graphics={  Text(origin = {-7, 64}, extent = {{-19, 6}, {19, -6}},
              textString="OK! V. info",
              textColor={0,0,0})}),
        experiment(StopTime = 6, Interval = 0.00400267, Tolerance = 1e-06, StartTime = 0),
        __OpenModelica_simulationFlags(lv = "LOG_STATS", outputFormat = "mat", s = "dassl"),
        Documentation(info="<html>
<p>Model with data linked with PowerFlow.</p>
<p>All initial voltages have the same values as in PowerFlowSI</p>
<p>Here we see the effects of a (three-phase) fault at bus 1 between t= 0.5 and 0.6s.</p>
<p>In this example the machines have no regulators, and therefore the transient is poorly damped and the final voltages and frequency are different (rather far) from the original values.</p>
<p>See for instance the AC node (1, 2, 3, 4) voltages, and the values of omegaPU variables of gen11x2, gen22x2, gen42x2, sc.</p>
</html>"));
    end Bus1FaultSI;
    annotation (Documentation(info="<html>
<p>This is a much larger example than BasicGrid.</p>
<p>It is derived from realistic data originally collected by prof. Luigi Paris of the Unviersity of Pisa, and adapted to Modelica by prof. Massimo Ceraolo, also from the University ot Pisa.</p>
<p>The same network is used for Power Flow and transient; the transients start as initial condition from the PowerFlow results.</p>
<p>The network has generators, transformers, loads and a synchronous compensator.</p>
<p>The considered network contained three-winding transformers. Since PowergridsMC library does not contain models for these transformers, they are approximated, as common by three two-winding transfomers in star (power flow ) or delta (transient) configurations.</p>
<p>See info of individual models for details.</p>
</html>"));
  end FourATbus;
  annotation (
    conversion(noneFromVersion="", noneFromVersion="1"), Documentation(info="<html>
<p><i><span style=\"font-family: Arial; font-size: 12pt;\">Library PowerGridsMC was forked from https://github.com/PowerGrids/PowerGrids on 22 November 2024.</span></i></p>
<p><i><span style=\"font-size: 12pt;\">Folder PFT was not present in the original PowerGrids library</span></i></p>
<p>************************** </p>
<p>PFT folder contains examples of the PowerFlow-&gt;Transient simulation chain. </p>
<p>This allows to transfer automatically output from PowerFlow into transient simulations. This is done through saving of the relevant information a disk files.  The data is stored and retrieved based on the instance name. Therefore, for an effective PowerFlow-&gt;Transient chaining, the instance name of the PowerFlow writing and Transient reading models must be the same.</p>
<p><br>This mechanism can be pursued in two ways:</p>
<p>1. <u>Separate models</u>. In this case the user first runs a PowerFlow study, then a transient. This technique has the shortcoming that two different models form the same sysem must be built. However, if the user builds first the PowerFlow model, they can later bvery easily infer as transient model duplicating it annd making only the folloing changesd:</p>
<ul>
<li>PowerFlow PQBusW into LoadPQ***R  (e.g. LoadPQVoltageDependenceR)</li>
<li>PowerFlow PVBusW into generators or generators and the corresponding controllers (see the examples provided)</li>
<li>PowerFlow SlackBusW into EquivalentGridR</li>
</ul>
<p>The other components (lines, transformers), remain unchanged.</p>
<p>2. <u>Unified models</u>. These will be models that combine PowerFlow and transient studues. they must ber run first in PowerFlow mode, to generate PowerFlow output on disk, then in transient mode (trhansient will use PF data previously stored on disk). This way allows faster implementation,  and helps keeping the number of models small, since there is no need to have two bersions (Power Flow and Transient) of the same system model. <b>This way has still to be implemented.</b></p>
</html>"));
end PFT;
