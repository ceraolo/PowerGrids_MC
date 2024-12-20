within PowerGridsMC.Examples;
package PFT
  extends Modelica.Icons.ExamplesPackage;

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

  package BasicSystem
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
        Placement(visible = true, transformation(origin={20,20},     extent={{-6,-6},
                {6,6}},                                                                               rotation = 0)));
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
        Diagram(coordinateSystem(extent={{-60,-40},{80,40}})),
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
            origin={-32,18},
            extent={{-10,10},{10,-10}},
            rotation=0)));
      PowerGridsMC.Electrical.Buses.Bus NTLV(SNom = 5e+08, UNom = 21000, portVariablesPhases = true, portVariablesPu = true)  annotation (
        Placement(visible = true, transformation(origin={-6,0},     extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      PowerGridsMC.Electrical.Buses.Bus NTHV(SNom = 5e+08, UNom = 380000, portVariablesPhases = true, portVariablesPu = true)  annotation (
        Placement(visible = true, transformation(origin={30,0},      extent = {{-10, 10}, {10, -10}}, rotation = 90)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio TGEN( R = 0.15e-2 * 419 ^ 2 / 500,
        SNom=500000000,
        UNomA=21000,
        UNomB=419000,                                                                                                                      X = 16e-2 * 419 ^ 2 / 500, portVariablesPhases = true,
        showPortData=true,                                                                                                                                                                          portVariablesPu = true, rFixed = 419 / 21)  annotation (
        Placement(visible = true, transformation(origin={12,0},      extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Buses.EquivalentGridR GRID(
        R_X=1/10,
        SNom=500000000,
        SSC=2500000000,
        UNom=380000,
        c=1.1,
        portVariablesPhases=true,
        portVariablesPu=true) annotation (Placement(visible=true,
            transformation(
            origin={56,10},
            extent={{-10,-10},{10,10}},
            rotation=0)));

      PowerGridsMC.Electrical.Loads.LoadPQVoltageDependenceR GRIDL(
        alpha=2,
        beta=2,
        SNom=500000000,
        UNom=380000,
        portVariablesPhases=true) annotation (Placement(visible=true,
            transformation(
            origin={66,-12},
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
            origin={-64,8},
            extent={{-10,-10},{10,10}},
            rotation=0)));
      Modelica.Blocks.Sources.RealExpression ufPuIn(y=GEN.ufPuInStart)
        annotation (Placement(visible=true, transformation(
            origin={-66,22},
            extent={{-10,-10},{10,10}},
            rotation=0)));
      PowerGridsMC.Electrical.Loads.LoadPQVoltageDependenceInputs Grid2(
        UNom=380000,
        SNom=500000000,
        alpha=2,
        beta=2)
        annotation (Placement(transformation(extent={{34,-28},{54,-8}})));
      Modelica.Blocks.Sources.Step stepQ(height=76e6, startTime=1)
        annotation (Placement(transformation(extent={{-2,-34},{6,-26}})));
      Modelica.Blocks.Sources.Step stepP(height=500e6, startTime=1)
        annotation (Placement(transformation(extent={{10,-26},{18,-18}})));
    equation
      connect(PmPu.y, GEN.pmPuIn) annotation (Line(points={{-53,8},{-48,8},{-48,
              14.6},{-42.4,14.6}}, color={0,0,127}));
      connect(ufPuIn.y, GEN.ufPuIn)
        annotation (Line(points={{-55,22},{-42.4,22}},
                                                     color={0,0,127}));
      connect(GRIDL.terminal, NTHV.terminal)
        annotation (Line(points={{66,-12},{66,0},{30,0}}));
      connect(GEN.terminal, NTLV.terminal)
        annotation (Line(points={{-32,18},{-32,0},{-6,0}}));
      connect(NTLV.terminal, TGEN.terminalA) annotation (
        Line(points={{-6,0},{2,0}}));
      connect(TGEN.terminalB, NTHV.terminal) annotation (
        Line(points={{22,0},{30,0}}));
      connect(NTHV.terminal, GRID.terminal)
        annotation (Line(points={{30,0},{56,0},{56,10}}));
      connect(Grid2.terminal, NTHV.terminal)
        annotation (Line(points={{44,-18},{44,0},{30,0}},     color={0,0,0}));
      connect(Grid2.QRefIn, stepQ.y) annotation (Line(points={{34,-28},{30,-28},
              {30,-30},{6.4,-30}}, color={0,0,127}));
      connect(stepP.y, Grid2.PRefIn)
        annotation (Line(points={{18.4,-22},{34,-22}}, color={0,0,127}));
      annotation (
        Icon(coordinateSystem(grid={2,2}, extent={{-100,-100},{100,100}})),
        Diagram(coordinateSystem(                   extent={{-80,-40},{80,40}})),
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
        annotation (Placement(transformation(extent={{-52,0},{-32,20}})));
      PowerGridsMC.Electrical.Buses.Bus NTLV(
        SNom=5e+08,
        UNom=21000,
        portVariablesPhases=true,
        portVariablesPu=true)  annotation (
        Placement(visible = true, transformation(origin={-22,10},   extent = {{-10, -10}, {10, 10}}, rotation = 90)));
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
        Placement(visible = true, transformation(origin={-4,10},     extent = {{-10, -10}, {10, 10}}, rotation = 0)));
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
        annotation (Line(points={{-42,10},{-22,10}}));
      connect(NTLV.terminal,TGEN. terminalA) annotation (
        Line(points={{-22,10},{-14,10}}));
      connect(TGEN.terminalB,NTHV. terminal) annotation (
        Line(points={{6,10},{20,10}}));
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
  end BasicSystem;

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
      PowerGridsMC.Examples.PFT.Line line annotation (Placement(visible=true, transformation(
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
            Rectangle(extent={{42,66},{82,2}},   lineColor={256,0,0})}),
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
            Rectangle(extent={{34,52},{86,-10}}, lineColor={256,0,0}),
            Rectangle(extent={{-30,-36},{30,-82}}, lineColor={256,0,0})}),
          Documentation(info="<html>
<p>This example show that PowerGridsMC can be used also when the system is already described as PU in a unuque basel so that in the single-line direct sequence diagram all ideal transformers are omitted. This is very useful for teaching. </p>
<p>An important advantage is that the on-line numerical values are much easily compared to each other, since all voltages represent their PU value with reference to the corresponding nominal value and all active and reactive powers are in PU of the unique MVA system base.</p>
<p>The parameters included here are derived from those in model PowerFlowSI using the following base for PU: </p>
<p><u>Unique power</u>: 100 MVA</p>
<p><u>Voltages</u>: </p>
<p>220 kV (nodes 1, 2, 3, 4) 12.65 kV (node 11) 13.50 kV (node 33</p>
<p>129.1 kV (node 31) 6.026 kV (node 32) 10.04 kV (node 22)</p>
<p>10.04 kV (node 23) 126.9 kV (node 21)</p>
</html>"));
    end PowerFlowPU;

    model Bus1FaultSIunregulated
      parameter Real alpha = 2;
      parameter Real beta = 2;
      extends Modelica.Icons.Example;
      PowerGridsMC.Examples.PFT.Line line annotation (Placement(visible=true, transformation(
            origin={-109.75,-108.413},
            extent={{-10.25,-11.5871},{10.25,8.91309}},
            rotation=0)));

      //Lines
      PowerGridsMC.Electrical.Branches.LineConstantImpedance L2_1(B = 200e3 * line.Yd, R = 200e3 * line.Rd, SNom(displayUnit = "MW") = 100000000, UNom(displayUnit = "kV") = 220000, UNomA(displayUnit = "kV") = 220000, UNomB(displayUnit = "kV") = 220000, X = 200e3 * line.Xd,
        showPortData=false)                                                                                                                                                                                                         annotation (
        Placement(visible = true, transformation(origin={-52.5,-6.5},     extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      PowerGridsMC.Electrical.Branches.LineConstantImpedance L3_2(B = 75e3 * line.Yd, R = 75e3 * line.Rd, SNom(displayUnit = "MW") = 100000000, UNom(displayUnit = "kV") = 220000, UNomA(displayUnit = "kV") = 220000, UNomB(displayUnit = "kV") = 220000, X = 75e3 * line.Xd,
        showPortData=true)                                                                                                                                                                                                         annotation (
        Placement(visible = true, transformation(origin={-71,-33},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Branches.LineConstantImpedance L4_2(B = 90e3 * line.Yd, R = 90e3 * line.Rd, SNom(displayUnit = "MW") = 100000000, UNom(displayUnit = "V") = 1, UNomA(displayUnit = "kV") = 220000, UNomB(displayUnit = "kV") = 220000, X = 90e3 * line.Xd,
        showPortData=false)                                                                                                                                                                                                        annotation (
        Placement(visible = true, transformation(origin={-52,-47},    extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      PowerGridsMC.Electrical.Branches.LineConstantImpedance L3_4(B = 50e3 * line.Yd, R = 50e3 * line.Rd, SNom(displayUnit = "MW") = 100000000, UNom(displayUnit = "kV") = 220000, UNomA(displayUnit = "kV") = 220000, UNomB(displayUnit = "kV") = 220000, X = 50e3 * line.Xd,
        showPortData=false)                                                                                                                                                                                                        annotation (
        Placement(visible = true, transformation(origin={-71.5,-67},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      inner PowerGridsMC.Electrical.System systemPowerGrids(initOpt = PowerGridsMC.Types.Choices.InitializationOption.globalSteadyStateFixedPowerFlow, referenceFrequency = PowerGridsMC.Types.Choices.ReferenceFrequency.fixedReferenceGenerator) annotation (
        Placement(visible = true, transformation(origin = {62, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      //Generators
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
            origin={-80,56},
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
      PowerGridsMC.Electrical.Machines.SynchronousMachine4WindingsR gen42x2(
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
            origin={38,18},
            extent={{10,10},{-10,-10}},
            rotation=0)));

     //Real Expressions
      Modelica.Blocks.Sources.RealExpression pm11(y=-gen11x2.PStart/gen11x2.SNom)
        annotation (Placement(visible=true, transformation(
            origin={-126,72},
            extent={{-22,-8},{22,8}},
            rotation=0)));
      Modelica.Blocks.Sources.RealExpression uf42(y=gen42x2.ufPuInStart)
        annotation (Placement(visible=true, transformation(
            origin={0,-132},
            extent={{-8,-10},{8,10}},
            rotation=0)));
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
      Modelica.Blocks.Sources.RealExpression uf11(y=gen11x2.ufPuInStart)
        annotation (Placement(visible=true, transformation(
            origin={-120,58},
            extent={{-16,-8},{16,8}},
            rotation=0)));
      Modelica.Blocks.Sources.RealExpression pm42(y=-gen42x2.PStart/gen42x2.SNom)
        annotation (Placement(visible=true, transformation(
            origin={-1,-117},
            extent={{-7,-9},{7,9}},
            rotation=0)));
      Modelica.Blocks.Sources.RealExpression pmSc(y = 0) annotation (
        Placement(visible = true, transformation(origin={68,9},     extent = {{8, -9}, {-8, 9}}, rotation = 0)));
      Modelica.Blocks.Sources.RealExpression ufSC(y=sc22.ufPuInStart) annotation (
         Placement(visible=true, transformation(
            origin={66,33},
            extent={{8,-9},{-8,9}},
            rotation=0)));

      //Loads
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
      PowerGridsMC.Electrical.Loads.LoadPQVoltageDependenceR pq21(
        SNom(displayUnit="V.A") = 100000000,
        UNom(displayUnit="V") = 127000,
        UPhaseStart(displayUnit="rad"),
        UStart(displayUnit="V"),
        alpha=alpha,
        beta=beta) annotation (Placement(visible=true, transformation(
            origin={-22,32},
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
      //Transformers
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio T1_11_2(R = 377 / 110e3 * 240 ^ 2 / 110, SNom(displayUnit = "MW") = 110000000, UNomA(displayUnit = "kV") = 13800, UNomB(displayUnit = "kV") = 240000, X = 0.0999 * 240 ^ 2 / 110, rFixed = 240 / 13.8) annotation (
        Placement(visible = true, transformation(origin={-45,32.5},    extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio T1_11_1(R = 377 / 110e3 * 240 ^ 2 / 110, SNom(displayUnit = "MW") = 110000000, UNomA(displayUnit = "kV") = 13800, UNomB(displayUnit = "kV") = 240000, X = 0.0999 * 240 ^ 2 / 110, rFixed = 240 / 13.8, showPortData = false) annotation (
        Placement(visible = true, transformation(origin={-61.5,31.5},    extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio Teq31_3(R = 0.0948 * 230 ^ 2 / 160 / 30, SNom(displayUnit = "MW") = 160000000, UNomA(displayUnit = "kV") = 135000, UNomB(displayUnit = "kV") = 230000, X = 0.0948 * 230 ^ 2 / 160, rFixed = 230 / 135,
        showPortData=false)                                                                                                                                                                                                         annotation (
        Placement(visible = true, transformation(origin={-116,-50},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio T31_33_1(R = 273 / 75e3 * 132 ^ 2 / 75, SNom(displayUnit = "MW") = 75000000, UNomA(displayUnit = "kV") = 13800, UNomB(displayUnit = "kV") = 132000, X = 0.0965 * 132 ^ 2 / 75, rFixed = 132 / 13.8, showPortData = false) annotation (
        Placement(visible = true, transformation(origin={-148,-28},    extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio T31_33_2(R = 273 / 75e3 * 132 ^ 2 / 75, SNom(displayUnit = "MW") = 75000000, UNomA(displayUnit = "kV") = 13800, UNomB(displayUnit = "kV") = 132000, X = 0.0965 * 132 ^ 2 / 75, rFixed = 132 / 13.8,
        showPortData=false)                                                                                                                                                                                                         annotation (
        Placement(visible = true, transformation(origin={-130,-28},    extent = {{-10, -10}, {10, 10}}, rotation = -90)));
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
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio T42_iX2(
        SNom(displayUnit="MW") = 190e6*2,
        UNomA(displayUnit="V") = 236.1,
        UNomB(displayUnit="V") = 15.75,
        X=0.017488*14.7^2/100/2,
        rFixed=15.75/236.1,
        showPortData=true)    annotation (Placement(visible=true, transformation(
            origin={-4,-84},
            extent={{10,-10},{-10,10}},
            rotation=180)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio T4_iX2(SNom(displayUnit = "MW") = 190e6 * 2, UNomA(displayUnit = "kV") = 236100, UNomB(displayUnit = "kV") = 236100, X = 0.04828 * 220 ^ 2 / 100 / 2,
        showPortData=false)                                                                                                                                                                                          annotation (
        Placement(visible = true, transformation(origin={-28,-70},    extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio T41_iX2(SNom(displayUnit = "MW") = 190e6 * 2, UNomA(displayUnit = "kV") = 236100, UNomB(displayUnit = "kV") = 127900, X = 0.02476 * 119 ^ 2 / 100 / 2, rFixed = 127.9 / 236.1,
        showPortData=false)                                                                                                                                                                                                         annotation (
        Placement(visible = true, transformation(origin = {-28, -94}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      //Buses
      PowerGridsMC.Electrical.Buses.BusFault bus1(R = 1, SNom(displayUnit = "V.A") = 500000000,
        UNom(displayUnit="V") = 220000,    X = 0, portVariablesPhases = true, portVariablesPu = true,
        startTime=0.5,
        stopTime=0.6)                                                                                                                                                                                                       annotation (
        Placement(visible = true, transformation(origin={-52,12},   extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Buses.Bus bus3(SNom(displayUnit = "V.A") = 100e6, UNom(displayUnit = "V") = 220e3, portVariablesPhases = true, portVariablesPu = true) annotation (
        Placement(visible = true, transformation(origin={-95.5,-49.5},    extent = {{-10, -10}, {10, 10}}, rotation = 90)));
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
      Electrical.Buses.Bus bus11(
        SNom(displayUnit="V.A") = 100e6,
        UNom(displayUnit="V") = 13.8e3,
        portVariablesPhases=true,
        portVariablesPu=true) annotation (Placement(visible=true,
            transformation(
            origin={-51.5,52.5},
            extent={{-10,-10},{10,10}},
            rotation=0)));
      Electrical.Buses.Bus bus42(
        SNom(displayUnit="V.A") = 100e6,
        UNom(displayUnit="V") = 15.7e3,
        portVariablesPhases=true,
        portVariablesPu=true) annotation (Placement(visible=true,
            transformation(
            origin={34.5,-89.5},
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
      connect(gen42x2.pmPuIn, pm42.y) annotation (Line(points={{23.6,-102.6},{
              16,-102.6},{16,-117},{6.7,-117}}, color={0,0,127}));
      connect(gen42x2.ufPuIn, uf42.y) annotation (Line(points={{23.6,-110},{22,
              -110},{22,-132},{8.8,-132}}, color={0,0,127}));
      connect(gen42x2.omega, systemPowerGrids.omegaRefIn) annotation (Line(
            points={{44.3,-100.1},{50.1,-100.1},{50.1,-99.8},{51.2,-99.8}},
            color={0,0,127}));
      connect(pm11.y, gen11x2.pmPuIn) annotation (Line(points={{-101.8,72},{-76.6,
              72},{-76.6,66.4}}, color={0,0,127}));
      connect(uf11.y, gen11x2.ufPuIn) annotation (Line(points={{-102.4,58},{-96,
              58},{-96,70},{-84,70},{-84,66.4}}, color={0,0,127}));
      connect(T31_33_2.terminalB, Teq31_3.terminalA) annotation (
        Line(points={{-130,-38},{-130,-50},{-126,-50}}));
      connect(T31_33_1.terminalB, Teq31_3.terminalA) annotation (
        Line(points={{-148,-38},{-148,-50},{-126,-50}}));
      connect(pm33.y, gen33x2.pmPuIn) annotation (Line(points={{-128.8,14},{-126,
              14},{-126,18},{-120.4,18},{-120.4,18.6}}, color={0,0,127}));
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
        annotation (Line(points={{38,18},{38,-12},{26,-12}}));
      connect(sc22.pmPuIn, pmSc.y) annotation (Line(points={{48.4,14.6},{56,
              14.6},{56,9},{59.2,9}}, color={0,0,127}));
      connect(ufSC.y, sc22.ufPuIn) annotation (Line(points={{57.2,33},{57.2,22},
              {48.4,22}},color={0,0,127}));
      connect(T1_11_1.terminalB, bus1.terminal) annotation (
        Line(points={{-61.5,21.5},{-52,21.5},{-52,12}}));
      connect(L2_1.terminalA, bus1.terminal) annotation (
        Line(points={{-52.5,3.5},{-52.5,8},{-52,8},{-52,12}}));
      connect(T42_iX2.terminalA, T41_iX2.terminalA)
        annotation (Line(points={{-14,-84},{-28,-84}}));
      connect(T41_iX2.terminalA, T4_iX2.terminalA) annotation (
        Line(points={{-28,-84},{-28,-80}}));
      connect(T4_iX2.terminalB, L4_2.terminalB) annotation (
        Line(points={{-28,-60},{-52,-60},{-52,-57}}));
      connect(Teq31_3.terminalB, bus3.terminal) annotation (
        Line(points={{-106,-50},{-102,-50},{-102,-49.5},{-95.5,-49.5}}));
      connect(L3_2.terminalA, bus3.terminal) annotation (
        Line(points={{-81,-33},{-88,-33},{-88,-49.5},{-95.5,-49.5}}));
      connect(L3_4.terminalA, bus3.terminal) annotation (
        Line(points={{-81.5,-67},{-88,-67},{-88,-49.5},{-95.5,-49.5}}));
      connect(pq21.terminal, T21_i.terminalB)
        annotation (Line(points={{-22,32},{-22,20},{-2,20}}));
      connect(T41_iX2.terminalB, pq41.terminal)
        annotation (Line(points={{-28,-104},{-28,-112},{-44,-112}}));
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
      connect(gen11x2.terminal, bus11.terminal) annotation (Line(points={{-80,
              56},{-68,56},{-68,64},{-51.5,64},{-51.5,52.5}}, color={0,0,0}));
      connect(bus11.terminal, T1_11_1.terminalA) annotation (Line(points={{
              -51.5,52.5},{-52,44},{-61.5,44},{-61.5,41.5}}, color={0,0,0}));
      connect(T42_iX2.terminalB, bus42.terminal) annotation (Line(points={{6,
              -84},{14,-84},{14,-78},{34.5,-78},{34.5,-89.5}}, color={0,0,0}));
      connect(bus42.terminal, gen42x2.terminal) annotation (Line(points={{34.5,
              -89.5},{34,-89.5},{34,-106}}, color={0,0,0}));
      annotation (
        Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}})),
        Diagram(coordinateSystem(extent = {{-160, 80}, {80, -140}}), graphics={
            Rectangle(extent={{-12,24},{24,-42}},lineColor={256,0,0}),
            Rectangle(extent={{-38,-56},{10,-104}},
                                                 lineColor={256,0,0})}),
        experiment(StopTime = 6, Interval = 0.00400267, Tolerance = 1e-06, StartTime = 0),
        __OpenModelica_simulationFlags(lv = "LOG_STATS", outputFormat = "mat", s = "dassl"),
        Documentation(info="<html>
<p>Model with data linked with PowerFlow.</p>
<p>All initial voltages have the same values as in PowerFlowSI</p>
<p>Here we see the effects of a (three-phase) fault at bus 1 between t= 0.5 and 0.6s.</p>
<p>In this example the machines have no regulators, and therefore the transient is poorly damped and the final voltages and frequency are different (rather far) from the original values.</p>
<p>See for instance the AC node (1, 2, 3, 4) voltages, and the values of omegaPU variables of gen11x2, gen22x2, gen42x2, sc22.</p>
</html>"));
    end Bus1FaultSIunregulated;

    model Bus1FaultSIregulated
      parameter Real alpha = 2;
      parameter Real beta = 2;
      extends Modelica.Icons.Example;
      Line line annotation (Placement(visible=true, transformation(
            origin={-100,67.304},
            extent={{-10.0001,-11.3047},{10.0001,8.69585}},
            rotation=0)));
      PowerGridsMC.Electrical.Branches.LineConstantImpedance L2_1(B = 200e3 * line.Yd, R = 200e3 * line.Rd, SNom(displayUnit = "MW") = 100000000, UNom(displayUnit = "kV") = 220000, UNomA(displayUnit = "kV") = 220000, UNomB(displayUnit = "kV") = 220000, X = 200e3 * line.Xd,
        showPortData=false)                                                                                                                                                                                                         annotation (
        Placement(visible = true, transformation(origin={-52.5,9.5},      extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio T1_11_2(R = 377 / 110e3 * 240 ^ 2 / 110, SNom(displayUnit = "MW") = 110000000, UNomA(displayUnit = "kV") = 13800, UNomB(displayUnit = "kV") = 240000, X = 0.0999 * 240 ^ 2 / 110, rFixed = 240 / 13.8) annotation (
        Placement(visible = true, transformation(origin={-45,48.5},    extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio T1_11_1(R = 377 / 110e3 * 240 ^ 2 / 110, SNom(displayUnit = "MW") = 110000000, UNomA(displayUnit = "kV") = 13800, UNomB(displayUnit = "kV") = 240000, X = 0.0999 * 240 ^ 2 / 110, rFixed = 240 / 13.8, showPortData = false) annotation (
        Placement(visible = true, transformation(origin={-61.5,47.5},    extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      PowerGridsMC.Electrical.Branches.LineConstantImpedance L3_2(B = 75e3 * line.Yd, R = 75e3 * line.Rd, SNom(displayUnit = "MW") = 100000000, UNom(displayUnit = "kV") = 220000, UNomA(displayUnit = "kV") = 220000, UNomB(displayUnit = "kV") = 220000, X = 75e3 * line.Xd,
        showPortData=true)                                                                                                                                                                                                         annotation (
        Placement(visible = true, transformation(origin={-71,-11},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Branches.LineConstantImpedance L4_2(B = 90e3 * line.Yd, R = 90e3 * line.Rd, SNom(displayUnit = "MW") = 100000000, UNom(displayUnit = "V") = 1, UNomA(displayUnit = "kV") = 220000, UNomB(displayUnit = "kV") = 220000, X = 90e3 * line.Xd,
        showPortData=false)                                                                                                                                                                                                        annotation (
        Placement(visible = true, transformation(origin={-52,-31},    extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      PowerGridsMC.Electrical.Branches.LineConstantImpedance L3_4(B = 50e3 * line.Yd, R = 50e3 * line.Rd, SNom(displayUnit = "MW") = 100000000, UNom(displayUnit = "kV") = 220000, UNomA(displayUnit = "kV") = 220000, UNomB(displayUnit = "kV") = 220000, X = 50e3 * line.Xd,
        showPortData=true)                                                                                                                                                                                                         annotation (
        Placement(visible = true, transformation(origin={-71.5,-51},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      inner PowerGridsMC.Electrical.System systemPowerGrids(initOpt = PowerGridsMC.Types.Choices.InitializationOption.globalSteadyStateFixedPowerFlow, referenceFrequency = PowerGridsMC.Types.Choices.ReferenceFrequency.fixedReferenceGenerator,
        showDataOnDiagramsPu=false)                                                                                                                                                                                                         annotation (
        Placement(visible = true, transformation(origin={64,-82},     extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Loads.LoadPQVoltageDependenceR pq31(
        SNom(displayUnit="V.A") = 100000000,
        UNom(displayUnit="V") = 129e3,
        UPhaseStart(displayUnit="rad"),
        UStart(displayUnit="V"),
        alpha=alpha,
        beta=beta,
        portVariablesPhases=true) annotation (Placement(visible=true,
            transformation(
            origin={-142.5,-57},
            extent={{-10,-10},{10,10}},
            rotation=0)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio Teq31_3(R = 0.0948 * 230 ^ 2 / 160 / 30, SNom(displayUnit = "MW") = 160000000, UNomA(displayUnit = "kV") = 135000, UNomB(displayUnit = "kV") = 230000, X = 0.0948 * 230 ^ 2 / 160, rFixed = 230 / 135,
        showPortData=true)                                                                                                                                                                                                         annotation (
        Placement(visible = true, transformation(origin={-116,-34},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio T31_33_1(R = 273 / 75e3 * 132 ^ 2 / 75, SNom(displayUnit = "MW") = 75000000, UNomA(displayUnit = "kV") = 13800, UNomB(displayUnit = "kV") = 132000, X = 0.0965 * 132 ^ 2 / 75, rFixed = 132 / 13.8, showPortData = false) annotation (
        Placement(visible = true, transformation(origin={-148,-12},    extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio T31_33_2(R = 273 / 75e3 * 132 ^ 2 / 75, SNom(displayUnit = "MW") = 75000000, UNomA(displayUnit = "kV") = 13800, UNomB(displayUnit = "kV") = 132000, X = 0.0965 * 132 ^ 2 / 75, rFixed = 132 / 13.8,
        showPortData=false)                                                                                                                                                                                                         annotation (
        Placement(visible = true, transformation(origin={-130,-12},    extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio T2_i(SNom(displayUnit = "MW") = 125000000, UNomA(displayUnit = "kV") = 230000, UNomB(displayUnit = "kV") = 230000, X = 71.884e-3 * 220 ^ 2 / 100,
        showPortData=false)                                                                                                                                                                                      annotation (
        Placement(visible = true, transformation(origin={4,-6},      extent = {{10, -10}, {-10, 10}}, rotation = 90)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio Teq2_21(R = 435 / 125e3 * 126.9 ^ 2 / 100, SNom(displayUnit = "MW") = 125000000, UNomA(displayUnit = "kV") = 230000, UNomB(displayUnit = "kV") = 132700, X = 0.0875 * 126.9 ^ 2 / 100, rFixed = 132.7 / 230,
        showPortData=false)                                                                                                                                                                                                         annotation (
        Placement(visible = true, transformation(origin={-20,8},      extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio T22_i(SNom(displayUnit = "MW") = 39000000, UNomA(displayUnit = "kV") = 230000, UNomB(displayUnit = "kV") = 10500, X = 0.1635 * 10.04 ^ 2 / 100, rFixed = 10.5 / 230,
        showPortData=true)                                                                                                                                                                                                        annotation (
        Placement(visible = true, transformation(origin={22,4},      extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio T21_i(SNom(displayUnit = "MW") = 125000000, UNomA(displayUnit = "kV") = 230000, UNomB(displayUnit = "kV") = 132700, X = 4.624e-3 * 126.9 ^ 2 / 100, rFixed = 132.7 / 230,
        showPortData=false)                                                                                                                                                                                                         annotation (
        Placement(visible = true, transformation(origin={4,26},     extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      PowerGridsMC.Electrical.Buses.BusFault bus1(R = 1, SNom(displayUnit = "V.A") = 500000000, UNom(displayUnit = "V") = 234000, X = 0, portVariablesPhases = true, portVariablesPu = true,
        startTime=0.5,
        stopTime=0.6)                                                                                                                                                                                                       annotation (
        Placement(visible = true, transformation(origin={-52,28},   extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio T42_iX2(
        SNom(displayUnit="MW") = 190e6*2,
        UNomA(displayUnit="V") = 236.1,
        UNomB(displayUnit="V") = 15.75,
        X=0.017488*14.7^2/100/2,
        rFixed=15.75/236.1,
        showPortData=false)   annotation (Placement(visible=true, transformation(
            origin={-4,-68},
            extent={{10,-10},{-10,10}},
            rotation=180)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio T4_iX2(SNom(displayUnit = "MW") = 190e6 * 2, UNomA(displayUnit = "kV") = 236100, UNomB(displayUnit = "kV") = 236100, X = 0.04828 * 220 ^ 2 / 100 / 2,
        showPortData=false)                                                                                                                                                                                          annotation (
        Placement(visible = true, transformation(origin={-24,-54},    extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      PowerGridsMC.Electrical.Buses.Bus bus42(
        SNom(displayUnit="V.A") = 5e+08,
        UNom(displayUnit="V") = 15700,
        portVariablesPhases=true,
        portVariablesPu=true) annotation (Placement(visible=true, transformation(
            origin={14,-68},
            extent={{-10,10},{10,-10}},
            rotation=90)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio T41_iX2(SNom(displayUnit = "MW") = 190e6 * 2, UNomA(displayUnit = "kV") = 236100, UNomB(displayUnit = "kV") = 127900, X = 0.02476 * 119 ^ 2 / 100 / 2, rFixed = 127.9 / 236.1,
        showPortData=false)                                                                                                                                                                                                         annotation (
        Placement(visible = true, transformation(origin={-24,-82},    extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      PowerGridsMC.Electrical.Buses.Bus bus3(SNom(displayUnit = "V.A") = 100e6, UNom(displayUnit = "V") = 220e3, portVariablesPhases = true, portVariablesPu = true) annotation (
        Placement(visible = true, transformation(origin={-95.5,-33.5},    extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      PowerGridsMC.Electrical.Loads.LoadPQVoltageDependenceR pq21(
        SNom(displayUnit="V.A") = 100000000,
        UNom(displayUnit="V") = 127000,
        UPhaseStart(displayUnit="rad"),
        UStart(displayUnit="V"),
        alpha=alpha,
        beta=beta) annotation (Placement(visible=true, transformation(
            origin={0,48},
            extent={{-10,10},{10,-10}},
            rotation=0)));
      PowerGridsMC.Electrical.Loads.LoadPQVoltageDependenceR pq41(
        SNom(displayUnit="V.A") = 100000000,
        UNom(displayUnit="V") = 119000,
        UPhaseStart(displayUnit="rad"),
        UStart(displayUnit="V"),
        alpha=alpha,
        beta=beta) annotation (Placement(visible=true, transformation(
            origin={-41,-95},
            extent={{-7,7},{7,-7}},
            rotation=90)));
      PowerGridsMC.Electrical.Buses.Bus bus33(
        SNom(displayUnit="V.A") = 100e6,
        UNom(displayUnit="V") = 13.8e3,
        portVariablesPhases=true,
        portVariablesPu=true) annotation (Placement(visible=true,
            transformation(
            origin={-139.5,20.5},
            extent={{-10,-10},{10,10}},
            rotation=0)));
      PowerGridsMC.Electrical.Buses.Bus bus31(
        SNom(displayUnit="V.A") = 100e6,
        UNom(displayUnit="V") = 135e3,
        portVariablesPhases=true,
        portVariablesPu=true) annotation (Placement(visible=true, transformation(
            origin={-141.5,-43.5},
            extent={{-10,-10},{10,10}},
            rotation=0)));
      PowerGridsMC.Examples.Tutorial.GridOperation.Controlled.ControlledGenPSS_R
        gen11x2(
        GEN(
          H=4,
          SNom=200000000,
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
          xqPu=1.8


))       annotation (Placement(transformation(extent={{-62,94},{-42,74}})));
      PowerGridsMC.Electrical.Buses.Bus bus2(
        SNom(displayUnit="V.A") = 100e6,
        UNom(displayUnit="V") = 220e3,
        portVariablesPhases=true,
        portVariablesPu=true)    annotation (
        Placement(visible = true, transformation(origin={-31.5,-11.5},    extent = {{-10, -10}, {10, 10}}, rotation=90)));
      PowerGridsMC.Examples.Tutorial.GridOperation.Controlled.ControlledGenPSS_R
        gen33x2(GEN(
          H=4,
          SNom=120000000,
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
          xqPu=1.8))
         annotation (Placement(transformation(extent={{-150,54},{-130,34}})));
      PowerGridsMC.Examples.IEEE14bus.SynchronousCondenserR sc22(GEN(
          DPu=0.0,
          H=5.625,
          Tppd0=0.065,
          xpdPu=0.509,
          Tpd0=10.041,
          raPu=0.00316,
          xpqPu=0.601,
          Tppq0=0.094,
          Tpq0=1.22,
          xppdPu=0.354,
          xdPu=2.81,
          xlPu=0.256,
          xppqPu=0.377,
          xqPu=2.62,
          PNom=1000000,
          SNom=60000000,
          UNom=13800))
        annotation (
        Placement(visible = true, transformation(origin={64,4},       extent = {{-10, -10}, {10, 10}}, rotation=0)));
      PowerGridsMC.Electrical.Buses.Bus bus11(
        SNom(displayUnit="V.A") = 100e6,
        UNom(displayUnit="V") = 13.8e3,
        portVariablesPhases=true,
        portVariablesPu=true) annotation (Placement(visible=true,
            transformation(
            origin={-51.5,68.5},
            extent={{-10,-10},{10,10}},
            rotation=0)));
      PowerGridsMC.Electrical.Buses.Bus bus22(
        SNom(displayUnit="V.A") = 100e6,
        UNom(displayUnit="V") = 13.8e3,
        portVariablesPhases=true,
        portVariablesPu=true) annotation (Placement(visible=true,
            transformation(
            origin={42.5,4.5},
            extent={{-10,-10},{10,10}},
            rotation=-90)));
      PowerGridsMC.Examples.IEEE14bus.ControlledGenNoPSS_R gen42x2(GEN(
          H=4,
          SNom=1000000*(206*2),
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
          xqPu=1.8))
        annotation (Placement(transformation(extent={{24,-92},{44,-72}})));
      PowerGridsMC.Electrical.Buses.Bus bus4(
        SNom(displayUnit="V.A") = 100e6,
        UNom(displayUnit="V") = 220e3,
        portVariablesPhases=true,
        portVariablesPu=true)                                                                                                                                        annotation (
        Placement(visible = true, transformation(origin={-41.5,-47.5},    extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    equation
      connect(T1_11_2.terminalA, T1_11_1.terminalA) annotation (
        Line(points={{-45,58.5},{-45,60},{-61.5,60},{-61.5,57.5}}));
      connect(T1_11_2.terminalB, T1_11_1.terminalB) annotation (
        Line(points={{-45,38.5},{-45,37.5},{-61.5,37.5}}));
      connect(L3_2.terminalB, L2_1.terminalB) annotation (
        Line(points={{-61,-11},{-52.5,-11},{-52.5,-0.5}},         color = {0, 0, 0}));
      connect(L2_1.terminalB, L4_2.terminalA) annotation (
        Line(points={{-52.5,-0.5},{-52.5,-21},{-52,-21}}));
      connect(T31_33_2.terminalB, Teq31_3.terminalA) annotation (
        Line(points={{-130,-22},{-130,-34},{-126,-34}}));
      connect(T31_33_1.terminalB, Teq31_3.terminalA) annotation (
        Line(points={{-148,-22},{-148,-34},{-126,-34}}));
      connect(T22_i.terminalA, T2_i.terminalA) annotation (
        Line(points={{12,4},{4,4}}));
      connect(Teq2_21.terminalA, T2_i.terminalB) annotation (
        Line(points={{-20,-2},{-20,-22},{4,-22},{4,-16}}));
      connect(T21_i.terminalA, T2_i.terminalA) annotation (
        Line(points={{4,16},{4,4}}));
      connect(T21_i.terminalB, Teq2_21.terminalB) annotation (
        Line(points={{4,36},{-20,36},{-20,18}}));
      connect(T1_11_1.terminalB, bus1.terminal) annotation (
        Line(points={{-61.5,37.5},{-52,37.5},{-52,28}}));
      connect(L2_1.terminalA, bus1.terminal) annotation (
        Line(points={{-52.5,19.5},{-52.5,24},{-52,24},{-52,28}}));
      connect(T42_iX2.terminalB, bus42.terminal)
        annotation (Line(points={{6,-68},{14,-68}}));
      connect(T42_iX2.terminalA, T41_iX2.terminalA)
        annotation (Line(points={{-14,-68},{-24,-68},{-24,-72}}));
      connect(T41_iX2.terminalA, T4_iX2.terminalA) annotation (
        Line(points={{-24,-72},{-24,-64}}));
      connect(Teq31_3.terminalB, bus3.terminal) annotation (
        Line(points={{-106,-34},{-102,-34},{-102,-33.5},{-95.5,-33.5}}));
      connect(L3_2.terminalA, bus3.terminal) annotation (
        Line(points={{-81,-11},{-88,-11},{-88,-33.5},{-95.5,-33.5}}));
      connect(L3_4.terminalA, bus3.terminal) annotation (
        Line(points={{-81.5,-51},{-88,-51},{-88,-33.5},{-95.5,-33.5}}));
      connect(pq21.terminal, T21_i.terminalB)
        annotation (Line(points={{0,48},{0,36},{4,36}}));
      connect(T41_iX2.terminalB, pq41.terminal)
        annotation (Line(points={{-24,-92},{-24,-95},{-41,-95}}));
      connect(pq31.terminal, bus31.terminal) annotation (Line(points={{-142.5,
              -57},{-141.5,-57},{-141.5,-43.5}},
                                           color={0,0,0}));
      connect(bus31.terminal, Teq31_3.terminalA) annotation (Line(points={{-141.5,
              -43.5},{-141.5,-34},{-126,-34}},
                                        color={0,0,0}));
      connect(T31_33_1.terminalA, T31_33_2.terminalA) annotation (Line(points={{-148,-2},
              {-148,4},{-130,4},{-130,-2}},           color={0,0,0}));
      connect(bus33.terminal, T31_33_2.terminalA) annotation (Line(points={{-139.5,
              20.5},{-139.5,10},{-138,10},{-138,4},{-130,4},{-130,-2}},
                     color={0,0,0}));
      connect(bus2.terminal, T2_i.terminalB) annotation (Line(points={{-31.5,
              -11.5},{-20,-11.5},{-20,-22},{4,-22},{4,-16}}, color={0,0,0}));
      connect(bus2.terminal, L2_1.terminalB) annotation (Line(points={{-31.5,
              -11.5},{-52.5,-11.5},{-52.5,-0.5}},  color={0,0,0}));
      connect(gen33x2.terminal, bus33.terminal) annotation (Line(points={{-140,44},
              {-140,20.5},{-139.5,20.5}},        color={0,0,0}));
      connect(gen11x2.terminal, bus11.terminal) annotation (Line(points={{-52,84},
              {-51.5,84},{-51.5,68.5}},     color={0,0,0}));
      connect(bus11.terminal, T1_11_1.terminalA) annotation (Line(points={{-51.5,
              68.5},{-51.5,60},{-61.5,60},{-61.5,57.5}},       color={0,0,0}));
      connect(T22_i.terminalB, bus22.terminal) annotation (Line(points={{32,4},{
              32,4.5},{42.5,4.5}},           color={0,0,0}));
      connect(bus22.terminal, sc22.terminal) annotation (Line(points={{42.5,
              4.5},{44,4.5},{44,4},{64,4}},         color={0,0,0}));
      connect(bus42.terminal, gen42x2.terminal) annotation (Line(points={{14,
              -68},{34,-68},{34,-82}}, color={0,0,0}));
      connect(gen42x2.omega, systemPowerGrids.omegaRefIn) annotation (Line(
            points={{45,-82},{45,-81.8},{54.2,-81.8}}, color={0,0,127}));
      connect(L3_4.terminalB, L4_2.terminalB) annotation (Line(points={{-61.5,
              -51},{-52,-51},{-52,-41}}, color={0,0,0}));
      connect(bus4.terminal, L4_2.terminalB) annotation (Line(points={{-41.5,
              -47.5},{-52,-47.5},{-52,-41}}, color={0,0,0}));
      connect(T4_iX2.terminalB, bus4.terminal) annotation (Line(points={{-24,
              -44},{-34,-44},{-34,-47.5},{-41.5,-47.5}}, color={0,0,0}));
      annotation (
        Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}})),
        Diagram(coordinateSystem(extent={{-160,-100},{80,100}})),
        experiment(StopTime = 6, Interval = 0.00400267, Tolerance = 1e-06, StartTime = 0),
        __OpenModelica_simulationFlags(lv = "LOG_STATS", outputFormat = "mat", s = "dassl"),
        Documentation(info="<html>
<p>Model with data linked with PowerFlow.</p>
<p>All initial voltages have the same values as in PowerFlowSI</p>
<p>Here we see the effects of a (three-phase) fault at bus 1 between t= 0.5 and 0.6s.</p>
<p>In this example the machines have regulators, and therefore the transient much better damped than Bus1Faultunregulated and the final voltages and frequency are much nearerto the original values.</p>
<p>See for instance the AC node (1, 2, 3, 4) voltages, and the values of omegaPU variables of gen11x2, gen22x2, gen42x2, sc22.</p>
<p>NOTE. For convergenze reasons the Synchronous Compensator model contains a ficticious governor which commands some input power to generator. This does not affect the results, since the actual mechanical power is very negligible, as can be seen looking at PmPu inside sc22.GEN, which is at most 0.04 p.u., i.e., 40 kW, very near to zero for a 60 MVA machine. The SC, however, contributes significantly to electrical active power fluxes, because power goes back and forth from its inertia. This can be seen looking at sc22,GEN.port.P.</p>
</html>"));
    end Bus1FaultSIregulated;
    annotation (Documentation(info="<html>
<p>This is a much larger example than BasicGrid.</p>
<p>It is derived from realistic data originally collected by prof. Luigi Paris of the Unviersity of Pisa, and adapted to Modelica by prof. Massimo Ceraolo, also from the University ot Pisa.</p>
<p>The same network is used for Power Flow and transient; the transients start as initial condition from the PowerFlow results.</p>
<p>The network has generators, transformers, loads and a synchronous compensator.</p>
<p>The considered network contained three-winding transformers. Since PowergridsMC library does not contain models for these transformers, they are approximated, as common by three two-winding transfomers in star (power flow ) or delta (transient) configurations.</p>
<p>Bus names with two digits are somehow &quot;subbuses&quot; of the main AT buses, which are bus1, bus2, bus3, bus4. For instance bus31 and , bus33 are sub-buses of bus3, and would have been called bus3.1, , bus3.3, if the latter were valid Modelica instance names (bus32 is missing because of simplifications made on the original model).</p>
<p>******************</p>
<p>See info of individual models for details.</p>
</html>"));
  end FourATbus;

  package IEEE14
    model PowerFlowSI "Power flow model of the IEEE 14-bus benchmark"
      extends Modelica.Icons.Example;
        Modelica.Units.SI.Power totalLosses=-(
          Load2.port.P+Load3.port.P+Load4.port.P+
          Load5.port.P+Load6.port.P+Load9.port.P+
          Load10.port.P+Load11.port.P+Load12.port.P+
          Load13.port.P+Load13.port.P+
          GEN1.port.P+GEN2.port.P);

      inner PowerGridsMC.Electrical.System systemPowerGrids(showDataOnDiagramsPu=false)
                                                            annotation (
        Placement(transformation(origin={134,90},     extent = {{-10, -10}, {10, 10}})));

    // Buses
      PowerGridsMC.Electrical.PowerFlow.SlackBusW bus1(
        SNom = 100e6,
        U = 69e3*1.0598,
        UNom = 69000)
        annotation (
        Placement(visible = true, transformation(origin={-142,-4},   extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Buses.Bus bus2(
        SNom = 100e6,
        UNom = 69e3)
        annotation (
        Placement(visible = true, transformation(origin={-88,-78},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Buses.Bus bus3(
        SNom = 100e6,
        UNom = 69e3)
        annotation (
        Placement(visible = true, transformation(origin={88,-80},     extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Buses.Bus bus4(
        SNom = 100e6,
        UNom = 69e3)
        annotation (
        Placement(visible = true, transformation(origin={82,-40},     extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Buses.Bus bus5(
        SNom = 100e6,
        UNom = 69e3)
        annotation (
        Placement(visible = true, transformation(origin={-46,-40},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Buses.Bus bus6(
        SNom = 100e6,
        UNom = 13.8e3)
        annotation (
        Placement(visible = true, transformation(origin={-46,0},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Buses.Bus bus7(
        SNom = 100e6,
        UNom = 13.8e3)
        annotation (
        Placement(visible = true, transformation(origin={88,0},     extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Buses.Bus bus8(
        SNom = 100e6,
        UNom = 13.8e3)
        annotation (
        Placement(visible = true, transformation(origin={128,20},    extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      PowerGridsMC.Electrical.Buses.Bus bus9(
        SNom = 100e6,
        UNom = 13.8e3)
        annotation (
        Placement(visible = true, transformation(origin={78,40},     extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Buses.Bus bus10(
        SNom = 100e6,
        UNom = 13.8e3)
        annotation (
        Placement(visible = true, transformation(origin={24,40},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Buses.Bus bus11(
        SNom = 100e6,
        UNom = 13.8e3)
        annotation (
        Placement(visible = true, transformation(origin={-26,40},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Buses.Bus bus12(
        SNom = 100e6,
        UNom = 13.8e3)
        annotation (
        Placement(visible = true, transformation(origin={-106,80},   extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Buses.Bus bus13(
        SNom = 100e6,
        UNom = 13.8e3)
        annotation (
        Placement(visible = true, transformation(origin={-46,80},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Buses.Bus bus14(
        SNom = 100e6,
        UNom = 13.8e3)
        annotation (
        Placement(visible = true, transformation(origin={14,80},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));

    // Lines
      PowerGridsMC.Electrical.Branches.LineConstantImpedance L1to2(
        portVariablesPhases = true,
        R = 0.922682,
        X = 2.81708,
        G = 0,
        B = 0.00110901,
        SNom = 100e6,
        UNom = 69e3)
        annotation (
        Placement(visible = true, transformation(origin={-148,-30},    extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      PowerGridsMC.Electrical.Branches.LineConstantImpedanceWithBreakers L1to5(
        portVariablesPhases = true,
        useBreakerA=false,
        useBreakerB=false,
        R = 2.57237,
        X = 10.6189,
        B = 0.0010334,
        G = 0,
        SNom=100000000,
        UNom=69000)
        annotation (
        Placement(visible = true, transformation(origin={-102,-46},   extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Branches.LineConstantImpedance L2to3(
        portVariablesPhases = true,
        R = 2.23719,
        X = 9.42535,
        G = 0,
        B = 0.000919975,
        SNom=100000000,
        UNom=69000,
        showPortData=true)
        annotation (
        Placement(visible = true, transformation(origin={-16,-90},  extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Branches.LineConstantImpedance L2to4(
        portVariablesPhases = true,
        R = 2.76662,
        X = 8.3946,
        G = 0,
        B = 0.000714136,
        SNom = 100e6,
        UNom = 69e3)
        annotation (
        Placement(visible = true, transformation(origin={24,-70},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Branches.LineConstantImpedance L2to5(
        portVariablesPhases = true,
        R = 2.71139,
        X = 8.27843,
        G = 0,
        B = 0.000726738,
        SNom = 100e6,
        UNom = 69e3)
        annotation (
        Placement(visible = true, transformation(origin={-68,-60},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Branches.LineConstantImpedance L3to4(
        portVariablesPhases = true,
        R = 3.19035,
        X = 8.14274,
        G = 0,
        B = 0.000268851,
        SNom = 100e6,
        UNom = 69e3)
        annotation (
        Placement(visible = true, transformation(origin={88,-60},     extent = {{10, -10}, {-10, 10}}, rotation = -90)));
      PowerGridsMC.Electrical.Branches.LineConstantImpedance L4to5(
        portVariablesPhases = true,
        R = 0.635593,
        X = 2.00486,
        G = 0,
        B = 0,
        SNom = 100e6,
        UNom = 69e3)
        annotation (
        Placement(visible = true, transformation(origin={24,-52},    extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Branches.LineConstantImpedance L6to11(
        portVariablesPhases = true,
        R = 0.18088,
        X = 0.378785,
        G = 0,
        B = 0,
        SNom = 100e6,
        UNom = 13.8e3)
        annotation (
        Placement(visible = true, transformation(origin={-26,20},    extent = {{10, -10}, {-10, 10}}, rotation = -90)));
      PowerGridsMC.Electrical.Branches.LineConstantImpedance L6to12(
        portVariablesPhases = true,
        R = 0.23407,
        X = 0.487165,
        G = 0,
        B = 0,
        SNom = 100e6,
        UNom = 13.8e3)
        annotation (
        Placement(visible = true, transformation(origin={-76,60},    extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Branches.LineConstantImpedance L6to13(
        portVariablesPhases = true,
        R = 0.125976,
        X = 0.248086,
        G = 0,
        B = 0,
        SNom = 100e6,
        UNom = 13.8e3)
        annotation (
        Placement(visible = true, transformation(origin={-46,62},    extent = {{10, -10}, {-10, 10}}, rotation = -90)));
      PowerGridsMC.Electrical.Branches.LineConstantImpedance L7to8(
        portVariablesPhases = true,
        R = 0,
        X = 0.33546,
        G = 0,
        B = 0,
        SNom = 100e6,
        UNom = 13.8e3)
        annotation (
        Placement(visible = true, transformation(origin={108,20},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Branches.LineConstantImpedance L7to9(
        portVariablesPhases = true,
        R = 0,
        X = 0.209503,
        G = 0,
        B = 0,
        SNom = 100e6,
        UNom = 13.8e3)
        annotation (
        Placement(visible = true, transformation(origin={82,20},     extent = {{10, -10}, {-10, 10}}, rotation = -90)));
      PowerGridsMC.Electrical.Branches.LineConstantImpedance L9to10(
        portVariablesPhases = true,
        R = 0.060579,
        X = 0.160922,
        G = 0,
        B = 0,
        SNom = 100e6,
        UNom = 13.8e3)
        annotation (
        Placement(visible = true, transformation(origin={46,26},    extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Branches.LineConstantImpedance L9to14(
        portVariablesPhases = true,
        R = 0.242068,
        X = 0.514912,
        G = 0,
        B = 0,
        SNom = 100e6,
        UNom = 13.8e3)
        annotation (
        Placement(visible = true, transformation(origin={48,72},    extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Branches.LineConstantImpedance L10to11(
        portVariablesPhases = true,
        R = 0.156256,
        X = 0.365778,
        G = 0,
        B = 0,
        SNom = 100e6,
        UNom = 13.8e3)
        annotation (
        Placement(visible = true, transformation(origin={4,26},     extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Branches.LineConstantImpedance L12to13(
        portVariablesPhases = true,
        R = 0.42072,
        X = 0.380651,
        G = 0,
        B = 0,
        SNom=100000000,
        UNom=13800,
        showPortData=true)
        annotation (
        Placement(visible = true, transformation(origin={-76,72},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Branches.LineConstantImpedance L13to14(
        portVariablesPhases = true,
        R = 0.325519,
        X = 0.662763,
        G = 0,
        B = 0,
        SNom = 100e6,
        UNom = 13.8e3)
        annotation (
        Placement(visible = true, transformation(origin={-16,72},  extent = {{-10, -10}, {10, 10}}, rotation = 0)));

    // LOADS
      PowerGridsMC.Electrical.PowerFlow.PQBusW Load2(
        portVariablesPhases = true,
        P = 21.7e6,
        Q = 12.7e6,
        SNom = 100e6,
        UNom = 69e3)
        annotation (
        Placement(visible = true, transformation(origin={-88,-100},   extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.PowerFlow.PQBusW Load3(
        portVariablesPhases = true,
        P = 94.2e6,
        Q = 19.1e6,
        SNom = 100e6,
        UNom = 69e3)
        annotation (
        Placement(visible = true, transformation(origin={88,-98},     extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.PowerFlow.PQBusW Load4(
        portVariablesPhases = true,
        P = 47.8e6,
        Q = -3.9e6,
        SNom = 100e6,
        UNom = 69e3)
        annotation (
        Placement(visible = true, transformation(origin={112,-54},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.PowerFlow.PQBusW Load5(
        portVariablesPhases = true,
        P = 7.6e6,
        Q = 1.6e6,
        SNom = 100e6,
        UNom = 69e3)
        annotation (
        Placement(visible = true, transformation(origin={-74,-26},    extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      PowerGridsMC.Electrical.PowerFlow.PQBusW Load6(
        portVariablesPhases = true,
        P = 11.2e6,
        Q = 7.5e6,
        SNom = 100e6,
        UNom = 13.8e3)
        annotation (
        Placement(visible = true, transformation(origin={-26,-14},    extent={{10,-10},
                {-10,10}},                                                                             rotation = 0)));
      PowerGridsMC.Electrical.PowerFlow.PQBusW Load9(
        portVariablesPhases = true,
        showPortData=true,
        P = 29.5e6,
        Q = 16.6e6,
        SNom=100000000,
        UNom=13800)
        annotation (
        Placement(visible = true, transformation(origin={106,56},    extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      PowerGridsMC.Electrical.PowerFlow.PQBusW Load10(
        portVariablesPhases = true,
        P = 9e6,
        Q = 5.8e6,
        SNom = 100e6,
        UNom = 13.8e3)
        annotation (
        Placement(visible = true, transformation(origin={24,52},    extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      PowerGridsMC.Electrical.PowerFlow.PQBusW Load11(
        portVariablesPhases = true,
        P = 3.5e6,
        Q = 1.8e6,
        SNom = 100e6,
        UNom = 13.8e3)
        annotation (
        Placement(visible = true, transformation(origin={-24,52},    extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      PowerGridsMC.Electrical.PowerFlow.PQBusW Load12(
        portVariablesPhases = true,
        P=6100000,
        Q=1600000,
        SNom=100000000,
        UNom=13800,
        showPortData=true)
        annotation (
        Placement(visible = true, transformation(origin={-106,94},   extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      PowerGridsMC.Electrical.PowerFlow.PQBusW Load13(
        portVariablesPhases = true,
        P=13800000,
        Q=5800000,
        SNom=100000000,
        UNom=13800,
        showPortData=true)
        annotation (
        Placement(visible = true, transformation(origin={-46,94},    extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      PowerGridsMC.Electrical.PowerFlow.PQBusW Load14(
        portVariablesPhases = true,
        P=14900000,
        Q=5000000,
        SNom=100000000,
        UNom=13800,
        showPortData=true)
        annotation (
        Placement(visible = true, transformation(origin={14,94},    extent = {{-10, -10}, {10, 10}}, rotation = 180)));

    // Capacitor bank
      PowerGridsMC.Electrical.Banks.CapacitorBankFixed Cbank9(
        portVariablesPhases = true,
        showPortData=true,
        B = 0.099769,
        SNom=100000000,
        UNom=13800)
        annotation (
        Placement(visible = true, transformation(origin={84,56},     extent = {{-10, -10}, {10, 10}}, rotation = 180)));

    // Transformers
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio T4to7(
        portVariablesPhases=true,
        R=0,
        X=0.398248,
        B=0,
        G=0,
        rFixed=0.204082,
        SNom=100e6,
        UNomA=69e3,
        UNomB=13.8e3) annotation (Placement(visible=true, transformation(
            origin={88,-18},
            extent={{10,10},{-10,-10}},
            rotation=-90)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio T4to9(
        portVariablesPhases=true,
        R=0,
        X=1.05919,
        B=0,
        G=0,
        rFixed=0.208333,
        SNom=100e6,
        UNomA=69.0e3,
        UNomB=13.8e3) annotation (Placement(visible=true, transformation(
            origin={76,-18},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio T5to6(
        portVariablesPhases=true,
        R=0,
        X=0.479948,
        B=0,
        G=0,
        rFixed=0.212766,
        SNom=100e6,
        UNomA=69e3,
        UNomB=13.8e3) annotation (Placement(visible=true, transformation(
            origin={-46,-20},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio Tgen1(
        portVariablesPhases=true,
        R=0,
        X=0.393146,
        B=0,
        G=0,
        rFixed=2.875,
        SNom=1211e6,
        UNomA=24e3,
        UNomB=69e3) annotation (Placement(visible=true, transformation(
            origin={-142,20},
            extent={{-10,-10},{10,10}},
            rotation=-90)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatioWithBreaker Tgen2(
        portVariablesPhases = true,
        R = 0,
        X = 0.425089,
        B = 0,
        G = 0,
        rFixed = 2.875,
        SNom = 1120e6,
        UNomA = 24e3,
        UNomB = 69e3)
        annotation (
        Placement(visible = true, transformation(origin={-112,-92},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio Tgen3(
        portVariablesPhases=true,
        R=0,
        X=0.288545,
        B=0,
        G=0,
        rFixed=3.45,
        SNom=1650e6,
        UNomA=20e3,
        UNomB=69e3) annotation (Placement(visible=true, transformation(
            origin={118,-90},
            extent={{10,-10},{-10,10}},
            rotation=0)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio Tgen8(
        portVariablesPhases=true,
        R=0,
        X=0.076176,
        B=0,
        G=0,
        rFixed=0.766667,
        SNom=250e6,
        UNomA=18e3,
        UNomB=13.8e3) annotation (Placement(visible=true, transformation(
            origin={148,0},
            extent={{-10,-10},{10,10}},
            rotation=90)));

    // Generators
      PowerGridsMC.Electrical.PowerFlow.PVBusW GEN1(
        portVariablesPhases = true,
        SNom=1211000000,
        UNom=24000,
        P(displayUnit="MW") = -234000000.0,
        U(displayUnit="kV") = 25575.0)
        annotation (
        Placement(transformation(origin = {-142, 46}, extent = {{10, -10}, {-10, 10}}, rotation = -180)));
      PowerGridsMC.Electrical.PowerFlow.PVBusW GEN2(
        portVariablesPhases = true,
        SNom=1120000000,
        UNom=24000,
        U=24000,
        P=-40000000)
        annotation (
        Placement(visible = true, transformation(origin={-138,-92},    extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      PowerGridsMC.Electrical.PowerFlow.PVBusW GEN3(
        portVariablesPhases = true,
        SNom=1650000000,
        UNom=20000,
        U=20000,
        P=0)
        annotation (
        Placement(visible = true, transformation(origin={142,-90},    extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      PowerGridsMC.Electrical.PowerFlow.PVBusW GEN6(
        portVariablesPhases = true,
        SNom=80000000,
        UNom=13800,
        U=13800,
        P = 0)
        annotation (
        Placement(visible = true, transformation(origin={-86,0},      extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      PowerGridsMC.Electrical.PowerFlow.PVBusW GEN8(
        portVariablesPhases = true,
        SNom=250000000,
        UNom=18000,
        U=18000,
        P = 0)
        annotation (
        Placement(visible = true, transformation(origin={148,-26},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));

    equation
      connect(bus12.terminal, L6to12.terminalB) annotation (
        Line(points={{-106,80},{-106,60},{-86,60}}));
      connect(L12to13.terminalA, bus12.terminal) annotation (
        Line(points={{-86,72},{-106,72},{-106,80}}));
      connect(L12to13.terminalB, bus13.terminal) annotation (
        Line(points={{-66,72},{-52,72},{-52,80},{-46,80}}));
      connect(L6to12.terminalA, bus6.terminal) annotation (
        Line(points={{-66,60},{-52,60},{-52,0},{-46,0}}));
      connect(L6to13.terminalA, bus6.terminal) annotation (
        Line(points={{-46,52},{-46,0}}));
      connect(L6to13.terminalB, bus13.terminal) annotation (
        Line(points={{-46,72},{-46,80}}));
      connect(bus13.terminal, L6to13.terminalB) annotation (
        Line(points={{-46,80},{-46,72}}));
      connect(L6to11.terminalA, bus6.terminal) annotation (
        Line(points={{-26,10},{-26,6},{-40,6},{-40,0},{-46,0}}));
      connect(L6to11.terminalB, bus11.terminal) annotation (
        Line(points={{-26,30},{-26,40}}));
      connect(L13to14.terminalA, bus13.terminal) annotation (
        Line(points={{-26,72},{-40,72},{-40,80},{-46,80}}));
      connect(L13to14.terminalB, bus14.terminal) annotation (
        Line(points={{-6,72},{8,72},{8,80},{14,80}}));
      connect(L9to14.terminalB, bus14.terminal) annotation (
        Line(points={{38,72},{20,72},{20,80},{14,80}}));
      connect(L9to14.terminalA, bus9.terminal) annotation (
        Line(points={{58,72},{62,72},{62,70},{64,70},{64,40},{78,40}}));
      connect(L10to11.terminalB, bus11.terminal) annotation (
        Line(points={{-6,26},{-14,26},{-14,38},{-26,38},{-26,40}}));
      connect(L10to11.terminalA, bus10.terminal) annotation (
        Line(points={{14,26},{22,26},{22,40},{24,40}}));
      connect(L9to10.terminalB, bus10.terminal) annotation (
        Line(points={{36,26},{28,26},{28,40},{24,40}}));
      connect(L9to10.terminalA, bus9.terminal) annotation (
        Line(points={{56,26},{72,26},{72,40},{78,40}}));
      connect(L7to8.terminalA, bus7.terminal) annotation (
        Line(points={{98,20},{94,20},{94,0},{88,0}}));
      connect(L7to9.terminalA, bus7.terminal) annotation (
        Line(points={{82,10},{82,0},{88,0}}));
      connect(L7to9.terminalB, bus9.terminal) annotation (
        Line(points={{82,30},{82,40},{78,40}}));
      connect(L7to8.terminalB, bus8.terminal) annotation (
        Line(points={{118,20},{128,20}}));
      connect(T4to9.terminalA, bus4.terminal) annotation (
        Line(points={{76,-28},{76,-40},{82,-40}}));
      connect(T4to9.terminalB, bus9.terminal) annotation (
        Line(points={{76,-8},{76,40},{78,40}}));
      connect(T5to6.terminalB, bus6.terminal) annotation (
        Line(points={{-46,-10},{-46,0}}));
      connect(T5to6.terminalA, bus5.terminal) annotation (
        Line(points={{-46,-30},{-46,-40}}));
      connect(L1to2.terminalA, bus1.terminal) annotation (
        Line(points={{-148,-20},{-148,-4},{-142,-4}}));
      connect(L1to2.terminalB, bus2.terminal) annotation (
        Line(points={{-148,-40},{-148,-70},{-90,-70},{-90,-78},{-88,-78}}));
      connect(L1to5.terminalA, bus1.terminal) annotation (
        Line(points={{-112,-46},{-134,-46},{-134,-4},{-142,-4}}));
      connect(L1to5.terminalB, bus5.terminal) annotation (
        Line(points={{-92,-46},{-52,-46},{-52,-40},{-46,-40}}));
      connect(L2to5.terminalB, bus5.terminal) annotation (
        Line(points={{-58,-60},{-46,-60},{-46,-40}}));
      connect(L4to5.terminalB, bus5.terminal) annotation (
        Line(points={{14,-52},{-40,-52},{-40,-40},{-46,-40}}));
      connect(L2to5.terminalA, bus2.terminal) annotation (
        Line(points={{-78,-60},{-88,-60},{-88,-78}}));
      connect(L2to4.terminalA, bus2.terminal) annotation (
        Line(points={{14,-70},{-80,-70},{-80,-78},{-88,-78}}));
      connect(L3to4.terminalB, bus4.terminal) annotation (
        Line(points={{88,-50},{88,-40},{82,-40}}));
      connect(L3to4.terminalA, bus3.terminal) annotation (
        Line(points={{88,-70},{88,-80}}));
      connect(L2to4.terminalB, bus4.terminal) annotation (
        Line(points={{34,-70},{82,-70},{82,-40}}));
      connect(L4to5.terminalA, bus4.terminal) annotation (
        Line(points={{34,-52},{76,-52},{76,-40},{82,-40}}));
      connect(L2to3.terminalB, bus3.terminal) annotation (
        Line(points={{-6,-90},{82,-90},{82,-80},{88,-80}}));
      connect(Tgen8.terminalB, bus8.terminal) annotation (
        Line(points={{148,10},{148,20},{128,20}}));
      connect(Tgen3.terminalB, bus3.terminal) annotation (
        Line(points={{108,-90},{96,-90},{96,-80},{88,-80}}));
      connect(Tgen2.terminalB, bus2.terminal) annotation (
        Line(points={{-102,-92},{-92,-92},{-92,-78},{-88,-78}}));
      connect(Tgen1.terminalB, bus1.terminal) annotation (
        Line(points={{-142,10},{-142,-4}}));
      connect(Load12.terminal, bus12.terminal) annotation (
        Line(points={{-106,94},{-106,80}}));
      connect(bus13.terminal, Load13.terminal) annotation (
        Line(points={{-46,80},{-46,94}}));
      connect(Load14.terminal, bus14.terminal) annotation (
        Line(points={{14,94},{14,80}}));
      connect(Load11.terminal, bus11.terminal) annotation (
        Line(points={{-24,52},{-24,44},{-26,44},{-26,40}}));
      connect(Load10.terminal, bus10.terminal) annotation (
        Line(points={{24,52},{24,40}}));
      connect(Cbank9.terminal, bus9.terminal) annotation (
        Line(points={{84,56},{84,48},{78,48},{78,40}}));
      connect(Load9.terminal, bus9.terminal) annotation (
        Line(points={{106,56},{106,46},{96,46},{96,40},{78,40}}));
      connect(Load6.terminal, bus6.terminal) annotation (
        Line(points={{-26,-14},{-26,-6},{-40,-6},{-40,0},{-46,0}}));
      connect(Load5.terminal, bus5.terminal) annotation (
        Line(points={{-74,-26},{-74,-34},{-64,-34},{-64,-40},{-46,-40}}));
      connect(Load3.terminal, bus3.terminal) annotation (
        Line(points={{88,-98},{88,-80}}));
      connect(Load2.terminal, bus2.terminal) annotation (
        Line(points={{-88,-100},{-88,-78}}));
      connect(L2to3.terminalA, bus2.terminal) annotation (
        Line(points={{-26,-90},{-80,-90},{-80,-78},{-88,-78}}));
      connect(Tgen1.terminalA, GEN1.terminal) annotation (
        Line(points={{-142,30},{-142,46}}));
      connect(GEN2.terminal, Tgen2.terminalA) annotation (
        Line(points={{-138,-92},{-122,-92}}));
      connect(Tgen3.terminalA, GEN3.terminal) annotation (
        Line(points={{128,-90},{142,-90}}));
      connect(GEN8.terminal, Tgen8.terminalA) annotation (
        Line(points={{148,-26},{148,-10}}));
      connect(Load4.terminal, bus4.terminal) annotation (
        Line(points={{112,-54},{112,-42},{90,-42},{90,-40},{82,-40}}));
      connect(GEN6.terminal, bus6.terminal) annotation (
        Line(points={{-86,0},{-46,0}}));
      connect(T4to7.terminalA, bus4.terminal) annotation (
        Line(points={{88,-28},{88,-40},{82,-40}}));
      connect(T4to7.terminalB, bus7.terminal) annotation (
        Line(points={{88,-8},{88,0}}));
      annotation (
        Diagram(coordinateSystem(extent={{-160,-120},{160,120}}), graphics={
           Text(
              extent={{78,98},{100,92}},
              lineColor={238,46,47},
              textString=DynamicSelect("Plost",
              String(totalLosses/1e6, format = "8.2f"))),
            Rectangle(
              extent={{52,106},{102,90}},
              lineColor={28,108,200},
              lineThickness=1),
            Text(
              extent={{48,104},{104,98}},
              textColor={238,46,47},
              textString="Total losses (MW):")}

),      experiment(
          Interval=0.002,
          Tolerance=1e-07,
          __Dymola_Algorithm="Dassl"),
        __OpenModelica_commandLineOptions = "--daeMode --tearingMethod=minimalTearing",
        __OpenModelica_simulationFlags(nls="kinsol", lv="LOG_INIT_HOMOTOPY"),
        Documentation(info="<html>
<p><i><span style=\"font-family: Arial; font-size: 12pt;\">Library PowerGridsMC was forked from https://github.com/PowerGrids/PowerGrids on 22 November 2024.</span></i></p>
<p>************************** </p>
<p>This model is derived from the original IEEE14busPowerFlow, which did not have any information on its info section.</p>
<p>This model is different in that it saves the PowerFlow on disk for all PQ , PV, slack nodes, using as file names the model instance names.</p>
<p>This technique allows to reuse these output as initial values for subsequent transients, e.g. those proposed in StaticNetworkUnreg model.</p>
</html>"));
    end PowerFlowSI;

    model StaticNetworkUnreg
      "Dynamic model of the IEEE 14-bus system, operating in steady-state"
      extends Modelica.Icons.Example;
      inner PowerGridsMC.Electrical.System systemPowerGrids(initOpt = PowerGridsMC.Types.Choices.InitializationOption.globalSteadyStateFixedPowerFlow, referenceFrequency = PowerGridsMC.Types.Choices.ReferenceFrequency.fixedReferenceGenerator,
        showDataOnDiagramsPu=false)                                                                                                                                                                                                         annotation (
        Placement(transformation(origin={-146,80},    extent = {{-10, -10}, {10, 10}})));
      // Buses
      PowerGridsMC.Electrical.Buses.ReferenceBusR bus1(SNom = 100e6, UNom = 69e3) annotation (
        Placement(transformation(origin={-138,0},    extent = {{-10, -10}, {10, 10}})));
      PowerGridsMC.Electrical.Buses.Bus bus2(SNom = 100e6, UNom = 69e3) annotation (
        Placement(visible = true, transformation(origin={-104,-80},   extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Buses.Bus bus3(SNom = 100e6, UNom = 69e3) annotation (
        Placement(visible = true, transformation(origin={104,-80},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Buses.Bus bus4(SNom = 100e6, UNom = 69e3) annotation (
        Placement(visible = true, transformation(origin={98,-40},     extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Buses.Bus bus5(SNom = 100e6, UNom = 69e3) annotation (
        Placement(visible = true, transformation(origin={-44,-40},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Buses.Bus bus6(SNom = 100e6, UNom = 13.8e3) annotation (
        Placement(visible = true, transformation(origin={-44,0},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Buses.Bus bus7(SNom = 100e6, UNom = 13.8e3) annotation (
        Placement(visible = true, transformation(origin={106,0},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Buses.Bus bus8(SNom = 100e6, UNom = 13.8e3) annotation (
        Placement(visible = true, transformation(origin={144,20},    extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      PowerGridsMC.Electrical.Buses.Bus bus9(SNom = 100e6, UNom = 13.8e3) annotation (
        Placement(visible = true, transformation(origin={94,40},     extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Buses.Bus bus10(SNom = 100e6, UNom = 13.8e3) annotation (
        Placement(visible = true, transformation(origin={26,42},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Buses.Bus bus11(SNom = 100e6, UNom = 13.8e3) annotation (
        Placement(visible = true, transformation(origin={-24,40},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Buses.Bus bus12(SNom = 100e6, UNom = 13.8e3) annotation (
        Placement(visible = true, transformation(origin={-104,80},   extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Buses.Bus bus13(SNom = 100e6, UNom = 13.8e3) annotation (
        Placement(visible = true, transformation(origin={-44,80},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Buses.Bus bus14(SNom = 100e6, UNom = 13.8e3) annotation (
        Placement(visible = true, transformation(origin={16,80},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      // Lines
      PowerGridsMC.Electrical.Branches.LineConstantImpedance L1to2(portVariablesPhases = true, R = 0.922682, X = 2.81708, G = 0, B = 0.00110901, SNom = 100e6, UNom = 69e3) annotation (
        Placement(transformation(origin={-144,-30},    extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      PowerGridsMC.Electrical.Branches.LineConstantImpedanceWithBreakers L1to5(portVariablesPhases = true, R = 2.57237, X = 10.6189, G = 0, B = 0.0010334, SNom = 100e6, UNom = 69e3) annotation (
        Placement(visible = true, transformation(origin={-104,-52},   extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Branches.LineConstantImpedance L2to3(portVariablesPhases = true, R = 2.23719, X = 9.42535, G = 0, B = 0.000919975, SNom = 100e6, UNom = 69e3) annotation (
        Placement(visible = true, transformation(origin={-14,-90},  extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Branches.LineConstantImpedance L2to4(portVariablesPhases = true, R = 2.76662, X = 8.3946, G = 0, B = 0.000714136, SNom = 100e6, UNom = 69e3) annotation (
        Placement(visible = true, transformation(origin={26,-70},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Branches.LineConstantImpedance L2to5(portVariablesPhases = true, R = 2.71139, X = 8.27843, G = 0, B = 0.000726738, SNom = 100e6, UNom = 69e3) annotation (
        Placement(visible = true, transformation(origin={-74,-62},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Branches.LineConstantImpedance L3to4(portVariablesPhases = true, R = 3.19035, X = 8.14274, G = 0, B = 0.000268851, SNom = 100e6, UNom = 69e3) annotation (
        Placement(visible = true, transformation(origin={104,-60},    extent = {{10, -10}, {-10, 10}}, rotation = -90)));
      PowerGridsMC.Electrical.Branches.LineConstantImpedance L4to5(portVariablesPhases = true, R = 0.635593, X = 2.00486, G = 0, B = 0, SNom = 100e6, UNom = 69e3) annotation (
        Placement(visible = true, transformation(origin={26,-52},    extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Branches.LineConstantImpedance L6to11(portVariablesPhases = true, R = 0.18088, X = 0.378785, G = 0, B = 0, SNom = 100e6, UNom = 13.8e3) annotation (
        Placement(visible = true, transformation(origin={-24,20},    extent = {{10, -10}, {-10, 10}}, rotation = -90)));
      PowerGridsMC.Electrical.Branches.LineConstantImpedance L6to12(R = 0.23407, portVariablesPhases = true, X = 0.487165, G = 0, B = 0, SNom = 100e6, UNom = 13.8e3) annotation (
        Placement(visible = true, transformation(origin={-74,60},    extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Branches.LineConstantImpedance L6to13(portVariablesPhases = true, R = 0.125976, X = 0.248086, G = 0, B = 0, SNom = 100e6, UNom = 13.8e3) annotation (
        Placement(visible = true, transformation(origin={-44,62},    extent = {{10, -10}, {-10, 10}}, rotation = -90)));
      PowerGridsMC.Electrical.Branches.LineConstantImpedance L7to8(portVariablesPhases = true, R = 0, X = 0.33546, G = 0, B = 0, SNom = 100e6, UNom = 13.8e3) annotation (
        Placement(visible = true, transformation(origin={124,20},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Branches.LineConstantImpedance L7to9(portVariablesPhases = true, R = 0, X = 0.209503, G = 0, B = 0, SNom = 100e6, UNom = 13.8e3) annotation (
        Placement(visible = true, transformation(origin={98,22},     extent = {{10, -10}, {-10, 10}}, rotation = -90)));
      PowerGridsMC.Electrical.Branches.LineConstantImpedance L9to10(portVariablesPhases = true, R = 0.060579, X = 0.160922, G = 0, B = 0, SNom = 100e6, UNom = 13.8e3) annotation (
        Placement(visible = true, transformation(origin={48,28},    extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Branches.LineConstantImpedance L9to14(portVariablesPhases = true, R = 0.242068, X = 0.514912, G = 0, B = 0, SNom = 100e6, UNom = 13.8e3) annotation (
        Placement(visible = true, transformation(origin={56,72},    extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Branches.LineConstantImpedance L10to11(portVariablesPhases = true, R = 0.156256, X = 0.365778, G = 0, B = 0, SNom = 100e6, UNom = 13.8e3) annotation (
        Placement(visible = true, transformation(origin={4,28},     extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Branches.LineConstantImpedance L12to13(portVariablesPhases = true, R = 0.42072, X = 0.380651, G = 0, B = 0, SNom = 100e6, UNom = 13.8e3) annotation (
        Placement(visible = true, transformation(origin={-74,72},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Branches.LineConstantImpedance L13to14(portVariablesPhases = true, R = 0.325519, X = 0.662763, G = 0, B = 0, SNom = 100e6, UNom = 13.8e3) annotation (
        Placement(visible = true, transformation(origin={-14,72},  extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      // Loads
      PowerGridsMC.Electrical.Loads.LoadPQVoltageDependenceR Load2(
        alpha = 1.5, beta = 2.5)   annotation (
        Placement(visible = true, transformation(origin={-104,-98},   extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Loads.LoadPQVoltageDependenceR Load3(
        alpha = 1.5, beta = 2.5,
        SNom = 100e6, UNom = 69e3) annotation (
        Placement(visible = true, transformation(origin={104,-94},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Loads.LoadPQVoltageDependenceR Load4(
        alpha = 1.5, beta = 2.5,
        SNom = 100e6, UNom = 69e3) annotation (
        Placement(visible = true, transformation(origin={124,-54},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Loads.LoadPQVoltageDependenceR Load5(
        alpha = 1.5, beta = 2.5)   annotation (
        Placement(visible = true, transformation(origin={-64,-34},    extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      PowerGridsMC.Electrical.Loads.LoadPQVoltageDependenceR Load6(
        alpha = 1.5, beta = 2.5)     annotation (
        Placement(visible = true, transformation(origin={-22,-14},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Loads.LoadPQVoltageDependenceR Load9(
        alpha = 1.5, beta = 2.5,
        SNom = 100e6, UNom = 13.8e3) annotation (
        Placement(visible = true, transformation(origin={118,54},    extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      PowerGridsMC.Electrical.Loads.LoadPQVoltageDependenceR Load10(
        alpha = 1.5, beta = 2.5,
        SNom = 100e6, UNom = 13.8e3) annotation (
        Placement(visible = true, transformation(origin={26,54},    extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      PowerGridsMC.Electrical.Loads.LoadPQVoltageDependenceR Load11(
        alpha = 1.5, beta = 2.5,
        SNom = 100e6, UNom = 13.8e3) annotation (
        Placement(visible = true, transformation(origin={-24,54},    extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      PowerGridsMC.Electrical.Loads.LoadPQVoltageDependenceR Load12(
        alpha = 1.5, beta = 2.5)     annotation (
        Placement(visible = true, transformation(origin={-104,94},   extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      PowerGridsMC.Electrical.Loads.LoadPQVoltageDependenceR Load13(
        alpha = 1.5, beta = 2.5)     annotation (
        Placement(visible = true, transformation(origin={-44,94},    extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      PowerGridsMC.Electrical.Loads.LoadPQVoltageDependenceR Load14(
        alpha = 1.5, beta = 2.5)     annotation (
        Placement(visible = true, transformation(origin={16,94},    extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      // Capacitor Bank
      PowerGridsMC.Electrical.Banks.CapacitorBankFixed Cbank9(B = 0.099769, SNom = 100e6, UNom = 13.8e3) annotation (
        Placement(visible = true, transformation(origin={100,54},    extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      // Transformers
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio T4to7(R = 0, X = 0.398248, B = 0, G = 0, rFixed = 0.204082, SNom = 100e6, UNomA = 69e3, UNomB = 13.8e3) annotation (
        Placement(visible = true, transformation(origin={108,-18},    extent = {{10, 10}, {-10, -10}}, rotation = -90)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio T4to9(R = 0, X = 1.05919, B = 0, G = 0, rFixed = 0.208333, SNom = 100e6, UNomA = 69.0e3, UNomB = 13.8e3) annotation (
        Placement(visible = true, transformation(origin={92,-18},     extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio T5to6(R = 0, X = 0.479948, B = 0, G = 0, rFixed = 0.212766, SNom = 100e6, UNomA = 69e3, UNomB = 13.8e3) annotation (
        Placement(visible = true, transformation(origin={-44,-20},    extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio Tgen1(portVariablesPhases = true, R = 0, X = 0.393146, B = 0, G = 0, rFixed = 2.875, SNom = 1211e6, UNomA = 24e3, UNomB = 69e3) annotation (
        Placement(transformation(origin={-138,20},    extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatioWithBreaker Tgen2(portVariablesPhases = true, R = 0, X = 0.425089, B = 0, G = 0, rFixed = 2.875, SNom = 1120e6, UNomA = 24e3, UNomB = 69e3) annotation (
        Placement(transformation(origin={-128,-90},    extent = {{-10, -10}, {10, 10}})));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio Tgen3(portVariablesPhases = true, R = 0, X = 0.288545, B = 0, G = 0, rFixed = 3.45, SNom = 1650e6, UNomA = 20e3, UNomB = 69e3) annotation (
        Placement(visible = true, transformation(origin={134,-90},    extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio Tgen8(portVariablesPhases = true, R = 0, X = 0.076176, B = 0, G = 0, rFixed = 0.766667, SNom = 250e6, UNomA = 18e3, UNomB = 13.8e3) annotation (
        Placement(visible = true, transformation(origin={164,4},    extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      // Generators
      PowerGridsMC.Electrical.Machines.SynchronousMachine4WindingsR GEN1(
        SNom=1211000000,
        UNom=24000,
        H=4,
        Tpd0=5.143,
        Tppd0=0.042,
        Tppq0=0.083,
        Tpq0=2.16,
        raPu=0,
        xdPu=2,
        xlPu=0.15,
        xpdPu=0.35,
        xppdPu=0.25,
        xppqPu=0.3,
        xpqPu=0.5,
        xqPu=1.8)
       annotation (Placement(transformation(
            origin={-138,46},
            extent={{-10,-10},{10,10}},
            rotation=180)));
      PowerGridsMC.Electrical.Machines.SynchronousMachine4WindingsR GEN2(
        SNom=1120000000,
        UNom=24000,
        H=4,
        Tpd0=5.143,
        Tppd0=0.042,
        Tppq0=0.083,
        Tpq0=2.16,
        raPu=0,
        xdPu=2,
        xlPu=0.15,
        xpdPu=0.35,
        xppdPu=0.25,
        xppqPu=0.3,
        xpqPu=0.5,
        xqPu=1.8)
       annotation (Placement(transformation(
            origin={-158,-90},
            extent={{-10,-10},{10,10}},
            rotation=-90)));
      PowerGridsMC.Electrical.Machines.SynchronousMachine4WindingsR GEN3(
        SNom=1650000000,
        UNom=20000,
        H=4,
        Tpd0=5.143,
        Tppd0=0.042,
        Tppq0=0.083,
        Tpq0=2.16,
        raPu=0,
        xdPu=2,
        xlPu=0.15,
        xpdPu=0.35,
        xppdPu=0.25,
        xppqPu=0.3,
        xpqPu=0.5,
        xqPu=1.8)
       annotation (
        Placement(visible = true, transformation(origin={158,-90},    extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      PowerGridsMC.Electrical.Machines.SynchronousMachine4WindingsR GEN6(
        SNom=80000000,
        UNom=13800,
        H=4,
        Tpd0=5.143,
        Tppd0=0.042,
        Tppq0=0.083,
        Tpq0=2.16,
        raPu=0,
        xdPu=2,
        xlPu=0.15,
        xpdPu=0.35,
        xppdPu=0.25,
        xppqPu=0.3,
        xpqPu=0.5,
        xqPu=1.8)
           annotation (
        Placement(visible = true, transformation(origin={-84,-10},    extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      PowerGridsMC.Electrical.Machines.SynchronousMachine4WindingsR GEN8(
        SNom=250000000,
        UNom=18000,
        H=4,
        Tpd0=5.143,
        Tppd0=0.042,
        Tppq0=0.083,
        Tpq0=2.16,
        raPu=0,
        xdPu=2,
        xlPu=0.15,
        xpdPu=0.35,
        xppdPu=0.25,
        xppqPu=0.3,
        xpqPu=0.5,
        xqPu=1.8)
       annotation (
        Placement(visible = true, transformation(origin={164,-30},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.RealExpression uf1(y=GEN1.ufPuInStart)
        annotation (Placement(visible=true, transformation(
            origin={-105,50},
            extent={{9,-8},{-9,8}},
            rotation=0)));
      Modelica.Blocks.Sources.RealExpression pm1(y=-GEN1.PStart/GEN1.SNom)
        annotation (Placement(visible=true, transformation(
            origin={-104,36},
            extent={{12,-8},{-12,8}},
            rotation=0)));
      Modelica.Blocks.Sources.RealExpression uf8(y=GEN8.ufPuInStart)
        annotation (Placement(visible=true, transformation(
            origin={133,-38},
            extent={{-9,-8},{9,8}},
            rotation=0)));
      Modelica.Blocks.Sources.RealExpression pm8(y=-GEN8.PStart/GEN8.SNom)
        annotation (Placement(visible=true, transformation(
            origin={134,-26},
            extent={{-12,-8},{12,8}},
            rotation=0)));
      Modelica.Blocks.Sources.RealExpression uf6(y=GEN6.ufPuInStart)
        annotation (Placement(visible=true, transformation(
            origin={-101,10},
            extent={{-9,-8},{9,8}},
            rotation=0)));
      Modelica.Blocks.Sources.RealExpression pm6(y=-GEN6.PStart/GEN6.SNom)
        annotation (Placement(visible=true, transformation(
            origin={-64,20},
            extent={{12,-8},{-12,8}},
            rotation=0)));
      Modelica.Blocks.Sources.RealExpression uf2(y=GEN2.ufPuInStart)
        annotation (Placement(visible=true, transformation(
            origin={-173,-73},
            extent={{-9,-7},{9,7}},
            rotation=0)));
      Modelica.Blocks.Sources.RealExpression pm2(y=-GEN2.PStart/GEN2.SNom)
        annotation (Placement(visible=true, transformation(
            origin={-164,-60},
            extent={{-12,-8},{12,8}},
            rotation=0)));
      Modelica.Blocks.Sources.RealExpression uf3(y=GEN3.ufPuInStart)
        annotation (Placement(visible=true, transformation(
            origin={143,-114},
            extent={{-9,-8},{9,8}},
            rotation=0)));
      Modelica.Blocks.Sources.RealExpression pm3(y=-GEN3.PStart/GEN3.SNom)
        annotation (Placement(visible=true, transformation(
            origin={126,-104},
            extent={{-12,-8},{12,8}},
            rotation=0)));
      PowerGridsMC.Electrical.Buses.Bus bus15(SNom=100000000, UNom=24000)
                                                                        annotation (
        Placement(visible = true, transformation(origin={-144,-90},   extent = {{-10, -10}, {10, 10}}, rotation=-90)));
      PowerGridsMC.Electrical.Buses.Bus busG8(SNom=100000000, UNom=18000)
                                                                        annotation (
        Placement(visible = true, transformation(origin={164,-16},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(bus12.terminal, L6to12.terminalB) annotation (
        Line(points={{-104,80},{-106,80},{-106,60},{-84,60}}));
      connect(L12to13.terminalA, bus12.terminal) annotation (
        Line(points={{-84,72},{-100,72},{-100,80},{-104,80}}));
      connect(L12to13.terminalB, bus13.terminal) annotation (
        Line(points={{-64,72},{-50,72},{-50,80},{-44,80}}));
      connect(L6to12.terminalA, bus6.terminal) annotation (
        Line(points={{-64,60},{-50,60},{-50,0},{-44,0}}));
      connect(L6to13.terminalA, bus6.terminal) annotation (
        Line(points={{-44,52},{-44,0}}));
      connect(L6to13.terminalB, bus13.terminal) annotation (
        Line(points={{-44,72},{-44,80}}));
      connect(bus13.terminal, L6to13.terminalB) annotation (
        Line(points={{-44,80},{-44,72}}));
      connect(L6to11.terminalA, bus6.terminal) annotation (
        Line(points={{-24,10},{-24,6},{-38,6},{-38,0},{-44,0}}));
      connect(L6to11.terminalB, bus11.terminal) annotation (
        Line(points={{-24,30},{-24,40}}));
      connect(L13to14.terminalA, bus13.terminal) annotation (
        Line(points={{-24,72},{-38,72},{-38,80},{-44,80}}));
      connect(L13to14.terminalB, bus14.terminal) annotation (
        Line(points={{-4,72},{10,72},{10,80},{16,80}}));
      connect(L9to14.terminalB, bus14.terminal) annotation (
        Line(points={{46,72},{22,72},{22,80},{16,80}}));
      connect(L9to14.terminalA, bus9.terminal) annotation (
        Line(points={{66,72},{86,72},{86,40},{94,40}}));
      connect(L10to11.terminalB, bus11.terminal) annotation (
        Line(points={{-6,28},{-12,28},{-12,40},{-24,40}}));
      connect(L10to11.terminalA, bus10.terminal) annotation (
        Line(points={{14,28},{20,28},{20,42},{26,42}}));
      connect(L9to10.terminalB, bus10.terminal) annotation (
        Line(points={{38,28},{32,28},{32,42},{26,42}}));
      connect(L9to10.terminalA, bus9.terminal) annotation (
        Line(points={{58,28},{88,28},{88,40},{94,40}}));
      connect(L7to8.terminalA, bus7.terminal) annotation (
        Line(points={{114,20},{110,20},{110,6},{106,6},{106,0}}));
      connect(L7to9.terminalA, bus7.terminal) annotation (
        Line(points={{98,12},{98,6},{102,6},{102,0},{106,0}}));
      connect(L7to9.terminalB, bus9.terminal) annotation (
        Line(points={{98,32},{98,40},{94,40}}));
      connect(L7to8.terminalB, bus8.terminal) annotation (
        Line(points={{134,20},{144,20}}));
      connect(T4to9.terminalA, bus4.terminal) annotation (
        Line(points={{92,-28},{92,-40},{98,-40}}));
      connect(T4to9.terminalB, bus9.terminal) annotation (
        Line(points={{92,-8},{92,40},{94,40}}));
      connect(T5to6.terminalB, bus6.terminal) annotation (
        Line(points={{-44,-10},{-44,0}}));
      connect(T5to6.terminalA, bus5.terminal) annotation (
        Line(points={{-44,-30},{-44,-40}}));
      connect(L1to2.terminalA, bus1.terminal) annotation (
        Line(points={{-144,-20},{-144,0},{-138,0}}));
      connect(L1to2.terminalB, bus2.terminal) annotation (
        Line(points={{-144,-40},{-144,-70},{-110,-70},{-110,-80},{-104,-80}}));
      connect(L1to5.terminalA, bus1.terminal) annotation (
        Line(points={{-114,-52},{-128,-52},{-128,0},{-138,0}}));
      connect(L1to5.terminalB, bus5.terminal) annotation (
        Line(points={{-94,-52},{-50,-52},{-50,-40},{-44,-40}}));
      connect(L2to5.terminalB, bus5.terminal) annotation (
        Line(points={{-64,-62},{-44,-62},{-44,-40}}));
      connect(L4to5.terminalB, bus5.terminal) annotation (
        Line(points={{16,-52},{-38,-52},{-38,-40},{-44,-40}}));
      connect(L2to5.terminalA, bus2.terminal) annotation (
        Line(points={{-84,-62},{-104,-62},{-104,-80}}));
      connect(L2to4.terminalA, bus2.terminal) annotation (
        Line(points={{16,-70},{-96,-70},{-96,-80},{-104,-80}}));
      connect(L3to4.terminalB, bus4.terminal) annotation (
        Line(points={{104,-50},{104,-40},{98,-40}}));
      connect(L3to4.terminalA, bus3.terminal) annotation (
        Line(points={{104,-70},{104,-80}}));
      connect(L2to4.terminalB, bus4.terminal) annotation (
        Line(points={{36,-70},{98,-70},{98,-40}}));
      connect(L4to5.terminalA, bus4.terminal) annotation (
        Line(points={{36,-52},{92,-52},{92,-40},{98,-40}}));
      connect(L2to3.terminalB, bus3.terminal) annotation (
        Line(points={{-4,-90},{98,-90},{98,-80},{104,-80}}));
      connect(Tgen8.terminalB, bus8.terminal) annotation (
        Line(points={{164,14},{164,20},{144,20}}));
      connect(Tgen3.terminalB, bus3.terminal) annotation (
        Line(points={{124,-90},{112,-90},{112,-80},{104,-80}}));
      connect(Tgen2.terminalB, bus2.terminal) annotation (
        Line(points={{-118,-90},{-110,-90},{-110,-80},{-104,-80}}));
      connect(Tgen1.terminalB, bus1.terminal) annotation (
        Line(points={{-138,10},{-138,0}}));
      connect(Load12.terminal, bus12.terminal) annotation (
        Line(points={{-104,94},{-104,80}}));
      connect(bus13.terminal, Load13.terminal) annotation (
        Line(points={{-44,80},{-44,94}}));
      connect(Load14.terminal, bus14.terminal) annotation (
        Line(points={{16,94},{16,80}}));
      connect(Load11.terminal, bus11.terminal) annotation (
        Line(points={{-24,54},{-24,40}}));
      connect(Load10.terminal, bus10.terminal) annotation (
        Line(points={{26,54},{26,42}}));
      connect(Cbank9.terminal, bus9.terminal) annotation (
        Line(points={{100,54},{100,48},{94,48},{94,40}}));
      connect(Load9.terminal, bus9.terminal) annotation (
        Line(points={{118,54},{118,46},{110,46},{110,40},{94,40}}));
      connect(Load6.terminal, bus6.terminal) annotation (
        Line(points={{-22,-14},{-22,-6},{-38,-6},{-38,0},{-44,0}}));
      connect(Load5.terminal, bus5.terminal) annotation (
        Line(points={{-64,-34},{-64,-36},{-50,-36},{-50,-40},{-44,-40}}));
      connect(Load3.terminal, bus3.terminal) annotation (
        Line(points={{104,-94},{104,-80}}));
      connect(Load2.terminal, bus2.terminal) annotation (
        Line(points={{-104,-98},{-104,-80}}));
      connect(L2to3.terminalA, bus2.terminal) annotation (
        Line(points={{-24,-90},{-96,-90},{-96,-80},{-104,-80}}));
      connect(Tgen1.terminalA, GEN1.terminal) annotation (
        Line(points={{-138,30},{-138,46}}));
      connect(Tgen3.terminalA, GEN3.terminal) annotation (
        Line(points={{144,-90},{158,-90}}));
      connect(Load4.terminal, bus4.terminal) annotation (
        Line(points={{124,-54},{124,-46},{118,-46},{118,-40},{98,-40}}));
      connect(GEN6.terminal, bus6.terminal) annotation (
        Line(points={{-84,-10},{-58,-10},{-58,0},{-44,0}}));
      connect(T4to7.terminalA, bus4.terminal) annotation (
        Line(points={{108,-28},{108,-40},{98,-40}}));
      connect(T4to7.terminalB, bus7.terminal) annotation (
        Line(points={{108,-8},{108,0},{106,0}}));
      connect(GEN1.omega, systemPowerGrids.omegaRefIn) annotation (
        Line(points={{-148.3,40.1},{-163,40.1},{-163,80.2},{-156.8,80.2}},
                                                                        color = {0, 0, 127}));
      connect(GEN1.ufPuIn, uf1.y)
        annotation (Line(points={{-127.6,50},{-114.9,50}}, color={0,0,127}));
      connect(GEN1.pmPuIn, pm1.y) annotation (Line(points={{-127.6,42.6},{-127.6,
              42},{-122,42},{-122,36},{-117.2,36}}, color={0,0,127}));
      connect(pm8.y, GEN8.pmPuIn) annotation (Line(points={{147.2,-26},{144,
              -26.6},{153.6,-26.6}},
                              color={0,0,127}));
      connect(GEN8.ufPuIn,uf8. y) annotation (Line(points={{153.6,-34},{146,-34},
              {146,-38},{142.9,-38}},
                           color={0,0,127}));
      connect(pm6.y, GEN6.pmPuIn) annotation (Line(points={{-77.2,20},{-80,20},
              {-80,0.4},{-80.6,0.4}}, color={0,0,127}));
      connect(uf6.y, GEN6.ufPuIn)
        annotation (Line(points={{-91.1,10},{-88,10},{-88,0.4}}, color={0,0,127}));
      connect(GEN2.ufPuIn,uf2. y) annotation (Line(points={{-162,-79.6},{-162,
              -73},{-163.1,-73}},        color={0,0,127}));
      connect(pm2.y, GEN2.pmPuIn) annotation (Line(points={{-150.8,-60},{-148,
              -60},{-148,-72},{-154,-72},{-154,-79.6},{-154.6,-79.6}}, color={0,
              0,127}));
      connect(GEN3.ufPuIn,uf3. y) annotation (Line(points={{162,-100.4},{162,
              -114},{152.9,-114}},       color={0,0,127}));
      connect(GEN3.pmPuIn, pm3.y) annotation (Line(points={{154.6,-100.4},{
              154.6,-104},{139.2,-104}}, color={0,0,127}));
      connect(GEN2.terminal, bus15.terminal)
        annotation (Line(points={{-158,-90},{-144,-90}}, color={0,0,0}));
      connect(bus15.terminal, Tgen2.terminalA)
        annotation (Line(points={{-144,-90},{-138,-90}}, color={0,0,0}));
      connect(busG8.terminal, GEN8.terminal)
        annotation (Line(points={{164,-16},{164,-30}}, color={0,0,0}));
      connect(Tgen8.terminalA, busG8.terminal)
        annotation (Line(points={{164,-6},{164,-16}}, color={0,0,0}));
      annotation (
        Diagram(coordinateSystem(extent={{-180,120},{180,-120}})),
        experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-6, Interval = 0.002),
        Documentation(info="<html>
<p><i><span style=\"font-family: Arial; font-size: 12pt;\">Library PowerGridsMC was forked from https://github.com/PowerGrids/PowerGrids on 22 November 2024.</span></i></p>
<p>************************** </p>
<p>This model is derived from the original IEEE14busStaticNetwork, which did not have any information on its info section.</p>
<p>This model is different in the following directions:</p>
<p>- it has generators without regulators: their inputs are constantly equal to the initial values, so that the system says constantly at its initial operating point</p>
<p>- it recovers from disk power flow outputs, obtained using PowerFlowSI model. In this way we have here a &quot;transient&quot;, in which, however, nothing changes over time. It shows that the passage of PF output to transient-enabled models through the disk saving/retrieving mechanism works well.</p>
</html>"));
    end StaticNetworkUnreg;

    model StaticNetworkReg
      "Dynamic model of the IEEE 14-bus system, operating in steady-state, no regulators"
      extends Modelica.Icons.Example;
      inner PowerGridsMC.Electrical.System systemPowerGrids(initOpt = PowerGridsMC.Types.Choices.InitializationOption.globalSteadyStateFixedPowerFlow, referenceFrequency = PowerGridsMC.Types.Choices.ReferenceFrequency.fixedReferenceGenerator,
        showDataOnDiagramsPu=false)                                                                                                                                                                                                         annotation (
        Placement(transformation(origin={-146,80},    extent = {{-10, -10}, {10, 10}})));
      // Buses
      PowerGridsMC.Electrical.Buses.ReferenceBusR bus1(SNom = 100e6, UNom = 69e3) annotation (
        Placement(transformation(origin={-138,0},    extent = {{-10, -10}, {10, 10}})));
      PowerGridsMC.Electrical.Buses.Bus bus2(SNom = 100e6, UNom = 69e3) annotation (
        Placement(visible = true, transformation(origin={-104,-80},   extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Buses.BusFault busG2(
        SNom=100000000,
        UNom=24000,
        R=1,
        startTime=1e6,
        stopTime=2e6)
        annotation (Placement(visible=true, transformation(
            origin={-144,-90},
            extent={{-10,-10},{10,10}},
            rotation=-90)));
      PowerGridsMC.Electrical.Buses.Bus bus3(SNom = 100e6, UNom = 69e3) annotation (
        Placement(visible = true, transformation(origin={102,-80},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Buses.Bus bus4(SNom = 100e6, UNom = 69e3)   annotation (
        Placement(visible = true, transformation(origin={94,-40},     extent={{10,-10},
                {-10,10}},                                                                             rotation = 0)));
      PowerGridsMC.Electrical.Buses.Bus bus5(SNom = 100e6, UNom = 69e3) annotation (
        Placement(visible = true, transformation(origin={-44,-40},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Buses.Bus bus6(SNom = 100e6, UNom = 13.8e3) annotation (
        Placement(visible = true, transformation(origin={-44,0},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Buses.Bus bus7(SNom = 100e6, UNom = 13.8e3) annotation (
        Placement(visible = true, transformation(origin={102,0},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Buses.Bus busG8(SNom=100000000, UNom=18000)
        annotation (
        Placement(visible = true, transformation(origin={162,-16},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Buses.Bus bus8(SNom = 100e6, UNom = 13.8e3) annotation (
        Placement(visible = true, transformation(origin={142,20},    extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      PowerGridsMC.Electrical.Buses.Bus bus9(SNom = 100e6, UNom = 13.8e3) annotation (
        Placement(visible = true, transformation(origin={92,40},     extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Buses.Bus bus10(SNom = 100e6, UNom = 13.8e3) annotation (
        Placement(visible = true, transformation(origin={26,42},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Buses.Bus bus11(SNom = 100e6, UNom = 13.8e3) annotation (
        Placement(visible = true, transformation(origin={-24,40},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Buses.Bus bus12(SNom = 100e6, UNom = 13.8e3) annotation (
        Placement(visible = true, transformation(origin={-104,80},   extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Buses.Bus bus13(SNom = 100e6, UNom = 13.8e3) annotation (
        Placement(visible = true, transformation(origin={-44,80},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Buses.Bus bus14(SNom = 100e6, UNom = 13.8e3) annotation (
        Placement(visible = true, transformation(origin={16,80},    extent={{10,-10},
                {-10,10}},                                                                           rotation = 0)));
      // Lines
      PowerGridsMC.Electrical.Branches.LineConstantImpedance L1to2(portVariablesPhases = true, R = 0.922682, X = 2.81708, G = 0, B = 0.00110901, SNom = 100e6, UNom = 69e3) annotation (
        Placement(transformation(origin={-144,-30},    extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      PowerGridsMC.Electrical.Branches.LineConstantImpedanceWithBreakers L1to5(portVariablesPhases = true, R = 2.57237, X = 10.6189, G = 0, B = 0.0010334, SNom = 100e6, UNom = 69e3) annotation (
        Placement(visible = true, transformation(origin={-104,-52},   extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Branches.LineConstantImpedance L2to3(portVariablesPhases = true, R = 2.23719, X = 9.42535, G = 0, B = 0.000919975, SNom = 100e6, UNom = 69e3) annotation (
        Placement(visible = true, transformation(origin={-14,-90},  extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Branches.LineConstantImpedance L2to4(portVariablesPhases = true, R = 2.76662, X = 8.3946, G = 0, B = 0.000714136, SNom = 100e6, UNom = 69e3) annotation (
        Placement(visible = true, transformation(origin={26,-70},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Branches.LineConstantImpedance L2to5(portVariablesPhases = true, R = 2.71139, X = 8.27843, G = 0, B = 0.000726738, SNom = 100e6, UNom = 69e3) annotation (
        Placement(visible = true, transformation(origin={-74,-62},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Branches.LineConstantImpedance L3to4(portVariablesPhases = true, R = 3.19035, X = 8.14274, G = 0, B = 0.000268851, SNom = 100e6, UNom = 69e3) annotation (
        Placement(visible = true, transformation(origin={102,-60},    extent = {{10, -10}, {-10, 10}}, rotation = -90)));
      PowerGridsMC.Electrical.Branches.LineConstantImpedance L4to5(portVariablesPhases = true, R = 0.635593, X = 2.00486, G = 0, B = 0, SNom = 100e6, UNom = 69e3) annotation (
        Placement(visible = true, transformation(origin={26,-52},    extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Branches.LineConstantImpedance L6to11(portVariablesPhases = true, R = 0.18088, X = 0.378785, G = 0, B = 0, SNom = 100e6, UNom = 13.8e3) annotation (
        Placement(visible = true, transformation(origin={-24,20},    extent = {{10, -10}, {-10, 10}}, rotation = -90)));
      PowerGridsMC.Electrical.Branches.LineConstantImpedance L6to12(R = 0.23407, portVariablesPhases = true, X = 0.487165, G = 0, B = 0, SNom = 100e6, UNom = 13.8e3) annotation (
        Placement(visible = true, transformation(origin={-74,60},    extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Branches.LineConstantImpedance L6to13(portVariablesPhases = true, R = 0.125976, X = 0.248086, G = 0, B = 0, SNom = 100e6, UNom = 13.8e3) annotation (
        Placement(visible = true, transformation(origin={-44,62},    extent = {{10, -10}, {-10, 10}}, rotation = -90)));
      PowerGridsMC.Electrical.Branches.LineConstantImpedance L7to8(portVariablesPhases = true, R = 0, X = 0.33546, G = 0, B = 0, SNom = 100e6, UNom = 13.8e3) annotation (
        Placement(visible = true, transformation(origin={122,20},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Branches.LineConstantImpedance L7to9(portVariablesPhases = true, R = 0, X = 0.209503, G = 0, B = 0, SNom = 100e6, UNom = 13.8e3) annotation (
        Placement(visible = true, transformation(origin={96,22},     extent = {{10, -10}, {-10, 10}}, rotation = -90)));
      PowerGridsMC.Electrical.Branches.LineConstantImpedance L9to10(portVariablesPhases = true, R = 0.060579, X = 0.160922, G = 0, B = 0, SNom = 100e6, UNom = 13.8e3) annotation (
        Placement(visible = true, transformation(origin={48,28},    extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Branches.LineConstantImpedance L9to14(portVariablesPhases = true, R = 0.242068, X = 0.514912, G = 0, B = 0, SNom = 100e6, UNom = 13.8e3) annotation (
        Placement(visible = true, transformation(origin={56,72},    extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Branches.LineConstantImpedance L10to11(portVariablesPhases = true, R = 0.156256, X = 0.365778, G = 0, B = 0, SNom = 100e6, UNom = 13.8e3) annotation (
        Placement(visible = true, transformation(origin={4,28},     extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Branches.LineConstantImpedance L12to13(portVariablesPhases = true, R = 0.42072, X = 0.380651, G = 0, B = 0, SNom = 100e6, UNom = 13.8e3) annotation (
        Placement(visible = true, transformation(origin={-74,72},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Branches.LineConstantImpedance L13to14(portVariablesPhases = true, R = 0.325519, X = 0.662763, G = 0, B = 0, SNom = 100e6, UNom = 13.8e3) annotation (
        Placement(visible = true, transformation(origin={-14,72},  extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      // Loads
      PowerGridsMC.Electrical.Loads.LoadPQVoltageDependenceR Load2(
        alpha = 1.5, beta = 2.5,
        SNom = 100e6, UNom = 69e3) annotation (
        Placement(visible = true, transformation(origin={-104,-98},   extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Loads.LoadPQVoltageDependenceR Load3(
        alpha = 1.5, beta = 2.5,
        SNom = 100e6, UNom = 69e3) annotation (
        Placement(visible = true, transformation(origin={102,-98},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Loads.LoadPQVoltageDependenceR Load4(
        alpha = 1.5, beta = 2.5,
        SNom = 100e6, UNom = 69e3) annotation (
        Placement(visible = true, transformation(origin={122,-54},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Loads.LoadPQVoltageDependenceR Load5(
        alpha = 1.5, beta = 2.5,
        SNom = 100e6, UNom = 69e3) annotation (
        Placement(visible = true, transformation(origin={-74,-30},    extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      PowerGridsMC.Electrical.Loads.LoadPQVoltageDependenceR Load6(
        alpha = 1.5, beta = 2.5,
        SNom = 100e6, UNom = 13.8e3) annotation (
        Placement(visible = true, transformation(origin={-22,-14},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Loads.LoadPQVoltageDependenceR Load9(
        alpha = 1.5, beta = 2.5,
        SNom = 100e6, UNom = 13.8e3) annotation (
        Placement(visible = true, transformation(origin={116,54},    extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      PowerGridsMC.Electrical.Loads.LoadPQVoltageDependenceR Load10(
        alpha = 1.5, beta = 2.5,
        SNom = 100e6, UNom = 13.8e3) annotation (
        Placement(visible = true, transformation(origin={26,54},    extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      PowerGridsMC.Electrical.Loads.LoadPQVoltageDependenceR Load11(
        alpha = 1.5, beta = 2.5,
        SNom = 100e6, UNom = 13.8e3) annotation (
        Placement(visible = true, transformation(origin={-24,54},    extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      PowerGridsMC.Electrical.Loads.LoadPQVoltageDependenceR Load12(
        alpha = 1.5, beta = 2.5,
        SNom = 100e6, UNom = 13.8e3) annotation (
        Placement(visible = true, transformation(origin={-104,94},   extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      PowerGridsMC.Electrical.Loads.LoadPQVoltageDependenceR Load13(
        alpha = 1.5, beta = 2.5,
        SNom = 100e6, UNom = 13.8e3) annotation (
        Placement(visible = true, transformation(origin={-44,94},    extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      PowerGridsMC.Electrical.Loads.LoadPQVoltageDependenceR Load14(
        alpha = 1.5, beta = 2.5,
        SNom = 100e6, UNom = 13.8e3) annotation (
        Placement(visible = true, transformation(origin={16,94},    extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      // Capacitor Bank
      PowerGridsMC.Electrical.Banks.CapacitorBankFixed Cbank9(B = 0.099769, SNom = 100e6, UNom = 13.8e3) annotation (
        Placement(visible = true, transformation(origin={98,54},     extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      // Transformers
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio T4to7(R = 0, X = 0.398248, B = 0, G = 0, rFixed = 0.204082, SNom = 100e6, UNomA = 69e3, UNomB = 13.8e3) annotation (
        Placement(visible = true, transformation(origin={102,-18},    extent = {{10, 10}, {-10, -10}}, rotation = -90)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio T4to9(R = 0, X = 1.05919, B = 0, G = 0, rFixed = 0.208333, SNom = 100e6, UNomA = 69.0e3, UNomB = 13.8e3) annotation (
        Placement(visible = true, transformation(origin={90,-18},     extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio T5to6(R = 0, X = 0.479948, B = 0, G = 0, rFixed = 0.212766, SNom = 100e6, UNomA = 69e3, UNomB = 13.8e3) annotation (
        Placement(visible = true, transformation(origin={-46,-22},    extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio Tgen1(portVariablesPhases = true, R = 0, X = 0.393146, B = 0, G = 0, rFixed = 2.875, SNom = 1211e6, UNomA = 24e3, UNomB = 69e3) annotation (
        Placement(transformation(origin={-138,20},    extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatioWithBreaker Tgen2(portVariablesPhases = true, R = 0, X = 0.425089, B = 0, G = 0, rFixed = 2.875, SNom = 1120e6, UNomA = 24e3, UNomB = 69e3) annotation (
        Placement(transformation(origin={-128,-90},    extent = {{-10, -10}, {10, 10}})));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio Tgen3(portVariablesPhases = true, R = 0, X = 0.288545, B = 0, G = 0, rFixed = 3.45, SNom = 1650e6, UNomA = 20e3, UNomB = 69e3) annotation (
        Placement(visible = true, transformation(origin={132,-90},    extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Branches.TransformerFixedRatio Tgen8(portVariablesPhases = true, R = 0, X = 0.076176, B = 0, G = 0, rFixed = 0.766667, SNom = 250e6, UNomA = 18e3, UNomB = 13.8e3) annotation (
        Placement(visible = true, transformation(origin={162,4},    extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      // Generators
      PowerGridsMC.Examples.IEEE14bus.ControlledGenNoPSS_R GEN1(GEN(
       SNom=1211000000,
        UNom=24000,
        H=4,
        Tpd0=5.143,
        Tppd0=0.042,
        Tppq0=0.083,
        Tpq0=2.16,
        raPu=0,
        xdPu=2,
        xlPu=0.15,
        xpdPu=0.35,
        xppdPu=0.25,
        xppqPu=0.3,
        xpqPu=0.5,
        xqPu=1.8))
       annotation (Placement(transformation(
            origin={-138,46},
            extent={{10,10},{-10,-10}},
            rotation=0)));
      PowerGridsMC.Examples.IEEE14bus.ControlledGenNoPSS_R GEN2(GEN(
          DPu=0.0,
          H=5.4,
          Tppd0=0.058,
          xpdPu=0.407,
          Tpd0=9.651,
          raPu=0.00357,
          xpqPu=0.454,
          Tppq0=0.06,
          Tpq0=1.009,
          xppdPu=0.3,
          xdPu=2.57,
          xlPu=0.219,
          xppqPu=0.301,
          xqPu=2.57,
          PNom=1008e6,
          SNom=1120e6,
          UNom=24e3))
       annotation (Placement(transformation(
            origin={-162,-90},
            extent={{-10,-10},{10,10}},
            rotation=-90)));
      PowerGridsMC.Examples.IEEE14bus.SynchronousCondenserR GEN3(GEN(
        SNom=1650000000,
        UNom=20000,
        H=4,
        Tpd0=5.143,
        Tppd0=0.042,
        Tppq0=0.083,
        Tpq0=2.16,
        raPu=0,
        xdPu=2,
        xlPu=0.15,
        xpdPu=0.35,
        xppdPu=0.25,
        xppqPu=0.3,
        xpqPu=0.5,
        xqPu=1.8))
       annotation (
        Placement(visible = true, transformation(origin={162,-90},    extent = {{-10, -10}, {10, 10}}, rotation = 90)));
        PowerGridsMC.Examples.IEEE14bus.SynchronousCondenserR GEN6(GEN(
        SNom=80000000,
        UNom=13800,
        H=4,
        Tpd0=5.143,
        Tppd0=0.042,
        Tppq0=0.083,
        Tpq0=2.16,
        raPu=0,
        xdPu=2,
        xlPu=0.15,
        xpdPu=0.35,
        xppdPu=0.25,
        xppqPu=0.3,
        xpqPu=0.5,
        xqPu=1.8))
       annotation (Placement(transformation(
            origin={-80,0},
            extent={{-10,-10},{10,10}},
            rotation=-90)));

      PowerGridsMC.Examples.IEEE14bus.SynchronousCondenserR GEN8(GEN(
        SNom=250000000,
        UNom=18000,
        H=4,
        Tpd0=5.143,
        Tppd0=0.042,
        Tppq0=0.083,
        Tpq0=2.16,
        raPu=0,
        xdPu=2,
        xlPu=0.15,
        xpdPu=0.35,
        xppdPu=0.25,
        xppqPu=0.3,
        xpqPu=0.5,
        xqPu=1.8))
       annotation (
        Placement(visible = true, transformation(origin={162,-36},    extent = {{-10, -10}, {10, 10}}, rotation=0)));
    equation
      connect(bus12.terminal, L6to12.terminalB) annotation (
        Line(points={{-104,80},{-106,80},{-106,60},{-84,60}}));
      connect(L12to13.terminalA, bus12.terminal) annotation (
        Line(points={{-84,72},{-100,72},{-100,80},{-104,80}}));
      connect(L12to13.terminalB, bus13.terminal) annotation (
        Line(points={{-64,72},{-50,72},{-50,80},{-44,80}}));
      connect(L6to12.terminalA, bus6.terminal) annotation (
        Line(points={{-64,60},{-50,60},{-50,0},{-44,0}}));
      connect(L6to13.terminalA, bus6.terminal) annotation (
        Line(points={{-44,52},{-44,0}}));
      connect(L6to13.terminalB, bus13.terminal) annotation (
        Line(points={{-44,72},{-44,80}}));
      connect(bus13.terminal, L6to13.terminalB) annotation (
        Line(points={{-44,80},{-44,72}}));
      connect(L6to11.terminalA, bus6.terminal) annotation (
        Line(points={{-24,10},{-24,6},{-38,6},{-38,0},{-44,0}}));
      connect(L6to11.terminalB, bus11.terminal) annotation (
        Line(points={{-24,30},{-24,40}}));
      connect(L13to14.terminalA, bus13.terminal) annotation (
        Line(points={{-24,72},{-38,72},{-38,80},{-44,80}}));
      connect(L13to14.terminalB, bus14.terminal) annotation (
        Line(points={{-4,72},{12,72},{12,80},{16,80}}));
      connect(L9to14.terminalB, bus14.terminal) annotation (
        Line(points={{46,72},{20,72},{20,80},{16,80}}));
      connect(L9to14.terminalA, bus9.terminal) annotation (
        Line(points={{66,72},{84,72},{84,48},{88,48},{88,40},{92,40}}));
      connect(L10to11.terminalB, bus11.terminal) annotation (
        Line(points={{-6,28},{-12,28},{-12,40},{-24,40}}));
      connect(L10to11.terminalA, bus10.terminal) annotation (
        Line(points={{14,28},{20,28},{20,42},{26,42}}));
      connect(L9to10.terminalB, bus10.terminal) annotation (
        Line(points={{38,28},{32,28},{32,42},{26,42}}));
      connect(L9to10.terminalA, bus9.terminal) annotation (
        Line(points={{58,28},{86,28},{86,40},{92,40}}));
      connect(L7to8.terminalA, bus7.terminal) annotation (
        Line(points={{112,20},{108,20},{108,6},{104,6},{104,0},{102,0}}));
      connect(L7to9.terminalA, bus7.terminal) annotation (
        Line(points={{96,12},{96,6},{100,6},{100,0},{102,0}}));
      connect(L7to9.terminalB, bus9.terminal) annotation (
        Line(points={{96,32},{96,40},{92,40}}));
      connect(L7to8.terminalB, bus8.terminal) annotation (
        Line(points={{132,20},{142,20}}));
      connect(T4to9.terminalA, bus4.terminal) annotation (
        Line(points={{90,-28},{90,-40},{94,-40}}));
      connect(T4to9.terminalB, bus9.terminal) annotation (
        Line(points={{90,-8},{90,40},{92,40}}));
      connect(T5to6.terminalB, bus6.terminal) annotation (
        Line(points={{-46,-12},{-46,-6},{-44,-6},{-44,0}}));
      connect(T5to6.terminalA, bus5.terminal) annotation (
        Line(points={{-46,-32},{-46,-36},{-44,-36},{-44,-40}}));
      connect(L1to2.terminalA, bus1.terminal) annotation (
        Line(points={{-144,-20},{-144,0},{-138,0}}));
      connect(L1to2.terminalB, bus2.terminal) annotation (
        Line(points={{-144,-40},{-144,-62},{-110,-62},{-110,-80},{-104,-80}}));
      connect(L1to5.terminalA, bus1.terminal) annotation (
        Line(points={{-114,-52},{-128,-52},{-128,0},{-138,0}}));
      connect(L1to5.terminalB, bus5.terminal) annotation (
        Line(points={{-94,-52},{-50,-52},{-50,-40},{-44,-40}}));
      connect(L2to5.terminalB, bus5.terminal) annotation (
        Line(points={{-64,-62},{-44,-62},{-44,-40}}));
      connect(L4to5.terminalB, bus5.terminal) annotation (
        Line(points={{16,-52},{-38,-52},{-38,-40},{-44,-40}}));
      connect(L2to5.terminalA, bus2.terminal) annotation (
        Line(points={{-84,-62},{-104,-62},{-104,-80}}));
      connect(L2to4.terminalA, bus2.terminal) annotation (
        Line(points={{16,-70},{-90,-70},{-90,-80},{-104,-80}}));
      connect(L3to4.terminalB, bus4.terminal) annotation (
        Line(points={{102,-50},{102,-40},{94,-40}}));
      connect(L3to4.terminalA, bus3.terminal) annotation (
        Line(points={{102,-70},{102,-80}}));
      connect(L2to4.terminalB, bus4.terminal) annotation (
        Line(points={{36,-70},{94,-70},{94,-40}}));
      connect(L4to5.terminalA, bus4.terminal) annotation (
        Line(points={{36,-52},{90,-52},{90,-40},{94,-40}}));
      connect(L2to3.terminalB, bus3.terminal) annotation (
        Line(points={{-4,-90},{96,-90},{96,-80},{102,-80}}));
      connect(Tgen8.terminalB, bus8.terminal) annotation (
        Line(points={{162,14},{162,20},{142,20}}));
      connect(Tgen3.terminalB, bus3.terminal) annotation (
        Line(points={{122,-90},{110,-90},{110,-80},{102,-80}}));
      connect(Tgen2.terminalB, bus2.terminal) annotation (
        Line(points={{-118,-90},{-110,-90},{-110,-80},{-104,-80}}));
      connect(Tgen1.terminalB, bus1.terminal) annotation (
        Line(points={{-138,10},{-138,0}}));
      connect(Load12.terminal, bus12.terminal) annotation (
        Line(points={{-104,94},{-104,80}}));
      connect(bus13.terminal, Load13.terminal) annotation (
        Line(points={{-44,80},{-44,94}}));
      connect(Load14.terminal, bus14.terminal) annotation (
        Line(points={{16,94},{16,80}}));
      connect(Load11.terminal, bus11.terminal) annotation (
        Line(points={{-24,54},{-24,40}}));
      connect(Load10.terminal, bus10.terminal) annotation (
        Line(points={{26,54},{26,42}}));
      connect(Cbank9.terminal, bus9.terminal) annotation (
        Line(points={{98,54},{98,48},{92,48},{92,40}}));
      connect(Load9.terminal, bus9.terminal) annotation (
        Line(points={{116,54},{116,46},{108,46},{108,40},{92,40}}));
      connect(Load6.terminal, bus6.terminal) annotation (
        Line(points={{-22,-14},{-22,-6},{-38,-6},{-38,0},{-44,0}}));
      connect(Load5.terminal, bus5.terminal) annotation (
        Line(points={{-74,-30},{-74,-36},{-60,-36},{-60,-40},{-44,-40}}));
      connect(Load3.terminal, bus3.terminal) annotation (
        Line(points={{102,-98},{102,-80}}));
      connect(Load2.terminal, bus2.terminal) annotation (
        Line(points={{-104,-98},{-104,-80}}));
      connect(L2to3.terminalA, bus2.terminal) annotation (
        Line(points={{-24,-90},{-90,-90},{-90,-80},{-104,-80}}));
      connect(Load4.terminal, bus4.terminal) annotation (
        Line(points={{122,-54},{122,-40},{94,-40}}));
      connect(T4to7.terminalA, bus4.terminal) annotation (
        Line(points={{102,-28},{102,-40},{94,-40}}));
      connect(T4to7.terminalB, bus7.terminal) annotation (
        Line(points={{102,-8},{102,0}}));
      connect(busG2.terminal, Tgen2.terminalA)
        annotation (Line(points={{-144,-90},{-138,-90}}, color={0,0,0}));
      connect(Tgen8.terminalA, busG8.terminal)
        annotation (Line(points={{162,-6},{162,-16}}, color={0,0,0}));
      connect(GEN2.terminal, Tgen2.terminalA) annotation (
        Line(points={{-162,-90},{-138,-90}}));
      connect(Tgen3.terminalA, GEN3.terminal)
        annotation (Line(points={{142,-90},{162,-90}}, color={0,0,0}));
      connect(busG8.terminal, GEN8.terminal)
        annotation (Line(points={{162,-16},{162,-36}}, color={0,0,0}));
      connect(GEN6.terminal, bus6.terminal)
        annotation (Line(points={{-80,0},{-44,0}}, color={0,0,0}));
      connect(GEN1.terminal, Tgen1.terminalA)
        annotation (Line(points={{-138,46},{-138,30}}, color={0,0,0}));
      connect(GEN1.omega, systemPowerGrids.omegaRefIn) annotation (Line(points={{-149,
              46},{-156,46},{-156,44},{-170,44},{-170,80.2},{-156.8,80.2}}, color={0,
              0,127}));
      annotation (
        Diagram(coordinateSystem(extent={{-180,120},{180,-120}})),
        experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-6, Interval = 0.002),
        Documentation(info="<html>
<p><i><span style=\"font-family: Arial; font-size: 12pt;\">Library PowerGridsMC was forked from https://github.com/PowerGrids/PowerGrids on 22 November 2024.</span></i></p>
<p>************************** </p>
<p>This model is derived from the original IEEE14busStaticNetwork, which did not have any information on its info section.</p>
<p><br>This model is different in the following directions:</p>
<p>- it has generators without regulators: their inputs are constantly equal to the initial values, so that the system says constantly ats itts initial operating point</p>
<p>- it recovers from disk power flow outputs, obtained using PowerFlowSI model. In this way we have here a &quot;transient&quot;, in which, however, nothing changes over time. It shows that the passage of PF output to transient-enabled models trhough the disk saving/retrieving mechanism works well.</p>
</html>"));
    end StaticNetworkReg;

    package DerivedCases
      model Line1to5Opening
        extends IEEE14.StaticNetworkReg
                                (L1to5(useBreakerB=true));
        Modelica.Blocks.Sources.BooleanExpression L1to5BreakerState(y = time < 1)  annotation (
          Placement(transformation(origin = {-102, -36}, extent = {{-10, -10}, {10, 10}})));
      equation
        connect(L1to5BreakerState.y, L1to5.breakerStatusB) annotation (
          Line(points={{-91,-36},{-84,-36},{-84,-51},{-97,-51}},          color = {255, 0, 255}));

        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)),
          experiment(
            StopTime=20,
            Interval=0.002,
            Tolerance=1e-06,
            __Dymola_Algorithm="Dassl"));
      end Line1to5Opening;

      model Gen2Disconnection
        extends IEEE14.StaticNetworkReg
                                (Tgen2(useBreaker=true));
        Modelica.Blocks.Sources.BooleanExpression breakerState(y=time < 1)
          annotation (Placement(visible=true, transformation(
              origin={-162,-72},
              extent={{-10,-10},{10,10}},
              rotation=0)));
      equation
        connect(breakerState.y, Tgen2.breakerStatusIn) annotation (Line(points={{-151,
                -72},{-122,-72},{-122,-89},{-121,-89}}, color={255,0,255}));

        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)),
          experiment(
            StopTime=20,
            Interval=0.002,
            Tolerance=1e-06,
            __Dymola_Algorithm="Dassl"));
      end Gen2Disconnection;

      model BusFaultG2
          extends StaticNetworkReg  (busG2(
            R=0.01,
            startTime=1,
            stopTime=2));

        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)),
          experiment(
            StopTime=20,
            Interval=0.002,
            Tolerance=1e-06,
            __Dymola_Algorithm="Dassl"),
          Documentation(info="<html>
<p>With the current version of the library, bus faults must have a non-zero impedance. This is not a strong limitation, because zero-impedence faults are an abstraction. Here a realistic, very small, value is used. </p>
</html>"));
      end BusFaultG2;
      annotation (Documentation(info="<html>
<p>This folder contanins models which are obtained through &quot;extends&quot; of StaticNetworkReg.</p>
</html>"));
    end DerivedCases;
    annotation (Documentation(info="<html>
<p>This is an examples of usage of PowerGrids with a rather large grid, i.e. an implementation of the IEEE 14 bus system.</p>
<p>The implementation is the same of the IEEE14bus models contained in the folder Examples.IEEE14bus folder.</p>
<p>Here, however, we use the PFT technique, i.e. passage Power-Flow -&gt; Transient, which involves saving powerflow output and retrieving it in transient simulations.</p>
</html>"));
  end IEEE14;
  annotation (
    conversion(noneFromVersion="", noneFromVersion="1"), Documentation(info="<html>
<p><i><span style=\"font-family: Arial; font-size: 12pt;\">Library PowerGridsMC was forked from https://github.com/PowerGrids/PowerGrids on 22 November 2024.</span></i></p>
<p><i><span style=\"font-size: 12pt;\">Folder PFT was not present in the original PowerGrids library</span></i></p>
<p>************************** </p>
<p>PFT folder contains examples of the PowerFlow-&gt;Transient simulation chain. </p>
<p>This allows to transfer automatically output from PowerFlow into transient simulations. This is done through saving of the relevant information a disk files. The data is stored and retrieved based on the instance name. Therefore, for an effective PowerFlow-&gt;Transient chaining, the instance name of the PowerFlow writing and Transient reading models must be the same.</p>
<p>The user first runs a PowerFlow study, then a transient The PowerFlow stores its results on disk, the subsequent transient takes those values from disk. Therefore, since this saving/retrieving mechanism is base don components&apos; instance names, it is mandatory that PowerFlow and transiens share the same instance names, as in the examples proposed in this folder.</p>
<p>this folder containes two examples:</p>
<ul>
<li>a very simple example containing a grid (&quot;BasicGrid&quot;)</li>
<li>a bit larger netowk, containing four ST nodes, three synchronous machines and a synchronoous compoensator, plus several transformers (FourATbus)</li>
</ul>
</html>"));
end PFT;
