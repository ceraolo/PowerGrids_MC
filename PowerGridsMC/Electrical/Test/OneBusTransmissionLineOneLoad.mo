within PowerGridsMC.Electrical.Test;
model OneBusTransmissionLineOneLoad
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
    Placement(transformation(origin = {50, 50}, extent = {{-10, -10}, {10, 10}})));
  PowerGridsMC.Electrical.Branches.LineConstantImpedance transmissionLine(R = 0.3, SNom = 1e+07, UNom = 10000, X = 1.5, portVariablesPu = true) annotation (
    Placement(visible = true, transformation(origin = {-10, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(infiniteBus.terminal, transmissionLine.terminalA) annotation (
    Line(points = {{-40, 0}, {-20, 0}}));
  connect(transmissionLine.terminalB, loadPQ.terminal) annotation (
    Line(points = {{0, 0}, {20, 0}}));
  annotation (
    Icon(coordinateSystem(grid = {0.1, 0.1})),
    Diagram(coordinateSystem(extent = {{-60, 60}, {60, -20}})),
    experiment(StopTime = 1, Interval = 0.02),
    Documentation(info = "<html><head></head><body><p>Same behaviour as <a href=\"modelica://PowerGridsMC.Electrical.Test.OneBusImpedanceOneLoad\">OneBusImpedanceOneLoad</a>, but this time the line impedance is not built-in the bus but rather represented explicitly with a Transmission Line. All quantities in the load are the same.
</body></html>"));
end OneBusTransmissionLineOneLoad;
