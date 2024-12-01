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
    /*
  extends StaticGrid3(
    GRIDL_(
      PRef = GRIDL_.PRefConst*(if time < 1 then 1 else 2) "Active power consumption at reference voltage",
      QRef = GRIDL_.QRefConst*(if time < 1 then 1 else 2) "Reactive power consumption at reference voltage"),
    break PmPu,
    break ufPuIn,
    break GEN_);

*/

      PowerGridsMC.Examples.IEEE14bus.ControlledGeneratorR GEN(GEN(
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
