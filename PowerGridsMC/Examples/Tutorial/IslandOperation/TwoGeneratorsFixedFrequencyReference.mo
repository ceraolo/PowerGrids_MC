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
<p></span><i><span style=\"font-size: 12pt;\">Library PowerGridsMC is forked from https://github.com/PowerGrids/PowerGrids.</i></p>
<p></span><i><span style=\"font-size: 12pt;\">The following info is derived from the original version on that source, modified whenever changes introduced in this fork require this.</i></p>
**************************
</html>"));
end TwoGeneratorsFixedFrequencyReference;
