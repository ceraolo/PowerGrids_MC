within PowerGridsMC.Examples.ENTSOE;
model TestCase2 "Test Case 2, Section 5.2, focuses on the dynamic behavior of the model for the synchronous generator and its governor"
  extends Modelica.Icons.Example;
  inner PowerGridsMC.Electrical.System systemPowerGrids annotation (
    Placement(transformation(origin={28,36},    extent = {{-10, -10}, {10, 10}})));
  PowerGridsMC.Electrical.Machines.SynchronousMachine4Windings GEN(H = 4, PStart = -3.8e+08, QStart = 0, SNom = 4.75e+08, Tpd0 = 5.143, Tppd0 = 0.042, Tppq0 = 0.083, Tpq0 = 2.16, UNom = 21000, UPhaseStart = 0, UStart = 21000, portVariablesPhases = true, raPu = 0, referenceGenerator = true, xdPu = 2, xlPu = 0.15, xpdPu = 0.35, xppdPu = 0.25, xppqPu = 0.3, xpqPu = 0.5, xqPu = 1.8) annotation (
    Placement(transformation(origin={-8,6},     extent={{-10,10},{10,-10}})));
  PowerGridsMC.Electrical.Buses.ReferenceBus NGEN(SNom = 5e+08, UNom = 21000, portVariablesPhases = true, portVariablesPu = true) annotation (
    Placement(transformation(origin={60,-10},    extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  PowerGridsMC.Electrical.Controls.TurbineGovernors.IEEE_TGOV1 TGOV(R = 0.05, T1 = 0.5, T2 = 3, T3 = 10, VMax = 1) annotation (
    Placement(transformation(origin={-44,34},    extent = {{-10, 10}, {10, -10}})));
  PowerGridsMC.Electrical.Controls.ExcitationSystems.IEEE_AC4A AVR(Ka = 200, Ta = 0.05, Tb = 10, Tc = 3, VrMax = 4) annotation (
    Placement(transformation(origin={-44,-10},    extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.RealExpression zero annotation (
    Placement(transformation(origin={-86,-34},     extent = {{-12, -10}, {12, 10}})));
  Modelica.Blocks.Sources.RealExpression VrefPu(y = 1.00943) annotation (
    Placement(transformation(origin={-86,-19},     extent = {{-12, -11}, {12, 11}})));
  Modelica.Blocks.Sources.RealExpression RefLPu(y = 380 / 475 * 0.05) annotation (
    Placement(transformation(origin={-80,30},    extent = {{-10, -10}, {10, 10}})));
  PowerGridsMC.Electrical.Loads.LoadZetaInputs LOAD(
    PStart=3.8e+08,
    SNom=4.75e+08,
    UNom=21000,
    portVariablesPhases=true,
    portVariablesPu=true) annotation (Placement(transformation(origin={68,-32},
          extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Step PLoad(height = 23.75e6, offset = 380e6, startTime = 0.1)  annotation (
    Placement(transformation(origin={2,-34},      extent = {{-8, -8}, {8, 8}})));
  Modelica.Blocks.Sources.RealExpression zero2 annotation (
    Placement(transformation(origin={32,-52},     extent = {{-12, -10}, {12, 10}})));

  Types.PerUnit AA_01_GEN_UPu = GEN.port.VPu "Fig. 5-3, terminal voltage";
  Types.PerUnit AA_02_GEN_PPu = GEN.port.PGenPu "Fig. 5-4, active power of the synchronous machine";
  Types.PerUnit AA_03_GEN_PmechPu=GEN.pmPuIn
    "Fig. 5-5, mechanical power of the synchronous machine";
  Types.PerUnit AA_04_GEN_omegaPu = GEN.omegaPu "Fig. 5-6, speed";

  Electrical.Sensors.UIsensorC uIsensC(showPortData=false)
    annotation (Placement(transformation(extent={{4,-20},{24,0}})));
  Electrical.Sensors.MultisensorR multisens(showPortData=false)
    annotation (Placement(transformation(extent={{30,-20},{50,0}})));
equation
  connect(GEN.VPu, AVR.VcPu) annotation (
    Line(points={{2.2,12},{10,12},{10,52},{-96,52},{-96,-8},{-54,-8}},              color = {0, 0, 127}));
  connect(zero2.y, LOAD.QRefIn) annotation (
    Line(points={{45.2,-52},{49.4,-52},{49.4,-42},{58,-42}},            color = {0, 0, 127}));
  connect(zero.y, AVR.VuelPu) annotation (
    Line(points={{-72.8,-34},{-61.6,-34},{-61.6,-16},{-54,-16}},            color = {0, 0, 127}));
  connect(zero.y, AVR.VsPu) annotation (
    Line(points={{-72.8,-34},{-61.8,-34},{-61.8,-4},{-54,-4}},            color = {0, 0, 127}));
  connect(VrefPu.y, AVR.VrefPu) annotation (
    Line(points={{-72.8,-19},{-67.6,-19},{-67.6,-12},{-54,-12}},            color = {0, 0, 127}));
  connect(PLoad.y, LOAD.PRefIn) annotation (
    Line(points={{10.8,-34},{52,-34},{52,-36},{58,-36}},                color = {0, 0, 127}));
  connect(NGEN.terminal, LOAD.terminal) annotation (
    Line(points={{60,-10},{68,-10},{68,-32}}));
  connect(RefLPu.y, TGOV.RefLPu) annotation (
    Line(points={{-69,30},{-54.4,30}},    color = {0, 0, 127}));
  connect(AVR.efdPu, GEN.ufPuIn) annotation (
    Line(points={{-33,-10},{-26,-10},{-26,10},{-18.4,10}},                                                      color = {0, 0, 127}));
  connect(GEN.omegaPu, TGOV.omegaPu) annotation (
    Line(points={{2.2,4},{6,4},{6,48},{-60,48},{-60,38},{-54.4,38}},                color = {0, 0, 127}));
  connect(TGOV.PMechPu, GEN.pmPuIn) annotation (Line(points={{-33.4,34},{-30,34},
          {-30,4},{-22,4},{-22,2.6},{-18.4,2.6}}, color={0,0,127}));
  connect(uIsensC.terminalA, GEN.terminal)
    annotation (Line(points={{4,-10},{-8,-10},{-8,6}}, color={0,0,0}));
  connect(uIsensC.terminalB, multisens.terminalA)
    annotation (Line(points={{24,-10},{30,-10}}, color={0,0,0}));
  connect(multisens.terminalB, NGEN.terminal)
    annotation (Line(points={{50,-10},{60,-10}}, color={0,0,0}));
  annotation (
    Diagram(coordinateSystem(extent={{-100,-60},{80,60}})),
    experiment(StartTime = 0, StopTime = 2, Tolerance = 1e-6, Interval = 0.004),
    __OpenModelica_commandLineOptions = "--daeMode --tearingMethod=minimalTearing",
    __OpenModelica_simulationFlags(nls="kinsol", lv="LOG_INIT_HOMOTOPY", homotopyOnFirstTry="()"),
    Documentation(info="<html>
<p><i><span style=\"font-family: Arial; font-size: 12pt;\">Library PowerGridsMC was forked from https://github.com/PowerGrids/PowerGrids on 22 November 2024.</span></i></p>
<p><i><span style=\"font-size: 12pt;\">The following info is derived from the original version on that source, modified whenever changes introduced in this fork require this.</span></i></p>
<p>**************************</p>
<p>nothing </p>
<p>**************************</p>
<p>New in PowerLibMC is the component UIsensor, whose behaviour is checked in this example.</p>
</html>"));
end TestCase2;
