within PowerGridsMC.Examples.ENTSOE;
model SteadyState "Reproduces the basic static power flow, see fig. 3-1 of the report"
  extends Modelica.Icons.Example;
  PowerGridsMC.Electrical.Machines.SynchronousMachine4Windings GEN(H = 4, PStart = -4.75e+08, QStart = -1.56e+08, SNom = 5e+08, Tpd0 = 5.143, Tppd0 = 0.042, Tppq0 = 0.083, Tpq0 = 2.16, UNom = 21000, UPhaseStart = 0.161146, UStart = 21e3*0.992, portVariablesPhases = true, raPu = 0, xdPu = 2, xlPu = 0.15, xpdPu = 0.35, xppdPu = 0.25, xppqPu = 0.3, xpqPu = 0.5, xqPu = 1.8) annotation (
    Placement(transformation(origin = {-20, 0}, extent={{-10,-10},{10,10}})));
  PowerGridsMC.Electrical.Buses.Bus NTLV(SNom = 5e+08, UNom = 21000, portVariablesPhases = true, portVariablesPu = true) annotation (
    Placement(transformation(origin={8,22},      extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  PowerGridsMC.Electrical.Buses.Bus NTHV(SNom = 5e+08, UNom = 380000, UPhaseStart = 0, UStart = 1.050*380e3, portVariablesPhases = true, portVariablesPu = true) annotation (
    Placement(transformation(origin={50,22},     extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  PowerGridsMC.Electrical.Branches.TransformerFixedRatio TGEN(PStartA = 4.75e+08, PStartB = -4.75e+08, QStartA = 1.56e+08, QStartB = -7.6e+07, R = 0.15e-2*419^2/500, SNom = 5e+08, UNomA = 21000, UNomB = 419000, UPhaseStartA = 0.161146, UPhaseStartB = 0, UStartA = 0.992*21e3, UStartB = 1.050*380e3, X = 16e-2*419^2/500, portVariablesPhases = true, portVariablesPu = true, rFixed = 419/21) annotation (
    Placement(transformation(origin={28,22},     extent = {{-10, -10}, {10, 10}})));
  PowerGridsMC.Electrical.Controls.TurbineGovernors.IEEE_TGOV1 TGOV(R = 0.05, T1 = 0.5, T2 = 3, T3 = 10, VMax = 1) annotation (
    Placement(transformation(origin = {-56, 28}, extent = {{-10, 10}, {10, -10}})));
  PowerGridsMC.Electrical.Controls.ExcitationSystems.IEEE_AC4A AVR(Ka = 200, Ta = 0.05, Tb = 10, Tc = 3, VrMax = 4) annotation (
    Placement(transformation(origin = {-56, -16}, extent = {{-10, -10}, {10, 10}})));
  PowerGridsMC.Electrical.Controls.PowerSystemStabilizers.IEEE_PSS2A PSS(Ks1 = 10, Ks2 = 0.1564, M = 0, N = 0, T1 = 0.25, T2 = 0.03, T3 = 0.15, T4 = 0.015, T7 = 2, T8 = 0.5, T9 = 0.1, Tw1 = 2, Tw2 = 2, Tw3 = 2, Tw4 = 0, VstMax = 0.1, VstMin = -0.1) annotation (
    Placement(transformation(origin={-90,0},    extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.RealExpression zero annotation (
    Placement(transformation(origin={-96,-46},    extent = {{-12, -10}, {12, 10}})));
  Modelica.Blocks.Sources.RealExpression VrefPu(y = 1.004552) annotation (
    Placement(transformation(origin={-96,-29},    extent = {{-12, -11}, {12, 11}})));
  Modelica.Blocks.Sources.RealExpression RefLPu(y = 475/500*0.05) annotation (
    Placement(transformation(origin={-90,24},    extent = {{-10, -10}, {10, 10}})));
  PowerGridsMC.Electrical.Loads.LoadZeta GRIDL(
    PRefConst=4.75e+08,
    PStart(displayUnit="W"),
    QRefConst=7.6e+07,
    SNom=5e+08,
    UNom=380000,
    URef(displayUnit="V") = 1.05*380e3,
    UStart(displayUnit="V"),
    portVariablesPhases=true,
    portVariablesPu=true) annotation (Placement(transformation(origin={60,6},
          extent={{-10,-10},{10,10}})));
  Types.PerUnit AA_01_NGEN_U = GEN.VPu;
  Types.PerUnit AA_02_NGRID_U = GRID.port.VPu;
  Types.Angle AA_03_NGRID_delta = GRID.port.UPhase;
  Types.Angle AA_04_NGEN_delta = GEN.port.UPhase;
  Types.ActivePower AA_05_PG = -GEN.port.S.re;
  Types.ReactivePower AA_06_QG = -GEN.port.S.im;
  Types.ActivePower AA_07_PGRID = -GRID.port.P;
  Types.ReactivePower AA_08_QGRID = -GRID.port.Q;
  Types.ActivePower AA_09_PGRIDL = GRIDL.port.P;
  Types.ReactivePower AA_10_QGRIDL = GRIDL.port.Q;
  Electrical.Buses.EquivalentGrid GRID(R_X = 1/10, SNom = 5e+08, SSC = 2.5e+09, UNom = 380000, URef = 1.05*380e3, c = 1.1, portVariablesPhases = true, portVariablesPu = true) annotation (
    Placement(transformation(origin={76,22},     extent = {{-10, -10}, {10, 10}})));
equation
  connect(VrefPu.y, AVR.VrefPu) annotation (
    Line(points={{-82.8,-29},{-83.3,-29},{-83.3,-31},{-79.8,-31},{-79.8,-18},{
          -66,-18}},                                                                                                                color = {0, 0, 127}));
  connect(GRID.terminal, NTHV.terminal) annotation (
    Line(points={{76,22},{50,22}}));
  connect(TGEN.terminalB, NTHV.terminal) annotation (
    Line(points={{38,22},{50,22}}));
  connect(NTHV.terminal, GRIDL.terminal) annotation (
    Line(points={{50,22},{60,22},{60,6}}));
  connect(GEN.PPu, PSS.Vsi2Pu) annotation (
    Line(points={{-9.8,-2},{-4,-2},{-4,46},{-108,46},{-108,-6},{-100.2,-6}},         color = {0, 0, 127}));
  connect(GEN.VPu, AVR.VcPu) annotation (
    Line(points={{-9.8,-6},{-2,-6},{-2,50},{-110,50},{-110,-14},{-66,-14}},           color = {0, 0, 127}));
  connect(RefLPu.y, TGOV.RefLPu) annotation (
    Line(points={{-79,24},{-66,24}},      color = {0, 0, 127}));
  connect(zero.y, AVR.VuelPu) annotation (
    Line(points={{-82.8,-46},{-73.8,-46},{-73.8,-22},{-66,-22}},            color = {0, 0, 127}));
  connect(GEN.omegaPu, PSS.Vsi1Pu) annotation (
    Line(points={{-9.8,2},{-6,2},{-6,42},{-106,42},{-106,6},{-100,6}},             color = {0, 0, 127}));
  connect(PSS.VstPu, AVR.VsPu) annotation (
    Line(points={{-79,0},{-70.5,0},{-70.5,-10},{-66,-10}},          color = {0, 0, 127}));
  connect(AVR.efdPu, GEN.ufPuIn) annotation (
    Line(points={{-45,-16},{-42.5,-16},{-42.5,-16},{-38,-16},{-38,-4},{-35,-4},
          {-35,-4},{-30.4,-4}},                                                                                     color = {0, 0, 127}));
  connect(GEN.omegaPu, TGOV.omegaPu) annotation (
    Line(points={{-9.8,2},{-6,2},{-6,42},{-74,42},{-74,32},{-66,32}},             color = {0, 0, 127}));
  connect(TGOV.PMechPu, GEN.pmPuIn) annotation (Line(points={{-46,28},{-38,28},
          {-38,4},{-34,4},{-34,3.4},{-30.4,3.4}}, color={0,0,127}));
  connect(NTLV.terminal, TGEN.terminalA) annotation (
    Line(points={{8,22},{18,22}}));
  connect(GEN.terminal, NTLV.terminal) annotation (
    Line(points={{-20,0},{-20,22},{8,22}}));
  annotation (
    Diagram(coordinateSystem(extent={{-120,-60},{100,60}})),
    experiment(StartTime = 0, StopTime = 2, Tolerance = 1e-6, Interval = 0.004),
    __OpenModelica_commandLineOptions = "--daeMode --tearingMethod=minimalTearing",
    __OpenModelica_simulationFlags(nls = "kinsol", lv = "LOG_INIT_HOMOTOPY", homotopyOnFirstTry = "()"),
    Documentation(info="<html>
<p><i><span style=\"font-family: Arial; font-size: 12pt;\">Library PowerGridsMC was forked from https://github.com/PowerGrids/PowerGrids on 22 November 2024.</span></i></p>
<p><i><span style=\"font-size: 12pt;\">The following info is derived from the original version on that source, modified whenever changes introduced in this fork require this.</span></i></p>
<p>************************** </p>
</html>"));
end SteadyState;
