within PowerGridsMC.Examples.Tutorial.GridOperation.Controlled;
model ControlledGridWithReferenceCalculationSat "System under automatic control with automatic computation of set point offsets - saturation case"
  extends ControlledGridWithReferenceCalculation(AVR(
                                                 VrMax     = 0.5));
  annotation (
    Icon(coordinateSystem(grid = {0.1, 0.1})),
    Diagram(coordinateSystem(extent = {{-120, 60}, {100, -60}}, grid = {0.5, 0.5})),
  experiment(StartTime = 0, StopTime = 30, Tolerance = 1e-6, Interval = 0.02),
    __OpenModelica_commandLineOptions = "--daeMode --tearingMethod=minimalTearing",
    __OpenModelica_simulationFlags(nls="kinsol", lv="LOG_INIT_HOMOTOPY"),
    Documentation(info="<html>
<p><i><span style=\"font-family: Arial; font-size: 12pt;\">Library PowerGridsMC was forked from https://github.com/PowerGrids/PowerGrids on 22 November 2024.</span></i></p>
<p><i><span style=\"font-size: 12pt;\">The following info is derived from the original version on that source, modified whenever changes introduced in this fork require this.</span></i></p>
<p>************************** </p>
</html>"));
end ControlledGridWithReferenceCalculationSat;
