within PowerGridsMC.Examples.Tutorial.GridOperation.Controlled;
model ControlledGridWithControlledGen "System under automatic control with high-level controlled generator component"
  extends Modelica.Icons.Example;
  inner PowerGridsMC.Electrical.System systemPowerGrids(initOpt = PowerGridsMC.Types.Choices.InitializationOption.globalSteadyStateFixedPowerFlow)  annotation (
    Placement(transformation(origin = {50, 38}, extent = {{-10, -10}, {10, 10}})));
  PowerGridsMC.Electrical.Buses.Bus NTLV(SNom = 5e+08, UNom = 21000, portVariablesPhases = true, portVariablesPu = true)  annotation (
    Placement(visible = true, transformation(origin = {-30, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  PowerGridsMC.Electrical.Branches.TransformerFixedRatio TGEN(PStartA = 4.75e+08, PStartB = -4.75e+08, QStartA = 1.56e+08, QStartB = -7.6e+07, R = 0.15e-2 * 419 ^ 2 / 500, SNom = 5e+08, UNomA = 21000, UNomB = 419000, UPhaseStartA = 0.161156, UPhaseStartB = 0, UStartA = 0.9917 * 21e3, UStartB = 0.95227 * 380e3, X = 16e-2 * 419 ^ 2 / 500, portVariablesPhases = true, portVariablesPu = true, rFixed = 419 / 21)  annotation (
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGridsMC.Electrical.Buses.EquivalentGrid GRID(R_X = 1 / 10, SNom = 5e+08, SSC = 2.5e+09, UNom = 380000, URef = 1.05 * 380e3, c = 1.1, portVariablesPhases = true, portVariablesPu = true)  annotation (
    Placement(visible = true, transformation(origin = {56, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGridsMC.Electrical.Loads.LoadZeta GRIDL(
    PRefConst=4.75e+08,
    QRefConst=7.6e+07,
    SNom=5e+08,
    UNom=380000,
    URef=1.05*380e3,
    portVariablesPhases=true,
    portVariablesPu=true) annotation (Placement(visible=true, transformation(
        origin={50,-12},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  PowerGridsMC.Electrical.Buses.BusFault NTHV(R = 0.05,SNom = 5e+08, UNom = 380000, UPhaseStart = 0, UStart = 1.050 * 380e3,portVariablesPhases = true, portVariablesPu = true, startTime = 2, stopTime = 2.1)  annotation (
    Placement(visible = true, transformation(origin = {30, 0}, extent = {{-10, 10}, {10, -10}}, rotation = 90)));
  PowerGridsMC.Examples.Tutorial.GridOperation.Controlled.ControlledGenPSS
    ctrlGEN(AVR(Ka=150)) annotation (Placement(visible=true, transformation(
        origin={-64,0},
        extent={{-10,-10},{10,10}},
        rotation=0)));
equation
  connect(NTLV.terminal, TGEN.terminalA) annotation (
    Line(points = {{-30, 0}, {-10, 0}}));
  connect(TGEN.terminalB, NTHV.terminal) annotation (
    Line(points = {{10, 0}, {30, 0}}));
  connect(NTHV.terminal, GRID.terminal) annotation (
    Line(points = {{30, 0}, {36, 0}, {36, 10}, {56, 10}}));
  connect(NTHV.terminal, GRIDL.terminal) annotation (
    Line(points = {{30, 0}, {36, 0}, {36, -12}, {50, -12}}));
  connect(ctrlGEN.terminal, NTLV.terminal) annotation (
    Line(points = {{-64, 0}, {-30, 0}}));
  annotation (
    Diagram(coordinateSystem(extent = {{-80, 60}, {80, -20}}, grid = {0.5, 0.5})),
    experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-6, Interval = 0.02),
    __OpenModelica_commandLineOptions = "--daeMode --tearingMethod=minimalTearing",
    __OpenModelica_simulationFlags(nls="kinsol", lv="LOG_INIT_HOMOTOPY"),
    Documentation(info="<html>
<p><i><span style=\"font-family: Arial; font-size: 12pt;\">Library PowerGridsMC was forked from https://github.com/PowerGrids/PowerGrids on 22 November 2024.</span></i></p>
<p><i><span style=\"font-size: 12pt;\">The following info is derived from the original version on that source, modified whenever changes introduced in this fork require this.</span></i></p>
<p>************************** </p>
</html>"));
end ControlledGridWithControlledGen;
