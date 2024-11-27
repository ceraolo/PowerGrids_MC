within PowerGridsMC.Examples.Tutorial.GridOperation.Controlled;
model ControlledGridParametersChange "Variant of ControlledGridWithPSS"
  extends Modelica.Icons.Example;
  extends Examples.Tutorial.GridOperation.Controlled.ControlledGridWithPSS(
    TGOV(T1 = 0.4 "Governor new time constant"),
    AVR(Ka = 210 "Overall new equivalent gain"));
annotation (
    Icon(coordinateSystem(grid = {0.1, 0.1})),
    Diagram(coordinateSystem(extent = {{-120, 60}, {80, -60}}, grid = {0.5, 0.5})),
    experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-6, Interval = 0.02),
    __OpenModelica_commandLineOptions = "--daeMode --tearingMethod=minimalTearing",
    __OpenModelica_simulationFlags(nls="kinsol", lv="LOG_INIT_HOMOTOPY"),
    Documentation(info="<html>
<p></span><i><span style=\"font-size: 12pt;\">Library PowerGridsMC is forked from https://github.com/PowerGrids/PowerGrids.</i></p>
<p></span><i><span style=\"font-size: 12pt;\">The following info is derived from the original version on that source, modified whenever changes introduced in this fork require this.</i></p>
**************************
</html>"));
end ControlledGridParametersChange;
