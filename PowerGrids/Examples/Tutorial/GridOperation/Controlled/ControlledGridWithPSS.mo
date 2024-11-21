within PowerGrids.Examples.Tutorial.GridOperation.Controlled;
model ControlledGridWithPSS "System under automatic control including PSS"
  extends Modelica.Icons.Example;
  inner PowerGrids.Electrical.System systemPowerGrids annotation (
    Placement(transformation(origin = {28, 40}, extent = {{-10, -10}, {10, 10}})));
  PowerGrids.Electrical.Machines.SynchronousMachine4Windings GEN(H = 4, PStart = -4.75e+08, QStart = -1.56e+08,SNom = 5e+08, Tpd0 = 5.143, Tppd0 = 0.042, Tppq0 = 0.083, Tpq0 = 2.16, UNom = 21000, UPhaseStart = 0.161156, UStart = 21e3 * 0.9917, portVariablesPhases = true, raPu = 0, xdPu = 2, xlPu = 0.15, xpdPu = 0.35, xppdPu = 0.25, xppqPu = 0.3, xpqPu = 0.5, xqPu = 1.8)  annotation (
    Placement(visible = true, transformation(origin = {-26, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGrids.Electrical.Buses.Bus NTLV(SNom = 5e+08, UNom = 21000, portVariablesPhases = true, portVariablesPu = true)  annotation (
    Placement(transformation(origin = {-6, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  PowerGrids.Electrical.Branches.TransformerFixedRatio TGEN(PStartA = 4.75e+08, PStartB = -4.75e+08, QStartA = 1.56e+08, QStartB = -7.6e+07, R = 0.15e-2 * 419 ^ 2 / 500, SNom = 5e+08, UNomA = 21000, UNomB = 419000, UPhaseStartA = 0.161156, UPhaseStartB = 0, UStartA = 0.9917 * 21e3, UStartB = 0.95227 * 380e3, X = 16e-2 * 419 ^ 2 / 500, portVariablesPhases = true, portVariablesPu = true, rFixed = 419 / 21)  annotation (
    Placement(transformation(origin = {14, -30}, extent = {{-10, -10}, {10, 10}})));
  PowerGrids.Electrical.Buses.EquivalentGrid GRID(R_X = 1 / 10, SNom = 5e+08, SSC = 2.5e+09, UNom = 380000, URef = 1.05 * 380e3, c = 1.1, portVariablesPhases = true, portVariablesPu = true)  annotation (
    Placement(transformation(origin = {60, -20}, extent = {{-10, -10}, {10, 10}})));
  PowerGrids.Electrical.Loads.LoadImpedancePQ GRIDL(PRefConst = 4.75e+08, QRefConst = 7.6e+07, SNom = 5e+08, UNom = 380000, URef = 1.05 * 380e3, portVariablesPhases = true, portVariablesPu = true)  annotation (
    Placement(transformation(origin = {54, -42}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  PowerGrids.Electrical.Controls.TurbineGovernors.IEEE_TGOV1 TGOV(R = 0.05, T1 = 0.5, T2 = 3, T3 = 10, VMax = 1)  annotation (
    Placement(visible = true, transformation(origin = {-62, 28}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  PowerGrids.Electrical.Controls.ExcitationSystems.IEEE_AC4A AVR(Ka = 200, Ta = 0.05, Tb = 10, Tc = 3, VrMax = 4)  annotation (
    Placement(visible = true, transformation(origin = {-62, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression zero annotation (
    Placement(transformation(origin = {-102, -50}, extent = {{-12, -10}, {12, 10}})));
  Modelica.Blocks.Sources.RealExpression VrefPu(y = 1.004552)  annotation (
    Placement(visible = true, transformation(origin = {-102, -33}, extent = {{-12, -11}, {12, 11}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression RefLPu(y = 475 / 500 * 0.05)  annotation (
    Placement(visible = true, transformation(origin = {-98, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGrids.Electrical.Buses.BusFault NTHV(R = 0.05,SNom = 5e+08, UNom = 380000, UPhaseStart = 0, UStart = 1.050 * 380e3,portVariablesPhases = true, portVariablesPu = true, startTime = 2, stopTime = 2.1)  annotation (
    Placement(transformation(origin = {34, -30}, extent = {{-10, 10}, {10, -10}}, rotation = 90)));
  PowerGrids.Electrical.Controls.PowerSystemStabilizers.IEEE_PSS2A PSS(Ks1 = 10, Ks2 = 0.1564, M = 0, N = 0, T1 = 0.25, T2 = 0.03, T3 = 0.15, T4 = 0.015, T7 = 2, T8 = 0.5, T9 = 0.1, Tw1 = 2, Tw2 = 2, Tw3 = 2, Tw4 = 0, VstMax = 0.1, VstMin = -0.1)  annotation (
    Placement(visible = true, transformation(origin = {-98, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(GEN.terminal, NTLV.terminal) annotation (
    Line(points = {{-26, 0}, {-26, -30}, {-6, -30}}));
  connect(NTLV.terminal, TGEN.terminalA) annotation (
    Line(points = {{-6, -30}, {4, -30}}));
  connect(TGEN.terminalB, NTHV.terminal) annotation (
    Line(points = {{24, -30}, {34, -30}}));
  connect(NTHV.terminal, GRID.terminal) annotation (
    Line(points = {{34, -30}, {40, -30}, {40, -20}, {60, -20}, {60, -20}}));
  connect(NTHV.terminal, GRIDL.terminal) annotation (
    Line(points = {{34, -30}, {40, -30}, {40, -42}, {54, -42}, {54, -42}}));
  connect(RefLPu.y, TGOV.RefLPu) annotation (
    Line(points = {{-86, 24}, {-74, 24}, {-74, 24}, {-72, 24}}, color = {0, 0, 127}));
  connect(AVR.VrefPu, VrefPu.y) annotation (
    Line(points = {{-72, -18}, {-80, -18}, {-80, -32}, {-88, -32}, {-88, -32}}, color = {0, 0, 127}));
  connect(AVR.VuelPu, zero.y) annotation (
    Line(points = {{-72, -22}, {-76, -22}, {-76, -50}, {-89, -50}}, color = {0, 0, 127}));
  connect(GEN.ufPuIn, AVR.efdPu) annotation (
    Line(points = {{-36, -4}, {-44, -4}, {-44, -16}, {-50, -16}, {-50, -16}}, color = {0, 0, 127}));
  connect(TGOV.PMechPu, GEN.PmPu) annotation (
    Line(points = {{-52, 28}, {-44, 28}, {-44, 4}, {-36, 4}, {-36, 4}}, color = {0, 0, 127}));
  connect(GEN.VPu, AVR.VcPu) annotation (
    Line(points = {{-16, -6}, {-4, -6}, {-4, 50}, {-122, 50}, {-122, -14}, {-72, -14}}, color = {0, 0, 127}));
  connect(GEN.omegaPu, TGOV.omegaPu) annotation (
    Line(points = {{-16, 2}, {-10, 2}, {-10, 42}, {-80, 42}, {-80, 32}, {-72, 32}}, color = {0, 0, 127}));
  connect(PSS.VstPu, AVR.VsPu) annotation (
    Line(points = {{-86, 0}, {-80, 0}, {-80, -10}, {-72, -10}, {-72, -10}}, color = {0, 0, 127}));
  connect(PSS.Vsi1Pu, GEN.omegaPu) annotation (
    Line(points = {{-108, 6}, {-114, 6}, {-114, 42}, {-10, 42}, {-10, 2}, {-16, 2}}, color = {0, 0, 127}));
  connect(PSS.Vsi2Pu, GEN.PPu) annotation (
    Line(points = {{-108, -6}, {-118, -6}, {-118, 46}, {-6, 46}, {-6, -2}, {-16, -2}}, color = {0, 0, 127}));

annotation (
    Icon(coordinateSystem(grid = {0.1, 0.1})),
    Diagram(coordinateSystem(extent = {{-140, 60}, {80, -60}}, grid = {0.5, 0.5})),
    experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-6, Interval = 0.02),
    __OpenModelica_commandLineOptions = "--daeMode --tearingMethod=minimalTearing",
    __OpenModelica_simulationFlags(nls="kinsol", lv="LOG_INIT_HOMOTOPY"));
end ControlledGridWithPSS;
