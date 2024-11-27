within PowerGridsMC.Examples.ENTSOE;
model TestCase2 "Test Case 2, Section 5.2, focuses on the dynamic behavior of the model for the synchronous generator and its governor"
  extends Modelica.Icons.Example;
  inner PowerGridsMC.Electrical.System systemPowerGrids annotation (
    Placement(transformation(origin = {10, 36}, extent = {{-10, -10}, {10, 10}})));
  PowerGridsMC.Electrical.Machines.SynchronousMachine4Windings GEN(H = 4, PStart = -3.8e+08, QStart = 0, SNom = 4.75e+08, Tpd0 = 5.143, Tppd0 = 0.042, Tppq0 = 0.083, Tpq0 = 2.16, UNom = 21000, UPhaseStart = 0, UStart = 21000, portVariablesPhases = true, raPu = 0, referenceGenerator = true, xdPu = 2, xlPu = 0.15, xpdPu = 0.35, xppdPu = 0.25, xppqPu = 0.3, xpqPu = 0.5, xqPu = 1.8) annotation (
    Placement(transformation(origin = {-26, 6}, extent = {{-10, -10}, {10, 10}})));
  PowerGridsMC.Electrical.Buses.ReferenceBus NGEN(SNom = 5e+08, UNom = 21000, portVariablesPhases = true, portVariablesPu = true) annotation (
    Placement(transformation(origin = {14, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  PowerGridsMC.Electrical.Controls.TurbineGovernors.IEEE_TGOV1 TGOV(R = 0.05, T1 = 0.5, T2 = 3, T3 = 10, VMax = 1) annotation (
    Placement(transformation(origin = {-62, 34}, extent = {{-10, 10}, {10, -10}})));
  PowerGridsMC.Electrical.Controls.ExcitationSystems.IEEE_AC4A AVR(Ka = 200, Ta = 0.05, Tb = 10, Tc = 3, VrMax = 4) annotation (
    Placement(transformation(origin = {-62, -10}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.RealExpression zero annotation (
    Placement(transformation(origin = {-104, -34}, extent = {{-12, -10}, {12, 10}})));
  Modelica.Blocks.Sources.RealExpression VrefPu(y = 1.00943) annotation (
    Placement(transformation(origin = {-104, -19}, extent = {{-12, -11}, {12, 11}})));
  Modelica.Blocks.Sources.RealExpression RefLPu(y = 380 / 475 * 0.05) annotation (
    Placement(transformation(origin = {-98, 30}, extent = {{-10, -10}, {10, 10}})));
  PowerGridsMC.Electrical.Loads.LoadImpedancePQInputs LOAD(PStart = 3.8e+08, SNom = 4.75e+08, UNom = 21000, portVariablesPhases = true, portVariablesPu = true) annotation (
    Placement(transformation(origin = {22, -32}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Step PLoad(height = 23.75e6, offset = 380e6, startTime = 0.1)  annotation (
    Placement(transformation(origin = {-18, -28}, extent = {{-8, -8}, {8, 8}})));
  Modelica.Blocks.Sources.RealExpression zero2 annotation (
    Placement(transformation(origin = {-18, -52}, extent = {{-12, -10}, {12, 10}})));

  Types.PerUnit AA_01_GEN_UPu = GEN.port.VPu "Fig. 5-3, terminal voltage";
  Types.PerUnit AA_02_GEN_PPu = GEN.port.PGenPu "Fig. 5-4, active power of the synchronous machine";
  Types.PerUnit AA_03_GEN_PmechPu = GEN.PmPu "Fig. 5-5, mechanical power of the synchronous machine";
  Types.PerUnit AA_04_GEN_omegaPu = GEN.omegaPu "Fig. 5-6, speed";

equation
  connect(GEN.VPu, AVR.VcPu) annotation (
    Line(points = {{-16, 0}, {-8, 0}, {-8, 52}, {-114, 52}, {-114, -8}, {-72, -8}}, color = {0, 0, 127}));
  connect(zero2.y, LOAD.QRefIn) annotation (
    Line(points={{-4.8,-52},{-0.6,-52},{-0.6,-42},{12,-42}},            color = {0, 0, 127}));
  connect(zero.y, AVR.VuelPu) annotation (
    Line(points={{-90.8,-34},{-79.6,-34},{-79.6,-16},{-72,-16}},            color = {0, 0, 127}));
  connect(zero.y, AVR.VsPu) annotation (
    Line(points={{-90.8,-34},{-79.8,-34},{-79.8,-4},{-72,-4}},            color = {0, 0, 127}));
  connect(VrefPu.y, AVR.VrefPu) annotation (
    Line(points={{-90.8,-19},{-85.6,-19},{-85.6,-12},{-72,-12}},            color = {0, 0, 127}));
  connect(PLoad.y, LOAD.PRefIn) annotation (
    Line(points={{-9.2,-28},{-0.2,-28},{-0.2,-36},{12,-36}},            color = {0, 0, 127}));
  connect(NGEN.terminal, LOAD.terminal) annotation (
    Line(points = {{14, -14}, {22, -14}, {22, -32}}));
  connect(RefLPu.y, TGOV.RefLPu) annotation (
    Line(points = {{-87, 30}, {-72, 30}}, color = {0, 0, 127}));
  connect(AVR.efdPu, GEN.ufPuIn) annotation (
    Line(points = {{-51, -10}, {-48.5, -10}, {-48.5, -10}, {-44, -10}, {-44, 2}, {-41, 2}, {-41, 2}, {-36, 2}}, color = {0, 0, 127}));
  connect(GEN.omegaPu, TGOV.omegaPu) annotation (
    Line(points = {{-16, 8}, {-12, 8}, {-12, 48}, {-78, 48}, {-78, 38}, {-72, 38}}, color = {0, 0, 127}));
  connect(TGOV.PMechPu, GEN.PmPu) annotation (
    Line(points = {{-52, 34}, {-44, 34}, {-44, 10}, {-40, 10}, {-40, 10}, {-36, 10}}, color = {0, 0, 127}));
  connect(GEN.terminal, NGEN.terminal) annotation (
    Line(points = {{-26, 6}, {-26, -14}, {14, -14}}));
  annotation (
    Diagram(coordinateSystem(extent = {{-120, -60}, {40, 60}})),
    experiment(StartTime = 0, StopTime = 2, Tolerance = 1e-6, Interval = 0.004),
    __OpenModelica_commandLineOptions = "--daeMode --tearingMethod=minimalTearing",
    __OpenModelica_simulationFlags(nls="kinsol", lv="LOG_INIT_HOMOTOPY", homotopyOnFirstTry="()"),
    Documentation(info="<html>
<p><i><span style=\"font-family: Arial; font-size: 12pt;\">Library PowerGridsMC was forked from https://github.com/PowerGrids/PowerGrids on 22 November 2024.</span></i></p>
<p><i><span style=\"font-size: 12pt;\">The following info is derived from the original version on that source, modified whenever changes introduced in this fork require this.</span></i></p>
<p>************************** </p>
</html>"));
end TestCase2;
