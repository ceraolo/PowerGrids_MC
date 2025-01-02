within PowerGridsMC.Examples.Tutorial.IslandOperation;
model TwoGeneratorsOneReferenceGenerator
  extends Modelica.Icons.Example;
  inner PowerGridsMC.Electrical.System systemPowerGrids(initOpt = PowerGridsMC.Types.Choices.InitializationOption.globalSteadyStateFixedPowerFlow, referenceFrequency = PowerGridsMC.Types.Choices.ReferenceFrequency.fixedReferenceGenerator) annotation (
    Placement(transformation(origin = {110, 8}, extent = {{-10, -10}, {10, 10}})));
  PowerGridsMC.Electrical.Buses.Bus NTLV1(SNom = 5e+08, UNom = 21000, portVariablesPhases = true, portVariablesPu = true) annotation (
    Placement(transformation(origin = {-62, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  PowerGridsMC.Electrical.Buses.ReferenceBus NTHV1(SNom = 5e+08, UNom = 380000, portVariablesPhases = true, portVariablesPu = true) annotation (
    Placement(visible = true, transformation(origin = {-20, 20}, extent = {{-10, 10}, {10, -10}}, rotation = 90)));
  PowerGridsMC.Electrical.Branches.TransformerFixedRatio TGEN1(R = 0.15e-2 * 419 ^ 2 / 500, SNom = 5e+08, UNomA = 21000, UNomB = 419000, X = 16e-2 * 419 ^ 2 / 500, portVariablesPhases = true, portVariablesPu = true, rFixed = 419 / 21) annotation (
    Placement(transformation(origin = {-40, 20}, extent = {{-10, -10}, {10, 10}})));
  PowerGridsMC.Electrical.Branches.TransformerFixedRatio TGEN2( R = 0.15e-2 * 419 ^ 2 / 500, SNom = 5e+08, UNomA = 21000, UNomB = 419000, X = 16e-2 * 419 ^ 2 / 500, portVariablesPhases = true, portVariablesPu = true, rFixed = 419 / 21) annotation (
    Placement(transformation(origin = {60, 20}, extent = {{10, -10}, {-10, 10}})));
  PowerGridsMC.Examples.Tutorial.GridOperation.Controlled.ControlledGenPSS GEN1(
     GEN(
      UNom=21e3,
      SNom=500e6,
      UStart=20.825e3,
      UPhaseStart=9.1746/180*3.14159,
      PStart=-450.88e6,
      QStart=-294.351e6), TGOV(R=0.05)) annotation (Placement(transformation(
          origin={-86,6}, extent={{-10,-10},{10,10}})));
  PowerGridsMC.Electrical.Branches.LineConstantImpedance LINE( R = 10, SNom = 5e+8, UNom = 380000, UPhaseStartA = 0, X = 100, portVariablesPhases = true, portVariablesPu = true) annotation (
    Placement(visible = true, transformation(origin = {10, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGridsMC.Examples.Tutorial.GridOperation.Controlled.ControlledGenPSS GEN2(
     GEN(
      UNom=21e3,
      SNom=500e6,
      UStart=20.825e3,
      UPhaseStart=9.1746/180*3.14159,
      PStart=-450.88e6,
      QStart=-294.351e6), TGOV(R=0.05)) annotation (Placement(transformation(
          origin={82,8}, extent={{-10,-10},{10,10}})));
  PowerGridsMC.Electrical.Buses.Bus NTHV2(SNom = 5e+08, UNom = 380000, portVariablesPhases = true, portVariablesPu = true) annotation (
    Placement(visible = true, transformation(origin = {40, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  PowerGridsMC.Electrical.Loads.LoadAlphaBeta GRIDL1(
    PRef=450e6 + (if time < 1 then 0 else -100e6),
    PRefConst=4.5e+08,
    QRefConst=200e6,
    SNom=500e6,
    UNom=380000,
    portVariablesPhases=true) annotation (Placement(transformation(origin={-10,
            -2}, extent={{-10,-10},{10,10}})));
  PowerGridsMC.Electrical.Loads.LoadAlphaBeta GRIDL2(
    PRefConst=4.5e+08,
    QRefConst=200e6,
    SNom=500e6,
    UNom=380000,
    portVariablesPhases=true) annotation (Placement(transformation(origin={30,-2},
          extent={{-10,-10},{10,10}})));
equation
  connect(NTLV1.terminal, TGEN1.terminalA) annotation (
    Line(points = {{-62, 20}, {-50, 20}}));
  connect(TGEN1.terminalB, NTHV1.terminal) annotation (
    Line(points = {{-30, 20}, {-20, 20}}));
  connect(NTHV1.terminal, GRIDL1.terminal) annotation (
    Line(points = {{-20, 20}, {-10, 20}, {-10, -2}}));
  connect(GEN1.terminal, NTLV1.terminal) annotation (
    Line(points = {{-86, 6}, {-86, 20}, {-62, 20}}));
  connect(LINE.terminalA, NTHV1.terminal) annotation (
    Line(points = {{0, 20}, {-20, 20}}));
  connect(LINE.terminalB, NTHV2.terminal) annotation (
    Line(points = {{20, 20}, {40, 20}}));
  connect(NTHV2.terminal, GRIDL2.terminal) annotation (
    Line(points = {{40, 20}, {30, 20}, {30, -2}}));
  connect(NTHV2.terminal, TGEN2.terminalB) annotation (
    Line(points = {{40, 20}, {50, 20}}));
  connect(TGEN2.terminalA, GEN2.terminal) annotation (
    Line(points = {{70, 20}, {82, 20}, {82, 8}}));
  connect(GEN2.omega, systemPowerGrids.omegaRefIn) annotation (
    Line(points={{89,8},{94,8},{94,8.2},{100.2,8.2}},
                                       color = {0, 0, 127}));
annotation (
    experiment(StartTime = 0, StopTime = 100, Tolerance = 1e-6, Interval = 0.01),
    __OpenModelica_commandLineOptions = "--tearingMethod=minimalTearing",
    __OpenModelica_simulationFlags(nls="kinsol", lv="LOG_INIT_HOMOTOPY"),
    Diagram(coordinateSystem(extent = {{-100, 40}, {120, -20}})),
    Documentation(info="<html>
<p><i><span style=\"font-family: Arial; font-size: 12pt;\">Library PowerGridsMC was forked from https://github.com/PowerGrids/PowerGrids on 22 November 2024.</span></i></p>
<p><i><span style=\"font-size: 12pt;\">The following info is derived from the original version on that source, modified whenever changes introduced in this fork require this.</span></i></p>
<p>************************** </p>
</html>"));
end TwoGeneratorsOneReferenceGenerator;
