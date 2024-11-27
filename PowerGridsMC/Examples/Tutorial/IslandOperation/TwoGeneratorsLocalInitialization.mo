within PowerGridsMC.Examples.Tutorial.IslandOperation;
model TwoGeneratorsLocalInitialization
  extends PowerGridsMC.Examples.Tutorial.IslandOperation.TwoGeneratorsOneReferenceGenerator(
      systemPowerGrids(                                                                   initOpt                  = PowerGridsMC.Types.Choices.InitializationOption.localSteadyStateFixedPowerFlow));
equation

annotation (
    __OpenModelica_commandLineOptions = "--tearingMethod=minimalTearing",
    __OpenModelica_simulationFlags(nls="kinsol", lv="LOG_INIT_HOMOTOPY"),
    Documentation(info="<html>
<p></span><i><span style=\"font-size: 12pt;\">Library PowerGridsMC is forked from https://github.com/PowerGrids/PowerGrids.</i></p>
<p></span><i><span style=\"font-size: 12pt;\">The following info is derived from the original version on that source, modified whenever changes introduced in this fork require this.</i></p>
**************************
</html>"));
end TwoGeneratorsLocalInitialization;
