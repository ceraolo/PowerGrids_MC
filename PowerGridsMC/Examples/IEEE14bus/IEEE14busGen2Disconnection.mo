within PowerGridsMC.Examples.IEEE14bus;
model IEEE14busGen2Disconnection "Simulation of the disconnection of generator 2 at t = 1 s"
  extends IEEE14busStaticNetwork(Tgen2(useBreaker = true));
  Modelica.Blocks.Sources.BooleanExpression Gen2BreakerState(y = time < 1)  annotation (
    Placement(visible = true, transformation(origin={-154,-74},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(Gen2BreakerState.y, Tgen2.breakerStatusIn) annotation (
    Line(points={{-143,-74},{-124,-74},{-124,-89},{-127,-89}},          color = {255, 0, 255}));

annotation (
    Diagram(coordinateSystem(extent={{-180,120},{180,-120}})),
    experiment(StartTime = 0, StopTime = 40, Tolerance = 1e-6, Interval = 0.04),
    Documentation(info="<html>
<p><i><span style=\"font-family: Arial; font-size: 12pt;\">Library PowerGridsMC was forked from https://github.com/PowerGrids/PowerGrids on 22 November 2024.</span></i></p>
<p><i><span style=\"font-size: 12pt;\">The following info is derived from the original version on that source, modified whenever changes introduced in this fork require this.</span></i></p>
<p>************************** </p>
</html>"));
end IEEE14busGen2Disconnection;
