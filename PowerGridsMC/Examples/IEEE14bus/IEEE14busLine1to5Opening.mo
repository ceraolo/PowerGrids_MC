within PowerGridsMC.Examples.IEEE14bus;
model IEEE14busLine1to5Opening "Simulation of the opening of line 1 to 5 at t = 1 s"
  extends IEEE14busStaticNetwork(L1to5(useBreakerB = true));
  Modelica.Blocks.Sources.BooleanExpression L1to5BreakerState(y = time < 1)  annotation (
    Placement(transformation(origin = {-102, -36}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(L1to5BreakerState.y, L1to5.breakerStatusB) annotation (
    Line(points={{-91,-36},{-84,-36},{-84,-51},{-97,-51}},          color = {255, 0, 255}));

annotation (
    Icon(coordinateSystem(grid = {0.1, 0.1})),
    Diagram(coordinateSystem(extent={{-180,120},{180,-120}},      grid={2,2})),
    experiment(StartTime = 0, StopTime = 40, Tolerance = 1e-6, Interval = 0.04),
    __OpenModelica_simulationFlags(homotopyOnFirstTry="()"),
    Documentation(info="<html>
<p><i><span style=\"font-family: Arial; font-size: 12pt;\">Library PowerGridsMC was forked from https://github.com/PowerGrids/PowerGrids on 22 November 2024.</span></i></p>
<p><i><span style=\"font-size: 12pt;\">The following info is derived from the original version on that source, modified whenever changes introduced in this fork require this.</span></i></p>
<p>************************** </p>
</html>"));
end IEEE14busLine1to5Opening;
