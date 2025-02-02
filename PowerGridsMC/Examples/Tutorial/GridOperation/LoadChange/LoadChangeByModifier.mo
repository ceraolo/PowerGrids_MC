within PowerGridsMC.Examples.Tutorial.GridOperation.LoadChange;
model LoadChangeByModifier "Load step response specified by modifiers on a copy of the static system"
  extends Modelica.Icons.Example;
  inner PowerGridsMC.Electrical.System systemPowerGrids(showDataOnDiagramsPu=
        true)                                           annotation (
    Placement(visible = true, transformation(origin={50,30},     extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGridsMC.Electrical.Machines.SynchronousMachine4Windings GEN(H = 4, PStart = -4.75e+08, QStart = -1.56e+08,SNom = 5e+08, Tpd0 = 5.143, Tppd0 = 0.042, Tppq0 = 0.083, Tpq0 = 2.16, UNom = 21000, UPhaseStart = 0.161156, UStart = 21e3 * 0.9917, portVariablesPhases = true, raPu = 0, xdPu = 2, xlPu = 0.15, xpdPu = 0.35, xppdPu = 0.25, xppqPu = 0.3, xpqPu = 0.5, xqPu = 1.8)  annotation (
    Placement(visible = true, transformation(origin={-26,4},    extent={{-10,10},
            {10,-10}},                                                                           rotation = 0)));
  PowerGridsMC.Electrical.Buses.Bus NTLV(SNom = 5e+08, UNom = 21000, portVariablesPhases = true, portVariablesPu = true)  annotation (
    Placement(visible = true, transformation(origin={-6,-16},    extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  PowerGridsMC.Electrical.Buses.Bus NTHV(SNom = 5e+08, UNom = 380000, portVariablesPhases = true, portVariablesPu = true)  annotation (
    Placement(visible = true, transformation(origin={40,-16},    extent = {{-10, 10}, {10, -10}}, rotation = 90)));
  PowerGridsMC.Electrical.Branches.TransformerFixedRatio TGEN(PStartA = 4.75e+08, PStartB = -4.75e+08, QStartA = 1.56e+08, QStartB = -7.6e+07, R = 0.15e-2 * 419 ^ 2 / 500, SNom = 5e+08, UNomA = 21000, UNomB = 419000, UPhaseStartA = 0.161156, UPhaseStartB = 0, UStartA = 0.9917 * 21e3, UStartB = 0.95227 * 380e3, X = 16e-2 * 419 ^ 2 / 500, portVariablesPhases = true, portVariablesPu = true, rFixed = 419 / 21, showPortData = true)  annotation (
    Placement(visible = true, transformation(origin={16,-16},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGridsMC.Electrical.Buses.EquivalentGrid GRID(R_X = 1 / 10, SNom = 5e+08, SSC = 2.5e+09, UNom = 380000, URef = 1.05 * 380e3, c = 1.1, portVariablesPhases = true, portVariablesPu = true)  annotation (
    Placement(visible = true, transformation(origin={68,-6},      extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGridsMC.Electrical.Loads.LoadZeta GRIDL(
    PRef=4.75e+08*(if time < 2 then 1 else 1.05)
      "Active power consumption at reference voltage",
    QRef=7.6e+07*(if time < 2 then 1 else 1.04)
      "Reactive power consumption at reference voltage",
    SNom=5e+08,
    UNom=380000,
    URef=1.05*380e3,
    portVariablesPhases=true,
    portVariablesPu=true) annotation (Placement(visible=true, transformation(
        origin={62,-28},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Blocks.Sources.RealExpression PmPu(y = -GEN.PStart / GEN.SNom)  annotation (
    Placement(visible = true, transformation(origin={-60,-4},   extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression ufPuIn(y = GEN.ufPuInStart)  annotation (
    Placement(visible = true, transformation(origin={-60,10},     extent = {{-10, -10}, {10, 10}}, rotation = 0)));

equation
  connect(PmPu.y, GEN.pmPuIn) annotation (Line(points={{-49,-4},{-42,-4},{-42,
          0.6},{-36.4,0.6}}, color={0,0,127}));
  connect(ufPuIn.y, GEN.ufPuIn) annotation (
    Line(points={{-49,10},{-42,10},{-42,8},{-36.4,8}},                       color = {0, 0, 127}));
  connect(GRIDL.terminal, NTHV.terminal) annotation (
    Line(points={{62,-28},{50,-28},{50,-16},{40,-16}}));
  connect(GEN.terminal, NTLV.terminal) annotation (
    Line(points={{-26,4},{-26,-16},{-6,-16}}));
  connect(NTLV.terminal, TGEN.terminalA) annotation (
    Line(points={{-6,-16},{6,-16}}));
  connect(TGEN.terminalB, NTHV.terminal) annotation (
    Line(points={{26,-16},{40,-16}}));
  connect(NTHV.terminal, GRID.terminal) annotation (
    Line(points={{40,-16},{50,-16},{50,-6},{68,-6}}));

annotation (
    experiment(StartTime = 0, StopTime = 4, Tolerance = 1e-6, Interval = 0.008),
    __OpenModelica_commandLineOptions = "--daeMode --tearingMethod=minimalTearing",
    __OpenModelica_simulationFlags(nls="kinsol", lv="LOG_INIT_HOMOTOPY"),
  Diagram(coordinateSystem(extent={{-80,-60},{80,40}}),                             graphics={  Text(origin={
              -2.2,-48},                                                                                                  extent={{
              -59.8,8},{70.2,-12}},
          textString="To see load change in OpenModelica look at text view",
          lineColor={0,0,0})}),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, grid={2,2})),
    Documentation(info="<html>
<p><i><span style=\"font-family: Arial; font-size: 12pt;\">Library PowerGridsMC was forked from https://github.com/PowerGrids/PowerGrids on 22 November 2024.</span></i></p>
<p><i><span style=\"font-size: 12pt;\">The following info is derived from the original version on that source, modified whenever changes introduced in this fork require this.</span></i></p>
<p>************************** </p>
</html>"));
end LoadChangeByModifier;
