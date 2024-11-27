within PowerGridsMC.Examples.ENTSOE;
model TestCase3 "Test Case 3, Section 5.3, focuses on the dynamic behavior of the model for the synchronous machine with its whole control in response to a short-circuit"
  extends Modelica.Icons.Example;
  inner PowerGridsMC.Electrical.System systemPowerGrids annotation (
    Placement(transformation(origin = {30, 42}, extent = {{-10, -10}, {10, 10}})));
  PowerGridsMC.Electrical.Machines.SynchronousMachine4Windings GEN(H = 4, PStart = -4.75e+08, QStart = -1.56e+08, SNom = 5e+08, Tpd0 = 5.143, Tppd0 = 0.042, Tppq0 = 0.083, Tpq0 = 2.16, UNom = 21000, UPhaseStart = 0.161146, UStart = 21e3 * 0.992, portVariablesPhases = true, raPu = 0, xdPu = 2, xlPu = 0.15, xpdPu = 0.35, xppdPu = 0.25, xppqPu = 0.3, xpqPu = 0.5, xqPu = 1.8)  annotation (
    Placement(visible = true, transformation(origin = {-26, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGridsMC.Electrical.Buses.Bus NTLV(SNom = 5e+08, UNom = 21000, portVariablesPhases = true, portVariablesPu = true)  annotation (
    Placement(transformation(origin = {-2, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  PowerGridsMC.Electrical.Buses.BusFault NTHV(R = 0.05, SNom = 5e+08, UNom = 380000, UStart = 1.050 * 380e3, X = 0, portVariablesPhases = true, portVariablesPu = true, startTime = 0.1, stopTime = 0.2)  annotation (
    Placement(transformation(origin = {38, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  PowerGridsMC.Electrical.Branches.TransformerFixedRatio TGEN(PStartA = 4.75e+08, PStartB = -4.75e+08, QStartA = 1.56e+08, QStartB = -7.6e+07, R = 0.15e-2 * 419 ^ 2 / 500, SNom = 5e+08, UNomA = 21000, UNomB = 419000, UPhaseStartA = 0.161146, UPhaseStartB = 0, UStartA = 0.992 * 21e3, UStartB = 1.050 * 380e3, X = 16e-2 * 419 ^ 2 / 500, portVariablesPhases = true, portVariablesPu = true, rFixed = 419 / 21)  annotation (
    Placement(transformation(origin = {18, -22}, extent = {{-10, -10}, {10, 10}})));
  PowerGridsMC.Electrical.Controls.TurbineGovernors.IEEE_TGOV1 TGOV(R = 0.05, T1 = 0.5, T2 = 3, T3 = 10, VMax = 1)  annotation (
    Placement(visible = true, transformation(origin = {-62, 28}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  PowerGridsMC.Electrical.Controls.ExcitationSystems.IEEE_AC4A AVR(Ka = 200, Ta = 0.05, Tb = 10, Tc = 3, VrMax = 4)  annotation (
    Placement(visible = true, transformation(origin = {-62, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGridsMC.Electrical.Controls.PowerSystemStabilizers.IEEE_PSS2A PSS(Ks1 = 10, Ks2 = 0.1564, M = 0, N = 0, T1 = 0.25, T2 = 0.03, T3 = 0.15, T4 = 0.015, T7 = 2, T8 = 0.5, T9 = 0.1, Tw1 = 2, Tw2 = 2, Tw3 = 2, Tw4 = 0, VstMax = 0.1, VstMin = -0.1)  annotation (
    Placement(visible = true, transformation(origin = {-98, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression zero annotation (
    Placement(visible = true, transformation(origin = {-102, -48}, extent = {{-12, -10}, {12, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression VrefPu(y = 1.004552)  annotation (
    Placement(visible = true, transformation(origin = {-102, -31}, extent = {{-12, -11}, {12, 11}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression RefLPu(y = 475 / 500 * 0.05)  annotation (
    Placement(visible = true, transformation(origin = {-98, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGridsMC.Electrical.Loads.LoadImpedancePQ GRIDL(PRef = 4.75e+08, QRef = 7.6e+07, SNom = 5e+08, UNom = 380000, URef = 1.05 * 380e3, portVariablesPhases = true, portVariablesPu = true)  annotation (
    Placement(transformation(origin = {50, -38}, extent = {{-10, -10}, {10, 10}})));
  Electrical.Buses.EquivalentGrid GRID(R_X = 1 / 10, SNom = 5e+08, SSC = 2.5e+09, UNom = 380000, URef = 1.050 * 380e3, c = 1.1, portVariablesPhases = true, portVariablesPu = true)  annotation (
    Placement(transformation(origin = {66, -22}, extent = {{-10, -10}, {10, 10}})));

  Types.PerUnit AA_01_GEN_Upu = GEN.port.VPu "Fig. 5.7, terminal voltage";
  Types.PerUnit AA_02_GEN_efd = GEN.ufPuIn "Fig. 5.8, excitation voltage";
  Types.PerUnit AA_03_GEN_Ppu = GEN.port.PGenPu/0.95 "Fig. 5.9, active power of the synchronous machine";
  Types.PerUnit AA_04_GEN_Qpu = GEN.port.QGenPu/0.314583 "Fig. 5.10, reactive power of the synchronous machine";
  Types.PerUnit AA_05_GEN_omegapu = GEN.omegaPu "Fig. 5.11, speed";
  Types.PerUnit AA_06_PSS_out = PSS.VstPu "Fig. 5.12, PSS output signal";
  Types.PerUnit AA_07_GRIDL_Ppu = GRIDL.port.PPu/0.95 "Fig. 5.13, active power of the load";
  Types.PerUnit AA_08_GRIDL_Qpu = GRIDL.port.QPu/0.1519 "Fig. 5.14, reactive power of the load";

equation
  connect(GRID.terminal, NTHV.terminal) annotation (
    Line(points={{66,-22},{38,-22}}));
  connect(VrefPu.y, AVR.VrefPu) annotation (
    Line(points={{-88.8,-31},{-89.3,-31},{-89.3,-31},{-85.8,-31},{-85.8,-18},{
          -79.8,-18},{-79.8,-18},{-72,-18}},                                                                                        color = {0, 0, 127}));
  connect(TGEN.terminalB, NTHV.terminal) annotation (
    Line(points = {{28, -22}, {38, -22}}));
  connect(NTHV.terminal, GRIDL.terminal) annotation (
    Line(points = {{38, -22}, {50, -22}, {50, -38}}));
  connect(GEN.PPu, PSS.Vsi2Pu) annotation (
    Line(points={{-16,-2},{-4,-2},{-4,50},{-120,50},{-120,-6},{-108.2,-6}},            color = {0, 0, 127}));
  connect(GEN.VPu, AVR.VcPu) annotation (
    Line(points = {{-16, -6}, {0, -6}, {0, 54}, {-124, 54}, {-124, -14}, {-72, -14}}, color = {0, 0, 127}));
  connect(RefLPu.y, TGOV.RefLPu) annotation (
    Line(points = {{-87, 24}, {-72, 24}}, color = {0, 0, 127}));
  connect(zero.y, AVR.VuelPu) annotation (
    Line(points={{-88.8,-48},{-79.8,-48},{-79.8,-22},{-72,-22}},            color = {0, 0, 127}));
  connect(GEN.omegaPu, PSS.Vsi1Pu) annotation (
    Line(points = {{-16, 2}, {-8, 2}, {-8, 44}, {-116, 44}, {-116, 6}, {-108, 6}}, color = {0, 0, 127}));
  connect(PSS.VstPu, AVR.VsPu) annotation (
    Line(points = {{-87, 0}, {-76.5, 0}, {-76.5, -10}, {-72, -10}}, color = {0, 0, 127}));
  connect(AVR.efdPu, GEN.ufPuIn) annotation (
    Line(points = {{-51, -16}, {-48.5, -16}, {-48.5, -16}, {-44, -16}, {-44, -4}, {-41, -4}, {-41, -4}, {-36, -4}}, color = {0, 0, 127}));
  connect(GEN.omegaPu, TGOV.omegaPu) annotation (
    Line(points = {{-16, 2}, {-8, 2}, {-8, 44}, {-80, 44}, {-80, 32}, {-72, 32}}, color = {0, 0, 127}));
  connect(TGOV.PMechPu, GEN.PmPu) annotation (
    Line(points = {{-52, 28}, {-44, 28}, {-44, 4}, {-40, 4}, {-40, 4}, {-36, 4}}, color = {0, 0, 127}));
  connect(NTLV.terminal, TGEN.terminalA) annotation (
    Line(points = {{-2, -22}, {8, -22}}));
  connect(GEN.terminal, NTLV.terminal) annotation (
    Line(points = {{-26, 0}, {-26, -22}, {-2, -22}}));
  annotation (
    Diagram(coordinateSystem(extent = {{-140, 60}, {80, -60}})),
    experiment(StartTime = 0, StopTime = 2, Tolerance = 1e-6, Interval = 0.004),
    __OpenModelica_commandLineOptions = "--daeMode --tearingMethod=minimalTearing",
    __OpenModelica_simulationFlags(nls="kinsol", lv="LOG_INIT_HOMOTOPY", homotopyOnFirstTry="()"),
    Documentation(info="<html>
<p></span><i><span style=\"font-size: 12pt;\">Library PowerGridsMC is forked from https://github.com/PowerGrids/PowerGrids.</i></p>
<p></span><i><span style=\"font-size: 12pt;\">The following info is derived from the original version on that source, modified whenever changes introduced in this fork require this.</i></p>
**************************
</html>"));
end TestCase3;
