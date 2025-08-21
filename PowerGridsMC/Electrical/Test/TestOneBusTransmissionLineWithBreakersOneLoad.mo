within PowerGridsMC.Electrical.Test;
model TestOneBusTransmissionLineWithBreakersOneLoad
  extends Modelica.Icons.Example;
  PowerGridsMC.Electrical.Buses.InfiniteBus infiniteBus(SNom = 1e+07, UNom = 10000, portVariablesPu = true, theta = 0.523599) annotation (
    Placement(visible = true, transformation(origin = {-40, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  PowerGridsMC.Electrical.Loads.LoadAlphaBeta loadPQ(
    PRefConst=1e+07,
    QRefConst=0,
    SNom=1e+07,
    UNom=10000,
    alpha=0,
    beta=0,
    portVariablesPhases=true) annotation (Placement(visible=true,
        transformation(
        origin={20,0},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  inner PowerGridsMC.Electrical.System systemPowerGrids annotation (
    Placement(transformation(origin = {30, 50}, extent = {{-10, -10}, {10, 10}})));
  PowerGridsMC.Electrical.Branches.LineConstantImpedanceWithBreakers transmissionLine(B = 0.02, G = 0.01,R = 0.3, SNom = 1e+07, UNom = 10000, X = 1.5, portVariablesPu = true) annotation (
    Placement(visible = true, transformation(origin = {-10, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(infiniteBus.terminal, transmissionLine.terminalA) annotation (
    Line(points = {{-40, 0}, {-20, 0}}));
  connect(transmissionLine.terminalB, loadPQ.terminal) annotation (
    Line(points = {{0, 0}, {20, 0}}));
  annotation (
    Icon(coordinateSystem(grid = {0.1, 0.1})),
    Diagram(coordinateSystem(extent = {{-60, 60}, {40, -20}})),
    experiment(StopTime = 1, Interval = 0.02),
    Documentation(info = "<html><head></head><body><p>Same behaviour as <a href=\"modelica://PowerGridsMC.Electrical.Test.OneBusTransmissionLineShuntOneLoad\">OneBusTransmissionLineShuntOneLoad</a>, but this time the line has two breakers, one for each port. The breakers are kept closed and all electrical quantities are the same of the OneBusTransmissionLineShuntOneLoad test.
</body></html>"));
end TestOneBusTransmissionLineWithBreakersOneLoad;
