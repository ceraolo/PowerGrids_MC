within PowerGridsMC.Examples.Tutorial.IslandOperation;
model PowerFlow
  extends Modelica.Icons.Example;
  PowerGridsMC.Electrical.PowerFlow.PVBus GEN1(P = -4.5088e+08, SNom = 5e+08, U = 20825, UNom = 21000) annotation (
    Placement(transformation(origin = {-86, 0}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  PowerGridsMC.Electrical.PowerFlow.PVBus GEN2(P = -4.5088e+08, SNom = 5e+08, U = 20825, UNom = 21000) annotation (
    Placement(transformation(origin = {86, 0}, extent = {{-10, -10}, {10, 10}})));
  PowerGridsMC.Electrical.Loads.LoadPQVoltageDependence GRIDL1(PRefConst = 4.5e+08, QRefConst = 200e6, SNom = 5e+08, UNom = 380000, portVariablesPhases = true) annotation (
    Placement(transformation(origin = {-10, -22}, extent = {{-10, -10}, {10, 10}})));
  PowerGridsMC.Electrical.Loads.LoadImpedancePQ GRIDL2(PRefConst = 4.5e+08, QRefConst = 200e6, SNom = 5e+08, UNom = 380000, portVariablesPhases = true) annotation (
    Placement(transformation(origin = {30, -22}, extent = {{-10, -10}, {10, 10}})));
  PowerGridsMC.Electrical.Buses.Bus NTLV1(SNom = 5e+08, UNom = 21000, portVariablesPhases = true, portVariablesPu = true) annotation (
    Placement(transformation(origin = {-68, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  PowerGridsMC.Electrical.Branches.TransformerFixedRatio TGEN1(R = 0.15e-2 * 419 ^ 2 / 500, SNom = 5e+08, UNomA = 21000, UNomB = 419000, X = 16e-2 * 419 ^ 2 / 500, portVariablesPhases = true, portVariablesPu = true, rFixed = 419 / 21, showPFdata = true) annotation (
    Placement(transformation(origin = {-44, 0}, extent = {{-10, -10}, {10, 10}})));
  PowerGridsMC.Electrical.PowerFlow.SlackBus NTHV1(SNom = 5e+08, UNom = 380000, portVariablesPhases = true, portVariablesPu = true) annotation (
    Placement(visible = true, transformation(origin = {-20, 0}, extent = {{-10, 10}, {10, -10}}, rotation = 90)));
  PowerGridsMC.Electrical.Branches.LineConstantImpedance LINE(R = 10, SNom = 5e+8, UNom = 380000, X = 100, portVariablesPhases = true, portVariablesPu = true, showPFdata = true) annotation (
    Placement(visible = true, transformation(origin = {10, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGridsMC.Electrical.Buses.Bus NTHV2(SNom = 5e+08, UNom = 380000, portVariablesPhases = true, portVariablesPu = true) annotation (
    Placement(transformation(origin = {40, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  PowerGridsMC.Electrical.Branches.TransformerFixedRatio TGEN2(R = 0.15e-2 * 419 ^ 2 / 500, SNom = 5e+08, UNomA = 21000, UNomB = 419000, X = 16e-2 * 419 ^ 2 / 500, portVariablesPhases = true, portVariablesPu = true, rFixed = 419 / 21, showPFdata = true) annotation (
    Placement(transformation(origin = {58, 0}, extent = {{10, -10}, {-10, 10}})));
  inner Electrical.System systemPowerGrids annotation (
    Placement(transformation(origin = {52, 30}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(NTLV1.terminal, TGEN1.terminalA) annotation (
    Line(points = {{-68, 0}, {-54, 0}}));
  connect(TGEN1.terminalB, NTHV1.terminal) annotation (
    Line(points = {{-34, 0}, {-20, 0}}));
  connect(NTHV1.terminal, GRIDL1.terminal) annotation (
    Line(points = {{-20, 0}, {-10, 0}, {-10, -22}}));
  connect(GEN1.terminal, NTLV1.terminal) annotation (
    Line(points = {{-86, 0}, {-68, 0}}));
  connect(LINE.terminalA, NTHV1.terminal) annotation (
    Line(points = {{0, 0}, {-20, 0}}));
  connect(LINE.terminalB, NTHV2.terminal) annotation (
    Line(points = {{20, 0}, {40, 0}}));
  connect(NTHV2.terminal, GRIDL2.terminal) annotation (
    Line(points = {{40, 0}, {30, 0}, {30, -22}}));
  connect(NTHV2.terminal, TGEN2.terminalB) annotation (
    Line(points = {{40, 0}, {48, 0}}));
  connect(TGEN2.terminalA, GEN2.terminal) annotation (
    Line(points = {{68, 0}, {86, 0}}));
  annotation (
    Icon(coordinateSystem(grid = {0.1, 0.1})),
    Diagram(coordinateSystem(extent = {{-100, -40}, {100, 40}}, grid = {0.5, 0.5})),
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002),
    __OpenModelica_simulationFlags(lv = "LOG_STATS", outputFormat = "mat", s = "dassl"),
    Documentation(info="<html>
<p><i><span style=\"font-family: Arial; font-size: 12pt;\">Library PowerGridsMC was forked from https://github.com/PowerGrids/PowerGrids on 22 November 2024.</span></i></p>
<p><i><span style=\"font-size: 12pt;\">The following info is derived from the original version on that source, modified whenever changes introduced in this fork require this.</span></i></p>
<p>************************** </p>
</html>"));
end PowerFlow;
