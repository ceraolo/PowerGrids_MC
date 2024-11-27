within PowerGridsMC.Examples.Tutorial.IslandOperation;
model TwoGeneratorsFixedFrequencyReference
  extends TwoGeneratorsOneReferenceGenerator(systemPowerGrids(
                                             referenceFrequency                  = PowerGridsMC.Types.Choices.ReferenceFrequency.nominalFrequency));
  annotation (
    Icon(coordinateSystem(grid = {0.1, 0.1})),
    Diagram(coordinateSystem(extent = {{-100, 40}, {120, -20}}, grid = {0.5, 0.5})),
    experiment(StartTime = 0, StopTime = 30, Tolerance = 1e-06, Interval = 0.01),
    __OpenModelica_commandLineOptions = "--tearingMethod=minimalTearing",
    __OpenModelica_simulationFlags(nls="kinsol", lv="LOG_INIT_HOMOTOPY"),
    Documentation(info="<html>
<p><i><span style=\"font-family: Arial; font-size: 12pt;\">Library PowerGridsMC was forked from https://github.com/PowerGrids/PowerGrids on 22 November 2024.</span></i></p>
<p><i><span style=\"font-size: 12pt;\">The following info is derived from the original version on that source, modified whenever changes introduced in this fork require this.</span></i></p>
<p>************************** </p>
</html>"));
end TwoGeneratorsFixedFrequencyReference;
