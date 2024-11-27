within PowerGridsMC.Examples.Tutorial.GridOperation.Controlled;
model ControlledGridWithoutPSS "System under automatic control without PSS"
  extends Modelica.Icons.Example;
  inner PowerGridsMC.Electrical.System systemPowerGrids annotation (
    Placement(transformation(origin = {46, 38}, extent = {{-10, -10}, {10, 10}})));
  PowerGridsMC.Electrical.Machines.SynchronousMachine4Windings GEN(H = 4, PStart = -4.75e+08, QStart = -1.56e+08,SNom = 5e+08, Tpd0 = 5.143, Tppd0 = 0.042, Tppq0 = 0.083, Tpq0 = 2.16, UNom = 21000, UPhaseStart = 0.161156, UStart = 21e3 * 0.9917, portVariablesPhases = true, raPu = 0, xdPu = 2, xlPu = 0.15, xpdPu = 0.35, xppdPu = 0.25, xppqPu = 0.3, xpqPu = 0.5, xqPu = 1.8)  annotation (
    Placement(transformation(origin = {-10, 0}, extent = {{-10, -10}, {10, 10}})));
  PowerGridsMC.Electrical.Buses.Bus NTLV(SNom = 5e+08, UNom = 21000, portVariablesPhases = true, portVariablesPu = true)  annotation (
    Placement(transformation(origin = {16, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  PowerGridsMC.Electrical.Branches.TransformerFixedRatio TGEN(PStartA = 4.75e+08, PStartB = -4.75e+08, QStartA = 1.56e+08, QStartB = -7.6e+07, R = 0.15e-2 * 419 ^ 2 / 500, SNom = 5e+08, UNomA = 21000, UNomB = 419000, UPhaseStartA = 0.161156, UPhaseStartB = 0, UStartA = 0.9917 * 21e3, UStartB = 0.95227 * 380e3, X = 16e-2 * 419 ^ 2 / 500, portVariablesPhases = true, portVariablesPu = true, rFixed = 419 / 21)  annotation (
    Placement(transformation(origin = {38, -28}, extent = {{-10, -10}, {10, 10}})));
  PowerGridsMC.Electrical.Buses.EquivalentGrid GRID(R_X = 1 / 10, SNom = 5e+08, SSC = 2.5e+09, UNom = 380000, URef = 1.05 * 380e3, c = 1.1, portVariablesPhases = true, portVariablesPu = true)  annotation (
    Placement(transformation(origin = {86, -18}, extent = {{-10, -10}, {10, 10}})));
  PowerGridsMC.Electrical.Loads.LoadImpedancePQ GRIDL(PRefConst = 4.75e+08, QRefConst = 7.6e+07, SNom = 5e+08, UNom = 380000, URef = 1.05 * 380e3, portVariablesPhases = true, portVariablesPu = true)  annotation (
    Placement(transformation(origin = {80, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  PowerGridsMC.Electrical.Controls.TurbineGovernors.IEEE_TGOV1 TGOV(R = 0.05, T1 = 0.5, T2 = 3, T3 = 10, VMax = 1)  annotation (
    Placement(transformation(origin = {-46, 28}, extent = {{-10, 10}, {10, -10}})));
  PowerGridsMC.Electrical.Controls.ExcitationSystems.IEEE_AC4A AVR(Ka = 200, Ta = 0.05, Tb = 10, Tc = 3, VrMax = 4)  annotation (
    Placement(transformation(origin = {-46, -16}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.RealExpression zero annotation (
    Placement(transformation(origin = {-86, -52}, extent = {{-12, -10}, {12, 10}})));
  Modelica.Blocks.Sources.RealExpression VrefPu(y = 1.004552)  annotation (
    Placement(transformation(origin = {-86, -33}, extent = {{-12, -11}, {12, 11}})));
  Modelica.Blocks.Sources.RealExpression RefLPu(y = 475 / 500 * 0.05)  annotation (
    Placement(transformation(origin = {-82, 24}, extent = {{-10, -10}, {10, 10}})));
  PowerGridsMC.Electrical.Buses.BusFault NTHV(R = 0.05,SNom = 5e+08, UNom = 380000, UPhaseStart = 0, UStart = 1.050 * 380e3,portVariablesPhases = true, portVariablesPu = true, startTime = 2, stopTime = 2.1)  annotation (
    Placement(transformation(origin = {60, -28}, extent = {{-10, 10}, {10, -10}}, rotation = 90)));
equation
  connect(GEN.terminal, NTLV.terminal) annotation (
    Line(points = {{-10, 0}, {-10, -28}, {16, -28}}));
  connect(NTLV.terminal, TGEN.terminalA) annotation (
    Line(points = {{16, -28}, {28, -28}}));
  connect(TGEN.terminalB, NTHV.terminal) annotation (
    Line(points = {{48, -28}, {60, -28}}));
  connect(NTHV.terminal, GRID.terminal) annotation (
    Line(points = {{60, -28}, {66, -28}, {66, -18}, {86, -18}, {86, -18}}));
  connect(NTHV.terminal, GRIDL.terminal) annotation (
    Line(points = {{60, -28}, {66, -28}, {66, -40}, {80, -40}, {80, -40}}));
  connect(RefLPu.y, TGOV.RefLPu) annotation (
    Line(points = {{-71, 24}, {-59, 24}, {-59, 24}, {-57, 24}}, color = {0, 0, 127}));
  connect(AVR.VrefPu, VrefPu.y) annotation (
    Line(points = {{-56, -18}, {-64, -18}, {-64, -32}, {-72, -32}, {-72, -32}}, color = {0, 0, 127}));
  connect(AVR.VsPu, zero.y) annotation (
    Line(points = {{-56, -10}, {-60, -10}, {-60, -52}, {-72, -52}, {-72, -52}}, color = {0, 0, 127}));
  connect(AVR.VuelPu, zero.y) annotation (
    Line(points = {{-56, -22}, {-60, -22}, {-60, -52}, {-72, -52}, {-72, -52}}, color = {0, 0, 127}));
  connect(GEN.ufPuIn, AVR.efdPu) annotation (
    Line(points = {{-20, -4}, {-28, -4}, {-28, -16}, {-34, -16}, {-34, -16}}, color = {0, 0, 127}));
  connect(TGOV.PMechPu, GEN.PmPu) annotation (
    Line(points = {{-36, 28}, {-28, 28}, {-28, 4}, {-20, 4}, {-20, 4}}, color = {0, 0, 127}));
  connect(GEN.VPu, AVR.VcPu) annotation (
    Line(points = {{0, -6}, {16, -6}, {16, 54}, {-110, 54}, {-110, -14}, {-56, -14}}, color = {0, 0, 127}));
  connect(GEN.omegaPu, TGOV.omegaPu) annotation (
    Line(points = {{0, 2}, {6, 2}, {6, 44}, {-64, 44}, {-64, 32}, {-56, 32}, {-56, 32}}, color = {0, 0, 127}));

annotation (
    Icon(coordinateSystem(grid = {0.1, 0.1})),
    Diagram(coordinateSystem(extent = {{-120, -60}, {100, 60}}, grid = {0.5, 0.5})),
    experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-6, Interval = 0.02),
    __OpenModelica_commandLineOptions = "--daeMode --tearingMethod=minimalTearing",
    __OpenModelica_simulationFlags(nls="kinsol", lv="LOG_INIT_HOMOTOPY"));
end ControlledGridWithoutPSS;
