within PowerGridsMC.Examples.Tutorial.GridOperation.Static;
model StaticGrid "System operating in steady-state with given inputs"
  extends Modelica.Icons.Example;
  inner PowerGridsMC.Electrical.System systemPowerGrids annotation (
    Placement(visible = true, transformation(origin = {62, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGridsMC.Electrical.Machines.SynchronousMachine4Windings GEN(H = 4, PStart = -4.75e+08, QStart = -1.56e+08,SNom = 5e+08, Tpd0 = 5.143, Tppd0 = 0.042, Tppq0 = 0.083, Tpq0 = 2.16, UNom = 21000, UPhaseStart = 0.161156, UStart = 21e3 * 0.9917, portVariablesPhases = true, raPu = 0, xdPu = 2, xlPu = 0.15, xpdPu = 0.35, xppdPu = 0.25, xppqPu = 0.3, xpqPu = 0.5, xqPu = 1.8)  annotation (
    Placement(visible = true, transformation(origin={-34,2},     extent={{-10,10},
            {10,-10}},                                                                            rotation = 0)));
  PowerGridsMC.Electrical.Buses.Bus NTLV(SNom = 5e+08, UNom = 21000, portVariablesPhases = true, portVariablesPu = true)  annotation (
    Placement(transformation(origin = {-2, -18}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  PowerGridsMC.Electrical.Buses.Bus NTHV(SNom = 5e+08, UNom = 380000, portVariablesPhases = true, portVariablesPu = true)  annotation (
    Placement(visible = true, transformation(origin={38,-18},    extent = {{-10, 10}, {10, -10}}, rotation = 90)));
  PowerGridsMC.Electrical.Branches.TransformerFixedRatio TGEN( R = 0.15e-2 * 419 ^ 2 / 500, SNom = 5e+08, UNomA = 21000, UNomB = 419000, X = 16e-2 * 419 ^ 2 / 500, portVariablesPhases = true, portVariablesPu = true, rFixed = 419 / 21, showPortData = true)  annotation (
    Placement(visible = true, transformation(origin={18,-18},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGridsMC.Electrical.Buses.EquivalentGrid GRID(R_X = 1 / 10, SNom = 5e+08, SSC = 2.5e+09, UNom = 380000, URef = 1.05 * 380e3, c = 1.1, portVariablesPhases = true, portVariablesPu = true)  annotation (
    Placement(visible = true, transformation(origin={64,-8},     extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGridsMC.Electrical.Loads.LoadZeta GRIDL(
    PRefConst=4.75e+08,
    QRefConst=7.6e+07,
    SNom=5e+08,
    UNom=380000,
    UPhaseStart=0,
    URef=1.05*380e3,
    UStart=399000,
    portVariablesPhases=true,
    portVariablesPu=true) annotation (Placement(visible=true, transformation(
        origin={58,-30},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Blocks.Sources.RealExpression PmPu(y = 0.95)  annotation (
    Placement(visible = true, transformation(origin={-66,-10},  extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression ufPuIn(y = 2.50826)  annotation (
    Placement(visible = true, transformation(origin={-66,18},     extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(PmPu.y, GEN.pmPuIn) annotation (Line(points={{-55,-10},{-52,-10},{-52,
          -1.4},{-44.4,-1.4}},
                        color={0,0,127}));
  connect(ufPuIn.y, GEN.ufPuIn) annotation (
    Line(points={{-55,18},{-52,18},{-52,6},{-44.4,6}}, color = {0, 0, 127}));
  connect(GRIDL.terminal, NTHV.terminal) annotation (
    Line(points={{58,-30},{58,-18},{38,-18}}));
  connect(GEN.terminal, NTLV.terminal) annotation (
    Line(points={{-34,2},{-34,-18},{-2,-18}}));
  connect(NTLV.terminal, TGEN.terminalA) annotation (
    Line(points={{-2,-18},{8,-18}}));
  connect(TGEN.terminalB, NTHV.terminal) annotation (
    Line(points={{28,-18},{38,-18}}));
  connect(NTHV.terminal, GRID.terminal) annotation (
    Line(points={{38,-18},{64,-18},{64,-8}}));
  annotation (
    Icon(coordinateSystem(grid={2,2}, extent={{-100,-100},{100,100}})),
    Diagram(coordinateSystem(grid={2,2},        extent={{-80,-40},{80,40}})),
    experiment(StartTime = 0, StopTime = 2, Tolerance = 1e-6, Interval = 0.004),
    __OpenModelica_commandLineOptions = "--daeMode --tearingMethod=minimalTearing",
    __OpenModelica_simulationFlags(nls="kinsol", lv="LOG_INIT_HOMOTOPY"),
    Documentation(info="<html>
<p><i><span style=\"font-family: Arial; font-size: 12pt;\">Library PowerGridsMC was forked from https://github.com/PowerGrids/PowerGrids on 22 November 2024.</span></i></p>
<p><i><span style=\"font-size: 12pt;\">The following info is derived from the original version on that source, modified whenever changes introduced in this fork require this.</span></i></p>
<p>************************** </p>
</html>"));
end StaticGrid;
