within PowerGrids.Examples.Tutorial.GridOperation.Controlled;

model ControlledGridWithReferenceCalculation "System under automatic control with automatic computation of set point offsets"
  extends Modelica.Icons.Example;
  inner PowerGrids.Electrical.System systemPowerGrids(initOpt = PowerGrids.Types.Choices.InitializationOption.globalSteadyStateFixedPowerFlow) annotation(
    Placement(transformation(origin = {48, 40}, extent = {{-10, -10}, {10, 10}})));
  PowerGrids.Electrical.Machines.SynchronousMachine4Windings GEN(H = 4, PStart = -4.75e+08, QStart = -1.56e+08, SNom = 5e+08, Tpd0 = 5.143, Tppd0 = 0.042, Tppq0 = 0.083, Tpq0 = 2.16, UNom = 21000, UPhaseStart = 0.161156, UStart = 21e3*0.9917, portVariablesPhases = true, raPu = 0, xdPu = 2, xlPu = 0.15, xpdPu = 0.35, xppdPu = 0.25, xppqPu = 0.3, xpqPu = 0.5, xqPu = 1.8) annotation(
    Placement(transformation(extent = {{-10, -10}, {10, 10}})));
  PowerGrids.Electrical.Buses.Bus NTLV(SNom = 5e+08, UNom = 21000, portVariablesPhases = true, portVariablesPu = true) annotation(
    Placement(transformation(origin = {20, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  PowerGrids.Electrical.Branches.TransformerFixedRatio TGEN(PStartA = 4.75e+08, PStartB = -4.75e+08, QStartA = 1.56e+08, QStartB = -7.6e+07, R = 0.15e-2*419^2/500, SNom = 5e+08, UNomA = 21000, UNomB = 419000, UPhaseStartA = 0.161156, UPhaseStartB = 0, UStartA = 0.9917*21e3, UStartB = 0.95227*380e3, X = 16e-2*419^2/500, portVariablesPhases = true, portVariablesPu = true, rFixed = 419/21) annotation(
    Placement(transformation(origin = {40, -30}, extent = {{-10, -10}, {10, 10}})));
  PowerGrids.Electrical.Buses.EquivalentGrid GRID(R_X = 1/10, SNom = 5e+08, SSC = 2.5e+09, UNom = 380000, URef = 1.05*380e3, c = 1.1, portVariablesPhases = true, portVariablesPu = true) annotation(
    Placement(transformation(origin = {86, -20}, extent = {{-10, -10}, {10, 10}})));
  PowerGrids.Electrical.Loads.LoadImpedancePQ GRIDL(PRefConst = 4.75e+08, QRefConst = 7.6e+07, SNom = 5e+08, UNom = 380000, URef = 1.05*380e3, portVariablesPhases = true, portVariablesPu = true) annotation(
    Placement(transformation(origin = {80, -42}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  PowerGrids.Electrical.Controls.TurbineGovernors.IEEE_TGOV1 TGOV(PMechPuStart = -GEN.PStart/GEN.SNom, R = 0.05, T1 = 0.5, T2 = 3, T3 = 10, VMax = 1) annotation(
    Placement(transformation(origin = {-36, 28}, extent = {{-10, 10}, {10, -10}})));
  PowerGrids.Electrical.Controls.ExcitationSystems.IEEE_AC4A AVR(Ka = 200, Ta = 0.05, Tb = 10, Tc = 3, VcPuStart = GEN.UStart/GEN.UNom, VrMax = 4) annotation(
    Placement(transformation(origin = {-36, -16}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.RealExpression zero annotation(
    Placement(transformation(origin = {-74, -52}, extent = {{-12, -10}, {12, 10}})));
  PowerGrids.Electrical.Buses.Bus NTHV(SNom = 5e+08, UNom = 380000, portVariablesPhases = true, portVariablesPu = true) annotation(
    Placement(transformation(origin = {60, -30}, extent = {{-10, 10}, {10, -10}}, rotation = 90)));
  PowerGrids.Electrical.Controls.PowerSystemStabilizers.IEEE_PSS2A PSS(Ks1 = 10, Ks2 = 0.1564, M = 0, N = 0, T1 = 0.25, T2 = 0.03, T3 = 0.15, T4 = 0.015, T7 = 2, T8 = 0.5, T9 = 0.1, Tw1 = 2, Tw2 = 2, Tw3 = 2, Tw4 = 0, VstMax = 0.1, VstMin = -0.1) annotation(
    Placement(transformation(origin = {-72, 0}, extent = {{-10, -10}, {10, 10}})));
  PowerGrids.Controls.FreeOffset RefLPu annotation(
    Placement(transformation(origin = {-72, 24}, extent = {{-10, -10}, {10, 10}})));
  PowerGrids.Controls.FreeOffset VrefPu(use_u = true) annotation(
    Placement(transformation(origin = {-72, -30}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.RealExpression deltaVrefPu(y = if time >= 2 then 3e3*sin(2*Modelica.Constants.pi*0.05*(time - 2))/GEN.UNom else 0) annotation(
    Placement(transformation(origin = {-104, -30}, extent = {{-12, -10}, {12, 10}})));
  Real VrefPuTot = deltaVrefPu.y + GEN.VStartPu;
equation
  connect(GEN.terminal, NTLV.terminal) annotation(
    Line(points = {{0, 0}, {0, -30}, {20, -30}}));
  connect(NTLV.terminal, TGEN.terminalA) annotation(
    Line(points = {{20, -30}, {30, -30}}));
  connect(TGEN.terminalB, NTHV.terminal) annotation(
    Line(points = {{50, -30}, {60, -30}}));
  connect(NTHV.terminal, GRID.terminal) annotation(
    Line(points = {{60, -30}, {66, -30}, {66, -20}, {86, -20}, {86, -20}}));
  connect(NTHV.terminal, GRIDL.terminal) annotation(
    Line(points = {{60, -30}, {66, -30}, {66, -42}, {80, -42}, {80, -42}}));
  connect(AVR.VuelPu, zero.y) annotation(
    Line(points = {{-46, -22}, {-50, -22}, {-50, -52}, {-61, -52}}, color = {0, 0, 127}));
  connect(GEN.ufPuIn, AVR.efdPu) annotation(
    Line(points = {{-10, -4}, {-18, -4}, {-18, -16}, {-24, -16}, {-24, -16}}, color = {0, 0, 127}));
  connect(TGOV.PMechPu, GEN.PmPu) annotation(
    Line(points = {{-26, 28}, {-18, 28}, {-18, 4}, {-10, 4}, {-10, 4}}, color = {0, 0, 127}));
  connect(GEN.VPu, AVR.VcPu) annotation(
    Line(points = {{10, -6}, {26, -6}, {26, 54}, {-104, 54}, {-104, -14}, {-46, -14}}, color = {0, 0, 127}));
  connect(GEN.omegaPu, TGOV.omegaPu) annotation(
    Line(points = {{10, 2}, {16, 2}, {16, 44}, {-54, 44}, {-54, 32}, {-46, 32}, {-46, 32}}, color = {0, 0, 127}));
  connect(PSS.VstPu, AVR.VsPu) annotation(
    Line(points = {{-61, 0}, {-55, 0}, {-55, -10}, {-47, -10}, {-47, -10}}, color = {0, 0, 127}));
  connect(PSS.Vsi1Pu, GEN.omegaPu) annotation(
    Line(points = {{-82, 6}, {-94, 6}, {-94, 44}, {16, 44}, {16, 2}, {10, 2}}, color = {0, 0, 127}));
  connect(PSS.Vsi2Pu, GEN.PPu) annotation(
    Line(points = {{-82.2, -6}, {-98.2, -6}, {-98.2, 48}, {19.8, 48}, {19.8, -2}, {9.8, -2}}, color = {0, 0, 127}));
  connect(VrefPu.y, AVR.VrefPu) annotation(
    Line(points = {{-61, -30}, {-55, -30}, {-55, -18}, {-47, -18}}, color = {0, 0, 127}));
  connect(RefLPu.y, TGOV.RefLPu) annotation(
    Line(points = {{-61, 24}, {-49, 24}, {-49, 24}, {-47, 24}}, color = {0, 0, 127}));
  connect(deltaVrefPu.y, VrefPu.u) annotation(
    Line(points = {{-90.8, -30}, {-81.8, -30}}, color = {0, 0, 127}));
  annotation(
    Icon(coordinateSystem(grid = {0.1, 0.1})),
    Diagram(coordinateSystem(extent = {{-120, -60}, {100, 60}}, grid = {0.5, 0.5})),
    experiment(StartTime = 0, StopTime = 30, Tolerance = 1e-6, Interval = 0.02),
    __OpenModelica_commandLineOptions = "--daeMode --tearingMethod=minimalTearing",
    __OpenModelica_simulationFlags(nls = "kinsol", lv = "LOG_INIT_HOMOTOPY"));
end ControlledGridWithReferenceCalculation;
