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
        showPFdata=true,  portVariablesPu = true, rFixed = 419 / 21)  annotation (
        Placement(visible = true, transformation(origin={0,-10},  extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Buses.Bus NTHV(SNom = 5e+8, UNom = 380e3,
         portVariablesPhases = true, portVariablesPu = true)  annotation (
        Placement(visible = true, transformation(origin={30,-10},  extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      inner PowerGridsMC.Electrical.System systemPowerGrids annotation (
        Placement(visible = true, transformation(origin={40,28},     extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.PowerFlow.PQBusW GRIDL_(
        P=475e6,
        Q=76e6,
        SNom=500e6,
        UNom=380e3,
        portVariablesPhases=true,
        portVariablesPu=true) annotation (Placement(visible=true, transformation(
            origin={60,-24},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      PowerGridsMC.Electrical.PowerFlow.SlackBusW GRID_(
        SNom=500000000,
        U=398000,
        UNom=380000,
        portVariablesPhases=true,
        portVariablesPu=true) annotation (Placement(visible=true, transformation(
            origin={54,2},
            extent={{-10,-10},{10,10}},
            rotation=-90)));
      PowerGridsMC.Electrical.PowerFlow.PVBusW GEN_(
        UNom=21e3,
        SNom=500e6,
        P=-475e6,
        U=20825.8) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-46,18})));
    equation
      connect(NTLV.terminal, TGEN.terminalA) annotation (
        Line(points={{-30,-10},{-10,-10}}));
      connect(TGEN.terminalB, NTHV.terminal) annotation (
        Line(points={{10,-10},{30,-10}}));
      connect(NTHV.terminal, GRID_.terminal)
        annotation (Line(points={{30,-10},{38,-10},{38,2},{54,2}}));
      connect(GRIDL_.terminal, NTHV.terminal)
        annotation (Line(points={{60,-24},{38,-24},{38,-10},{30,-10}}));
      connect(GEN_.terminal, NTLV.terminal)
        annotation (Line(points={{-46,18},{-46,-10},{-30,-10}}, color={0,0,0}));
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
      PowerGridsMC.Electrical.Machines.SynchronousMachine4WindingsR GEN_(
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
            origin={-34,2},
            extent={{-10,-10},{10,10}},
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
      PowerGridsMC.Electrical.Buses.EquivalentGridR GRID_(
        R_X=1/10,
        SNom=500000000,
        SSC=2500000000,
        UNom=380000,
        c=1.1,
        portVariablesPhases=true,
        portVariablesPu=true) annotation (Placement(visible=true, transformation(
            origin={56,-8},
            extent={{-10,-10},{10,10}},
            rotation=0)));

      PowerGridsMC.Electrical.Loads.LoadPQVoltageDependenceR GRIDL_(
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

      Modelica.Blocks.Sources.RealExpression PmPu(y=-GEN_.y[1, 6]) annotation (
          Placement(visible=true, transformation(
            origin={-64,6},
            extent={{-10,-10},{10,10}},
            rotation=0)));
      Modelica.Blocks.Sources.RealExpression ufPuIn(y=GEN_.ufPuInStart) annotation (
         Placement(visible=true, transformation(
            origin={-64,-18},
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
      connect(PmPu.y, GEN_.PmPu)
        annotation (Line(points={{-53,6},{-44,6}}, color={0,0,127}));
      connect(ufPuIn.y, GEN_.ufPuIn)
        annotation (Line(points={{-53,-18},{-48,-18},{-48,-2},{-44,-2}},
                                                                color={0,0,127}));
      connect(GRIDL_.terminal, NTHV.terminal)
        annotation (Line(points={{66,-30},{66,-18},{30,-18}}));
      connect(GEN_.terminal, NTLV.terminal)
        annotation (Line(points={{-34,2},{-34,-18},{-6,-18}}));
      connect(NTLV.terminal, TGEN.terminalA) annotation (
        Line(points={{-6,-18},{2,-18}}));
      connect(TGEN.terminalB, NTHV.terminal) annotation (
        Line(points={{22,-18},{30,-18}}));
      connect(NTHV.terminal, GRID_.terminal)
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
    /*
  extends StaticGrid3(
    GRIDL_(
      PRef = GRIDL_.PRefConst*(if time < 1 then 1 else 2) "Active power consumption at reference voltage",
      QRef = GRIDL_.QRefConst*(if time < 1 then 1 else 2) "Reactive power consumption at reference voltage"),
    break PmPu,
    break ufPuIn,
    break GEN_);

*/

      PowerGridsMC.Examples.IEEE14bus.ControlledGeneratorR GEN_(GEN(
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
        showPFdata=true,
        portVariablesPu=true,
        rFixed=419/21)   annotation (
        Placement(visible = true, transformation(origin={0,10},      extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerGridsMC.Electrical.Buses.EquivalentGridR GRID_(
        R_X=1/10,
        SNom=500000000,
        SSC=2500000000,
        UNom=380000,
        c=1.1,
        portVariablesPhases=true,
        portVariablesPu=true) annotation (Placement(visible=true, transformation(
            origin={38,20},
            extent={{-10,-10},{10,10}},
            rotation=0)));
      PowerGridsMC.Electrical.Loads.LoadPQVoltageDependenceR GRIDL_(
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
      connect(GRIDL_.terminal,NTHV. terminal)
        annotation (Line(points={{50,-6},{50,10},{20,10}}));
      connect(GEN_.terminal,NTLV. terminal)
        annotation (Line(points={{-38,10},{-18,10}}));
      connect(NTLV.terminal,TGEN. terminalA) annotation (
        Line(points={{-18,10},{-10,10}}));
      connect(TGEN.terminalB,NTHV. terminal) annotation (
        Line(points={{10,10},{20,10}}));
      connect(NTHV.terminal,GRID_. terminal)
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

  model PFGridParis
    "Modello Paris SI con tensioni ai morsetti delle macchine unitarie"
      extends Modelica.Icons.Example;
    PowerGridsMC.Electrical.PowerFlow.SlackBusW gen42x2_(
      SNom(displayUnit="MVA") = 100000000,
      U(displayUnit="kV") = 15700,
      UNom(displayUnit="kV") = 15700) annotation (Placement(visible=true,
          transformation(
          origin={58,-58},
          extent={{-10,10},{10,-10}},
          rotation=90)));
    PowerGridsMC.Electrical.PowerFlow.PVBusW gen33x2_(
      P(displayUnit="MW") = -100000000,
      SNom(displayUnit="MVA") = 100000000,
      U(displayUnit="kV") = 13800,
      UNom(displayUnit="kV") = 13800,
      portVariablesPhases=true) annotation (Placement(visible=true,
          transformation(
          origin={-96,48},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    PowerGridsMC.Electrical.PowerFlow.PQBusW pq31_(
      P(displayUnit="MW") = 200000000,
      Q(displayUnit="MVA") = 100000000,
      SNom(displayUnit="MVA") = 100000000,
      UNom(displayUnit="kV") = 129000) annotation (Placement(visible=true,
          transformation(
          origin={-100,-38},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    PowerGridsMC.Electrical.Branches.TransformerFixedRatio T4_iX2(SNom(displayUnit = "MW") = 190e6 * 2, UNomA(displayUnit = "kV") = 236100, UNomB(displayUnit = "kV") = 236100, X = 0.04828 * 220 ^ 2 / 100 / 2) annotation (
      Placement(visible = true, transformation(origin={0,-42},    extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    PowerGridsMC.Electrical.Branches.LineConstantImpedance L3_2(B = 75e3 * line.Yd, R = 75e3 * line.Rd, SNom(displayUnit = "MW") = 100000000, UNom(displayUnit = "kV") = 220000, UNomA(displayUnit = "kV") = 220000, UNomB(displayUnit = "kV") = 220000, X = 75e3 * line.Xd, showPFdata = true) annotation (
      Placement(visible = true, transformation(origin={-30,18},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PowerGridsMC.Electrical.PowerFlow.PVBusW gen11x2_(
      P(displayUnit="MW") = -200000000,
      SNom(displayUnit="MVA") = 100000000,
      U(displayUnit="kV") = 13800,
      UNom(displayUnit="kV") = 13800,
      portVariablesPhases=true) annotation (Placement(visible=true,
          transformation(
          origin={0,90},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    PowerGridsMC.Electrical.Branches.TransformerFixedRatio T1_11_2(R = 377 / 110e3 * 240 ^ 2 / 110, SNom(displayUnit = "MW") = 110000000, UNomA(displayUnit = "kV") = 13800, UNomB(displayUnit = "kV") = 240000, X = 0.0999 * 240 ^ 2 / 110, rFixed = 240 / 13.8) annotation (
      Placement(visible = true, transformation(origin={10,60},    extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    PowerGridsMC.Electrical.Branches.LineConstantImpedance L2_1(B = 200e3 * line.Yd, R = 200e3 * line.Rd, SNom(displayUnit = "MW") = 100000000, UNom(displayUnit = "kV") = 220000, UNomA(displayUnit = "kV") = 220000, UNomB(displayUnit = "kV") = 220000, X = 200e3 * line.Xd) annotation (
      Placement(visible = true, transformation(origin={0,28},    extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    PowerGridsMC.Electrical.Branches.LineConstantImpedance L4_2(B = 90e3 * line.Yd, R = 90e3 * line.Rd, SNom(displayUnit = "MW") = 100000000, UNom(displayUnit = "V") = 1, UNomA(displayUnit = "kV") = 220000, UNomB(displayUnit = "kV") = 220000, X = 90e3 * line.Xd, showPFdata = true) annotation (
      Placement(visible = true, transformation(origin={0,-8},    extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    PowerGridsMC.Electrical.Branches.LineConstantImpedance L3_4(B = 50e3 * line.Yd, R = 50e3 * line.Rd, SNom(displayUnit = "MW") = 100000000, UNom(displayUnit = "kV") = 220000, UNomA(displayUnit = "kV") = 220000, UNomB(displayUnit = "kV") = 220000, X = 50e3 * line.Xd,
      showPFdata=true)                                                                                                                                                                                                         annotation (
      Placement(visible = true, transformation(origin={-32,-28},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PowerGridsMC.Electrical.Branches.TransformerFixedRatio T41_iX2(SNom(displayUnit = "MW") = 190e6 * 2, UNomA(displayUnit = "kV") = 236100, UNomB(displayUnit = "kV") = 127900, X = 0.02476 * 119 ^ 2 / 100 / 2, rFixed = 127.9 / 236.1) annotation (
      Placement(visible = true, transformation(origin={0,-68},    extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    PowerGridsMC.Electrical.Branches.TransformerFixedRatio T31_33_1(R = 273 / 75e3 * 132 ^ 2 / 75, SNom(displayUnit = "MW") = 75000000, UNomA(displayUnit = "kV") = 13800, UNomB(displayUnit = "kV") = 132000, X = 0.0965 * 132 ^ 2 / 75, rFixed = 132 / 13.8, showPFdata = true) annotation (
      Placement(visible = true, transformation(origin={-106,14},    extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    PowerGridsMC.Electrical.Branches.TransformerFixedRatio T2_i(SNom(displayUnit = "MW") = 125000000, UNomA(displayUnit = "kV") = 230000, UNomB(displayUnit = "kV") = 230000, X = 71.884e-3 * 220 ^ 2 / 100) annotation (
      Placement(visible = true, transformation(origin={60,18},    extent = {{10, -10}, {-10, 10}}, rotation = 90)));
    PowerGridsMC.Electrical.PowerFlow.PVBusW sc22_(
      P(displayUnit="MW") = 0,
      SNom(displayUnit="MVA") = 100000000,
      U(displayUnit="kV") = 10000,
      UNom(displayUnit="kV") = 10000) annotation (Placement(visible=true,
          transformation(
          origin={108,28},
          extent={{-10,-10},{10,10}},
          rotation=90)));
    PowerGridsMC.Electrical.Branches.TransformerFixedRatio T22_i(SNom(displayUnit = "MW") = 39000000, UNomA(displayUnit = "kV") = 230000, UNomB(displayUnit = "kV") = 10500, X = 0.1635 * 10.04 ^ 2 / 100, rFixed = 10.5 / 230, showPFdata = true) annotation (
      Placement(visible = true, transformation(origin={80,28},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PowerGridsMC.Electrical.Branches.TransformerFixedRatio T42_iX2(SNom(displayUnit = "MW") = 190e6 * 2, UNomA(displayUnit = "V") = 236.1, UNomB(displayUnit = "V") = 15.75, X = 0.017488 * 14.7 ^ 2 / 100 / 2, rFixed = 15.75 / 236.1, showPFdata = true) annotation (
      Placement(visible = true, transformation(origin={30,-58},    extent = {{10, -10}, {-10, 10}}, rotation = 180)));
    PowerGridsMC.Electrical.Branches.TransformerFixedRatio Teq31_3(R = 0.0948 * 230 ^ 2 / 160 / 30, SNom(displayUnit = "MW") = 160000000, UNomA(displayUnit = "kV") = 135000, UNomB(displayUnit = "kV") = 230000, X = 0.0948 * 230 ^ 2 / 160, rFixed = 230 / 135,
      showPFdata=true)                                                                                                                                                                                                         annotation (
      Placement(visible = true, transformation(origin={-70,-12},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PowerGridsMC.Electrical.PowerFlow.PQBusW pq41_(
      P(displayUnit="MW") = 100000000,
      Q(displayUnit="MVA") = 50000000,
      SNom(displayUnit="MVA") = 100000000,
      UNom(displayUnit="kV") = 119000) annotation (Placement(visible=true,
          transformation(
          origin={14,-86},
          extent={{-10,-10},{10,10}},
          rotation=90)));
    PowerGridsMC.Electrical.Branches.TransformerFixedRatio Teq2_21(R = 435 / 125e3 * 126.9 ^ 2 / 100, SNom(displayUnit = "MW") = 125000000, UNomA(displayUnit = "kV") = 230000, UNomB(displayUnit = "kV") = 132700, X = 0.0875 * 126.9 ^ 2 / 100, rFixed = 132.7 / 230) annotation (
      Placement(visible = true, transformation(origin={38,28},    extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Line line annotation (Placement(visible=true, transformation(
          origin={-61,-71.1304},
          extent={{-9.00002,-11.8696},{9.00002,9.13041}},
          rotation=0)));
    PowerGridsMC.Electrical.Branches.TransformerFixedRatio T21_i(SNom(displayUnit = "MW") = 125000000, UNomA(displayUnit = "kV") = 230000, UNomB(displayUnit = "kV") = 132700, X = 4.624e-3 * 126.9 ^ 2 / 100, rFixed = 132.7 / 230) annotation (
      Placement(visible = true, transformation(origin={60,38},    extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    PowerGridsMC.Electrical.PowerFlow.PQBusW pq21_(
      P(displayUnit="MW") = 200000000,
      Q(displayUnit="MVA") = 100000000,
      SNom(displayUnit="MVA") = 100000000,
      UNom(displayUnit="kV") = 127000) annotation (Placement(visible=true,
          transformation(
          origin={60,56},
          extent={{-10,10},{10,-10}},
          rotation=0)));
    PowerGridsMC.Electrical.Branches.TransformerFixedRatio T31_33_2(R = 273 / 75e3 * 132 ^ 2 / 75, SNom(displayUnit = "MW") = 75000000, UNomA(displayUnit = "kV") = 13800, UNomB(displayUnit = "kV") = 132000, X = 0.0965 * 132 ^ 2 / 75, rFixed = 132 / 13.8,
      showPFdata=true)                                                                                                                                                                                                         annotation (
      Placement(visible = true, transformation(origin={-88,14},    extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    PowerGridsMC.Electrical.Branches.TransformerFixedRatio T1_11_1(R = 377 / 110e3 * 240 ^ 2 / 110, SNom(displayUnit = "MW") = 110000000, UNomA(displayUnit = "kV") = 13800, UNomB(displayUnit = "kV") = 240000, X = 0.0999 * 240 ^ 2 / 110, rFixed = 240 / 13.8, showPFdata = true) annotation (
      Placement(visible = true, transformation(origin={-10,60},    extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  equation
    connect(T31_33_1.terminalB, pq31_.terminal)
      annotation (Line(points={{-106,4},{-106,-19},{-100,-19},{-100,-38}}));
    connect(L3_2.terminalB, L2_1.terminalB) annotation (
      Line(points={{-20,18},{0,18}}));
    connect(L2_1.terminalB, L4_2.terminalA) annotation (
      Line(points={{0,18},{0,2}}));
    connect(L3_4.terminalB, L4_2.terminalB) annotation (
      Line(points={{-22,-28},{0,-28},{0,-18}}));
    connect(T31_33_1.terminalB, Teq31_3.terminalA) annotation (
      Line(points={{-106,4},{-106,-12},{-80,-12}}));
    connect(L3_4.terminalA, Teq31_3.terminalB) annotation (
      Line(points={{-42,-28},{-50,-28},{-50,-12},{-60,-12}}));
    connect(L3_2.terminalA, Teq31_3.terminalB) annotation (
      Line(points={{-40,18},{-50,18},{-50,-12},{-60,-12}}));
    connect(T22_i.terminalB, sc22_.terminal)
      annotation (Line(points={{90,28},{90,27},{108,27},{108,28}}));
    connect(gen33x2_.terminal, T31_33_1.terminalA)
      annotation (Line(points={{-96,48},{-96,30},{-106,30},{-106,24}}));
    connect(T31_33_2.terminalB, Teq31_3.terminalA) annotation (
      Line(points={{-88,4},{-88,-12},{-80,-12}}));
    connect(T1_11_2.terminalB, L2_1.terminalA) annotation (
      Line(points={{10,50},{10,44},{0,44},{0,38}}));
    connect(T21_i.terminalA, T2_i.terminalA) annotation (
      Line(points={{60,28},{60,28}}));
    connect(T22_i.terminalA, T2_i.terminalA) annotation (
      Line(points={{70,28},{60,28}}));
    connect(Teq2_21.terminalA, T2_i.terminalB) annotation (
      Line(points={{38,18},{38,8},{60,8}}));
    connect(T21_i.terminalB, Teq2_21.terminalB) annotation (
      Line(points={{60,48},{38,48},{38,38}}));
    connect(pq21_.terminal, T21_i.terminalB)
      annotation (Line(points={{60,56},{60,48}}));
    connect(L2_1.terminalB, T2_i.terminalB) annotation (
      Line(points={{0,18},{38,18},{38,8},{60,8}}));
    connect(L4_2.terminalB, T4_iX2.terminalB) annotation (
      Line(points={{0,-18},{0,-32}}));
    connect(gen42x2_.terminal, T42_iX2.terminalB)
      annotation (Line(points={{58,-58},{40,-58}}));
    connect(T42_iX2.terminalA, T41_iX2.terminalA) annotation (
      Line(points={{20,-58},{0,-58}}));
    connect(T41_iX2.terminalA, T4_iX2.terminalA) annotation (
      Line(points={{0,-58},{0,-52}}));
    connect(T41_iX2.terminalB, pq41_.terminal)
      annotation (Line(points={{0,-78},{0,-86},{14,-86}}));
    connect(T31_33_2.terminalA, T31_33_1.terminalA) annotation (Line(points={{-88,24},
            {-88,30},{-106,30},{-106,24}},     color={0,0,0}));
    connect(T1_11_1.terminalB, L2_1.terminalA)
      annotation (Line(points={{-10,50},{-10,44},{0,44},{0,38}}, color={0,0,0}));
    connect(T1_11_2.terminalA, gen11x2_.terminal)
      annotation (Line(points={{10,70},{10,76},{0,76},{0,90}}, color={0,0,0}));
    connect(T1_11_1.terminalA, gen11x2_.terminal)
      annotation (Line(points={{-10,70},{-10,76},{0,76},{0,90}}, color={0,0,0}));
    annotation (
      Diagram(coordinateSystem(extent = {{-120, 100}, {120, -100}}), graphics={  Text(origin={64,-24},    lineColor = {238, 46, 47}, extent = {{-28, 6}, {28, -6}}, textString = "V. Info")}),
      Documentation(info = "<html>
    <p>Per i trasformatori a tre avvolgimenti <b>scelgo lo schema paris a stella con trasformatori ideali ai lati a pi&ugrave; bassa tensione</b>. Quindi: </p>
    <p>1) parto dai parametri nella base di sistema calcolati in &quot;Descrizione rete.docx&quot; </p>
    <p>2) li trasformo in ohm lato B (occorrer&agrave; usare tensione e potenza nominali usate per la conversione in base di sistema) </p>
    <p>3) alle porte esterne metto come tensione nominale la tensione nominale di targa del trasformatore </p>
    <p>4) alla porta interna metto come tensione nominale la tensione nominale del trasformatore al lato di pi&ugrave; alta tensione</p>
    </html>"));
  end PFGridParis;

  model TranStaticParis
    parameter Real alpha = 2;
    parameter Real beta = 2;
    extends Modelica.Icons.Example;
    Line line annotation (Placement(visible=true, transformation(
          origin={-129.5,-89.5},
          extent={{-10,-13},{10,10}},
          rotation=0)));
    PowerGridsMC.Electrical.Branches.LineConstantImpedance L2_1(B = 200e3 * line.Yd, R = 200e3 * line.Rd, SNom(displayUnit = "MW") = 100000000, UNom(displayUnit = "kV") = 220000, UNomA(displayUnit = "kV") = 220000, UNomB(displayUnit = "kV") = 220000, X = 200e3 * line.Xd) annotation (
      Placement(visible = true, transformation(origin = {-52.5, -12.5}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    PowerGridsMC.Electrical.Branches.TransformerFixedRatio T1_11_2(R = 377 / 110e3 * 240 ^ 2 / 110, SNom(displayUnit = "MW") = 110000000, UNomA(displayUnit = "kV") = 13800, UNomB(displayUnit = "kV") = 240000, X = 0.0999 * 240 ^ 2 / 110, rFixed = 240 / 13.8) annotation (
      Placement(visible = true, transformation(origin = {-45, 26.5}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    PowerGridsMC.Electrical.Branches.TransformerFixedRatio T1_11_1(R = 377 / 110e3 * 240 ^ 2 / 110, SNom(displayUnit = "MW") = 110000000, UNomA(displayUnit = "kV") = 13800, UNomB(displayUnit = "kV") = 240000, X = 0.0999 * 240 ^ 2 / 110, rFixed = 240 / 13.8, showPFdata = false) annotation (
      Placement(visible = true, transformation(origin = {-61.5, 25.5}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    PowerGridsMC.Electrical.Branches.LineConstantImpedance L3_2(B = 75e3 * line.Yd, R = 75e3 * line.Rd, SNom(displayUnit = "MW") = 100000000, UNom(displayUnit = "kV") = 220000, UNomA(displayUnit = "kV") = 220000, UNomB(displayUnit = "kV") = 220000, X = 75e3 * line.Xd,
      showPFdata=true)                                                                                                                                                                                                         annotation (
      Placement(visible = true, transformation(origin = {-73, -31}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PowerGridsMC.Electrical.Branches.LineConstantImpedance L4_2(B = 90e3 * line.Yd, R = 90e3 * line.Rd, SNom(displayUnit = "MW") = 100000000, UNom(displayUnit = "V") = 1, UNomA(displayUnit = "kV") = 220000, UNomB(displayUnit = "kV") = 220000, X = 90e3 * line.Xd,
      showPFdata=true)                                                                                                                                                                                                         annotation (
      Placement(visible = true, transformation(origin = {-52, -47}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    PowerGridsMC.Electrical.Branches.LineConstantImpedance L3_4(B = 50e3 * line.Yd, R = 50e3 * line.Rd, SNom(displayUnit = "MW") = 100000000, UNom(displayUnit = "kV") = 220000, UNomA(displayUnit = "kV") = 220000, UNomB(displayUnit = "kV") = 220000, X = 50e3 * line.Xd,
      showPFdata=true)                                                                                                                                                                                                         annotation (
      Placement(visible = true, transformation(origin = {-73.5, -61}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    inner PowerGridsMC.Electrical.System systemPowerGrids(initOpt = PowerGridsMC.Types.Choices.InitializationOption.globalSteadyStateFixedPowerFlow, referenceFrequency = PowerGridsMC.Types.Choices.ReferenceFrequency.fixedReferenceGenerator) annotation (
      Placement(visible = true, transformation(origin = {62, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.RealExpression uf11(y=gen11x2_.ufPuInStart)
      annotation (Placement(visible=true, transformation(
          origin={-118,46},
          extent={{-16,-8},{16,8}},
          rotation=0)));
    Modelica.Blocks.Sources.RealExpression pm42(y=-gen42x2_.PStart/gen42x2_.SNom)
      annotation (Placement(visible=true, transformation(
          origin={-1,-117},
          extent={{-7,-9},{7,9}},
          rotation=0)));
    PowerGridsMC.Electrical.Machines.SynchronousMachine4WindingsR gen11x2_(
      H=4,
      PStart(displayUnit="W") = gen11x2_.y[1, 3],
      QStart=gen11x2_.y[1, 4],
      SNom=2*110e6,
      Tpd0=5.143,
      Tppd0=0.042,
      Tppq0=0.083,
      Tpq0=2.16,
      UNom(displayUnit="V") = 13.8e3,
      UPhaseStart(displayUnit="rad") = gen11x2_.y[1, 2],
      UStart(displayUnit="V") = gen11x2_.y[1, 1],
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
          rotation=0)));
    PowerGridsMC.Electrical.Machines.SynchronousMachine4WindingsR gen33x2_(
      H=4,
      PStart(displayUnit="W") = gen33x2_.y[1, 3],
      QStart=gen33x2_.y[1, 4],
      SNom=2*78.1e6,
      Tpd0=5.143,
      Tppd0=0.042,
      Tppq0=0.083,
      Tpq0=2.16,
      UNom(displayUnit="V") = 13.8e3,
      UPhaseStart=gen33x2_.y[1, 2],
      UStart(displayUnit="V") = gen33x2_.y[1, 1],
      portVariablesPhases=true,
      raPu=0,
      xdPu=2,
      xlPu=0.15,
      xpdPu=0.35,
      xppdPu=0.25,
      xppqPu=0.3,
      xpqPu=0.5,
      xqPu=1.8) annotation (Placement(visible=true, transformation(
          origin={-108,18},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    PowerGridsMC.Electrical.Machines.SynchronousMachine4WindingsR gen42x2_(
      H=4,
      PStart=gen42x2_.y[1, 3],
      QStart=gen42x2_.y[1, 4],
      SNom=206*2e6,
      Tpd0=5.143,
      Tppd0=0.042,
      Tppq0=0.083,
      Tpq0=2.16,
      UNom=15700,
      UPhaseStart=gen42x2_.y[1, 2],
      UStart=gen42x2_.y[1, 1],
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
    PowerGridsMC.Electrical.Machines.SynchronousMachine4WindingsR sc22_(
      H=4,
      PStart=sc22_.y[1, 3],
      QStart=sc22_.y[1, 4],
      SNom=40000000,
      Tpd0=5.143,
      Tppd0=0.042,
      Tppq0=0.083,
      Tpq0=2.16,
      UNom=13800,
      UPhaseStart=sc22_.y[1, 2],
      UStart=sc22_.y[1, 1],
      portVariablesPhases=true,
      raPu=0,
      xdPu=2,
      xlPu=0.15,
      xpdPu=0.35,
      xppdPu=0.25,
      xppqPu=0.3,
      xpqPu=0.5,
      xqPu=1.8) annotation (Placement(visible=true, transformation(
          origin={32,18},
          extent={{10,-10},{-10,10}},
          rotation=0)));
    Modelica.Blocks.Sources.RealExpression pm11(y=-gen11x2_.PStart/gen11x2_.SNom)
      annotation (Placement(visible=true, transformation(
          origin={-126,70},
          extent={{-22,-8},{22,8}},
          rotation=0)));
    Modelica.Blocks.Sources.RealExpression uf42(y=gen42x2_.ufPuInStart)
      annotation (Placement(visible=true, transformation(
          origin={0,-132},
          extent={{-8,-10},{8,10}},
          rotation=0)));
    PowerGridsMC.Electrical.Loads.LoadPQVoltageDependenceR pq31_(
      PStart=pq31_.y[1, 3],
      QStart=pq31_.y[1, 4],
      PRefConst=pq31_.y[1, 3],
      QRefConst=pq31_.y[1, 4],
      SNom(displayUnit="V.A") = 100000000,
      UNom(displayUnit="V") = 129e3,
      UPhaseStart(displayUnit="rad") = pq31_.y[1, 2],
      UStart(displayUnit="V") = pq31_.y[1, 1],
      alpha=alpha,
      beta=beta,
      portVariablesPhases=true,
      URef=pq31_.y[1, 1]) annotation (Placement(visible=true, transformation(
          origin={-148.5,-57},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    PowerGridsMC.Electrical.Branches.TransformerFixedRatio Teq31_3(R = 0.0948 * 230 ^ 2 / 160 / 30, SNom(displayUnit = "MW") = 160000000, UNomA(displayUnit = "kV") = 135000, UNomB(displayUnit = "kV") = 230000, X = 0.0948 * 230 ^ 2 / 160, rFixed = 230 / 135) annotation (
      Placement(visible = true, transformation(origin = {-118, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PowerGridsMC.Electrical.Branches.TransformerFixedRatio T31_33_1(R = 273 / 75e3 * 132 ^ 2 / 75, SNom(displayUnit = "MW") = 75000000, UNomA(displayUnit = "kV") = 13800, UNomB(displayUnit = "kV") = 132000, X = 0.0965 * 132 ^ 2 / 75, rFixed = 132 / 13.8, showPFdata = false) annotation (
      Placement(visible = true, transformation(origin = {-148, -22}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    PowerGridsMC.Electrical.Branches.TransformerFixedRatio T31_33_2(R = 273 / 75e3 * 132 ^ 2 / 75, SNom(displayUnit = "MW") = 75000000, UNomA(displayUnit = "kV") = 13800, UNomB(displayUnit = "kV") = 132000, X = 0.0965 * 132 ^ 2 / 75, rFixed = 132 / 13.8) annotation (
      Placement(visible = true, transformation(origin = {-130, -22}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Sources.RealExpression uf33(y=gen33x2_.ufPuInStart)
      annotation (Placement(visible=true, transformation(
          origin={-141,6},
          extent={{-9,-10},{9,10}},
          rotation=0)));
    Modelica.Blocks.Sources.RealExpression pm33(y=-gen33x2_.PStart/gen33x2_.SNom)
      annotation (Placement(visible=true, transformation(
          origin={-138,22},
          extent={{-12,-8},{12,8}},
          rotation=0)));
    PowerGridsMC.Electrical.Branches.TransformerFixedRatio T2_i(SNom(displayUnit = "MW") = 125000000, UNomA(displayUnit = "kV") = 230000, UNomB(displayUnit = "kV") = 230000, X = 71.884e-3 * 220 ^ 2 / 100) annotation (
      Placement(visible = true, transformation(origin = {-6, -22}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
    PowerGridsMC.Electrical.Branches.TransformerFixedRatio Teq2_21(R = 435 / 125e3 * 126.9 ^ 2 / 100, SNom(displayUnit = "MW") = 125000000, UNomA(displayUnit = "kV") = 230000, UNomB(displayUnit = "kV") = 132700, X = 0.0875 * 126.9 ^ 2 / 100, rFixed = 132.7 / 230) annotation (
      Placement(visible = true, transformation(origin = {-28, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    PowerGridsMC.Electrical.Branches.TransformerFixedRatio T22_i(SNom(displayUnit = "MW") = 39000000, UNomA(displayUnit = "kV") = 230000, UNomB(displayUnit = "kV") = 10500, X = 0.1635 * 10.04 ^ 2 / 100, rFixed = 10.5 / 230,
      showPFdata=true)                                                                                                                                                                                                        annotation (
      Placement(visible = true, transformation(origin = {14, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PowerGridsMC.Electrical.Branches.TransformerFixedRatio T21_i(SNom(displayUnit = "MW") = 125000000, UNomA(displayUnit = "kV") = 230000, UNomB(displayUnit = "kV") = 132700, X = 4.624e-3 * 126.9 ^ 2 / 100, rFixed = 132.7 / 230) annotation (
      Placement(visible = true, transformation(origin = {-6, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Blocks.Sources.RealExpression pmSc(y = 0) annotation (
      Placement(visible = true, transformation(origin = {54, 37}, extent = {{8, -9}, {-8, 9}}, rotation = 0)));
    Modelica.Blocks.Sources.RealExpression ufSC(y=sc22_.ufPuInStart)
      annotation (Placement(visible=true, transformation(
          origin={54,1},
          extent={{8,-9},{-8,9}},
          rotation=0)));
    PowerGridsMC.Electrical.Buses.BusFault bus1(R = 1, SNom(displayUnit = "V.A") = 500000000, UNom(displayUnit = "V") = 234000, X = 0, portVariablesPhases = true, portVariablesPu = true,
      startTime=0.5,
      stopTime=0.6)                                                                                                                                                                                                       annotation (
      Placement(visible = true, transformation(origin = {-52, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PowerGridsMC.Electrical.Branches.TransformerFixedRatio transformerFixedRatio(SNom(displayUnit = "MW") = 190e6 * 2, UNomA(displayUnit = "V") = 236.1, UNomB(displayUnit = "V") = 15.75, X = 0.017488 * 14.7 ^ 2 / 100 / 2, rFixed = 15.75 / 236.1) annotation (
      Placement(visible = true, transformation(origin = {-4, -84}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
    PowerGridsMC.Electrical.Branches.TransformerFixedRatio T4_iX2(SNom(displayUnit = "MW") = 190e6 * 2, UNomA(displayUnit = "kV") = 236100, UNomB(displayUnit = "kV") = 236100, X = 0.04828 * 220 ^ 2 / 100 / 2) annotation (
      Placement(visible = true, transformation(origin={-28,-72},    extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    PowerGridsMC.Electrical.Buses.ReferenceBus bus42(SNom(displayUnit = "V.A") = 5e+08, UNom(displayUnit = "V") = 15700, portVariablesPhases = true, portVariablesPu = true) annotation (
      Placement(visible = true, transformation(origin = {16, -84}, extent = {{-10, 10}, {10, -10}}, rotation = 90)));
    PowerGridsMC.Electrical.Branches.TransformerFixedRatio T41_iX2(SNom(displayUnit = "MW") = 190e6 * 2, UNomA(displayUnit = "kV") = 236100, UNomB(displayUnit = "kV") = 127900, X = 0.02476 * 119 ^ 2 / 100 / 2, rFixed = 127.9 / 236.1) annotation (
      Placement(visible = true, transformation(origin = {-28, -94}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    PowerGridsMC.Electrical.Buses.Bus bus3(SNom(displayUnit = "V.A") = 100e6, UNom(displayUnit = "V") = 220e3, portVariablesPhases = true, portVariablesPu = true) annotation (
      Placement(visible = true, transformation(origin = {-95.5, -43.5}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    PowerGridsMC.Electrical.Loads.LoadPQVoltageDependenceR pq21_(
      PStart=pq21_.y[1, 3],
      QStart=pq21_.y[1, 4],
      PRefConst=pq21_.y[1, 3],
      QRefConst=pq21_.y[1, 4],
      SNom(displayUnit="V.A") = 100000000,
      UNom(displayUnit="V") = 127000,
      UPhaseStart(displayUnit="rad") = pq21_.y[1, 2],
      UStart(displayUnit="V") = pq21_.y[1, 1],
      alpha=alpha,
      beta=beta,
      URef=pq21_.y[1, 1]) annotation (Placement(visible=true, transformation(
          origin={-6,20},
          extent={{-10,10},{10,-10}},
          rotation=0)));
    PowerGridsMC.Electrical.Loads.LoadPQVoltageDependenceR pq41_(
      PStart=pq41_.y[1, 3],
      QStart=pq41_.y[1, 4],
      PRefConst=pq41_.y[1, 3],
      QRefConst=pq41_.y[1, 4],
      SNom(displayUnit="V.A") = 100000000,
      UNom(displayUnit="V") = 119000,
      UPhaseStart(displayUnit="rad") = pq41_.y[1, 2],
      UStart(displayUnit="V") = pq41_.y[1, 1],
      alpha=alpha,
      beta=beta,
      URef=pq41_.y[1, 1]) annotation (Placement(visible=true, transformation(
          origin={-44,-112},
          extent={{-10,10},{10,-10}},
          rotation=90)));
  equation
    connect(T1_11_2.terminalA, T1_11_1.terminalA) annotation (
      Line(points = {{-45, 36.5}, {-45, 38}, {-61.5, 38}, {-61.5, 35.5}}));
    connect(T1_11_2.terminalB, T1_11_1.terminalB) annotation (
      Line(points = {{-45, 16.5}, {-45, 15.5}, {-61.5, 15.5}}));
    connect(L3_2.terminalB, L2_1.terminalB) annotation (
      Line(points = {{-63, -31}, {-52.5, -31}, {-52.5, -22.5}}, color = {0, 0, 0}));
    connect(L2_1.terminalB, L4_2.terminalA) annotation (
      Line(points = {{-52.5, -22.5}, {-52.5, -37}, {-52, -37}}));
    connect(L4_2.terminalB, L3_4.terminalB) annotation (
      Line(points = {{-52, -57}, {-51.75, -57}, {-51.75, -61}, {-63.5, -61}}));
    connect(gen42x2_.PmPu, pm42.y) annotation (Line(points={{24,-102},{16,-102},
            {16,-117},{6.7,-117}}, color={0,0,127}));
    connect(gen42x2_.ufPuIn, uf42.y) annotation (Line(points={{24,-110},{22,-110},
            {22,-132},{8.8,-132}}, color={0,0,127}));
    connect(gen42x2_.omega, systemPowerGrids.omegaRefIn) annotation (Line(
          points={{44.1,-100.1},{50.1,-100.1},{50.1,-99.8},{52.2,-99.8}}, color
          ={0,0,127}));
    connect(pm11.y, gen11x2_.PmPu) annotation (Line(points={{-101.8,70},{-96,70},
            {-96,60},{-88,60}}, color={0,0,127}));
    connect(uf11.y, gen11x2_.ufPuIn) annotation (Line(points={{-100.4,46},{-96,
            46},{-96,52},{-88,52}}, color={0,0,127}));
    connect(T31_33_1.terminalB, pq31_.terminal) annotation (Line(points={{-148,
            -32},{-148,-44.5},{-148.5,-44.5},{-148.5,-57}}));
    connect(T31_33_2.terminalB, Teq31_3.terminalA) annotation (
      Line(points = {{-130, -32}, {-130, -44}, {-128, -44}}));
    connect(T31_33_1.terminalB, Teq31_3.terminalA) annotation (
      Line(points = {{-148, -32}, {-148, -44}, {-128, -44}}));
    connect(pm33.y, gen33x2_.PmPu)
      annotation (Line(points={{-124.8,22},{-118,22}}, color={0,0,127}));
    connect(gen33x2_.ufPuIn, uf33.y) annotation (Line(points={{-118,14},{-124,
            14},{-124,6},{-131.1,6}}, color={0,0,127}));
    connect(T31_33_1.terminalA, T31_33_2.terminalA) annotation (
      Line(points = {{-148, -12}, {-130, -12}}));
    connect(gen33x2_.terminal, T31_33_2.terminalA)
      annotation (Line(points={{-108,18},{-108,-12},{-130,-12}}));
    connect(T22_i.terminalA, T2_i.terminalA) annotation (
      Line(points = {{4, -12}, {-6, -12}}));
    connect(Teq2_21.terminalA, T2_i.terminalB) annotation (
      Line(points = {{-28, -22}, {-28, -32}, {-6, -32}}));
    connect(T21_i.terminalA, T2_i.terminalA) annotation (
      Line(points={{-6,-12},{-6,-12}}));
    connect(T21_i.terminalB, Teq2_21.terminalB) annotation (
      Line(points = {{-6, 8}, {-28, 8}, {-28, -2}}));
    connect(Teq2_21.terminalA, L2_1.terminalB) annotation (
      Line(points = {{-28, -22}, {-40, -22}, {-40, -22.5}, {-52.5, -22.5}}));
    connect(sc22_.terminal, T22_i.terminalB)
      annotation (Line(points={{32,18},{32,-12},{24,-12}}));
    connect(sc22_.PmPu, pmSc.y) annotation (Line(points={{42,22},{40,22},{40,37},
            {45.2,37}}, color={0,0,127}));
    connect(ufSC.y, sc22_.ufPuIn)
      annotation (Line(points={{45.2,1},{42,1},{42,14}}, color={0,0,127}));
    connect(T1_11_1.terminalB, bus1.terminal) annotation (
      Line(points = {{-61.5, 15.5}, {-52, 15.5}, {-52, 6}}));
    connect(L2_1.terminalA, bus1.terminal) annotation (
      Line(points = {{-52.5, -2.5}, {-52.5, 2}, {-52, 2}, {-52, 6}}));
    connect(transformerFixedRatio.terminalB, bus42.terminal) annotation (
      Line(points = {{6, -84}, {16, -84}}));
    connect(transformerFixedRatio.terminalA, T41_iX2.terminalA) annotation (
      Line(points = {{-14, -84}, {-28, -84}}));
    connect(T41_iX2.terminalA, T4_iX2.terminalA) annotation (
      Line(points={{-28,-84},{-28,-82}}));
    connect(T4_iX2.terminalB, L4_2.terminalB) annotation (
      Line(points={{-28,-62},{-52,-62},{-52,-57}}));
    connect(bus42.terminal, gen42x2_.terminal)
      annotation (Line(points={{16,-84},{34,-84},{34,-106}}));
    connect(Teq31_3.terminalB, bus3.terminal) annotation (
      Line(points = {{-108, -44}, {-102, -44}, {-102, -43.5}, {-95.5, -43.5}}));
    connect(L3_2.terminalA, bus3.terminal) annotation (
      Line(points = {{-83, -31}, {-88, -31}, {-88, -43.5}, {-95.5, -43.5}}));
    connect(L3_4.terminalA, bus3.terminal) annotation (
      Line(points = {{-83.5, -61}, {-88, -61}, {-88, -43.5}, {-95.5, -43.5}}));
    connect(pq21_.terminal, T21_i.terminalB)
      annotation (Line(points={{-6,20},{-6,8}}));
    connect(T41_iX2.terminalB, pq41_.terminal)
      annotation (Line(points={{-28,-104},{-28,-112},{-44,-112}}));
    connect(gen11x2_.terminal, T1_11_1.terminalA) annotation (Line(points={{-78,
            56},{-52,56},{-52,38},{-61.5,38},{-61.5,35.5}}));
    annotation (
      Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}})),
      Diagram(coordinateSystem(extent = {{-160, 80}, {80, -140}}), graphics={  Text(origin = {-7, 64}, extent = {{-19, 6}, {19, -6}}, textString = "v. info")}),
      experiment(StopTime = 6, Interval = 0.00400267, Tolerance = 1e-06, StartTime = 0),
      __OpenModelica_simulationFlags(lv = "LOG_STATS", outputFormat = "mat", s = "dassl"),
      Documentation(info="<html>
<p>Questo modello si collega al Power Flow della cartella PFD_SIwip, attraverso il salvataggio dei dati automatico del PF su file.</p>
<p>Converge bene e d&agrave; risultati ragionevoli.</p>
<p>Occorre notare che, per ottenerne la convergenza, i carichi non sono a a P e Q costanti, ma con alpha e beta che per default hanno valore pari a 2.</p>
<p>Questo fa s&igrave; che la condizione iniziale del transitorio &egrave; differente da quella ottenuta nel PF. <b>Essa per&ograve; rispetta i valori di potenza imposti nei nodi PV e di saldo</b>. Si tratta quindi di una soluzione che non ha una grande significativit&agrave; fisica. <span style=\"color: #ee2e2f;\">Occorre provare a vedere se si riesce a fare un PF con nodi PQ con alfa e beta, in modo da raccordare meglio PF e dinamica.</span></p>
<p>Se si abbassano i valori di alfa e beta a 1 o anche a 0.5 i valori iniziali del transitorio di avvicinano significativamente a quelli del pf, come atteso.</p>
<p>con il caso alpha=beta=0.5, per&ograve;, la simulazione non converge durante il corto circuito (ma converge e d&agrave; valori ragionevoli nella parte iniziale del transitorio, prima del corto). </p>
</html>"));
  end TranStaticParis;

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
