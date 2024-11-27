within PowerGridsMC.Examples.Tutorial.IslandOperation;
model TwoGeneratorsLocalInitialization
  extends PowerGridsMC.Examples.Tutorial.IslandOperation.TwoGeneratorsOneReferenceGenerator(
      systemPowerGrids(                                                                   initOpt                  = PowerGridsMC.Types.Choices.InitializationOption.localSteadyStateFixedPowerFlow));
equation

annotation (
    __OpenModelica_commandLineOptions = "--tearingMethod=minimalTearing",
    __OpenModelica_simulationFlags(nls="kinsol", lv="LOG_INIT_HOMOTOPY"),
    Documentation(info="<html>
<p><i><span style=\"font-family: Arial; font-size: 12pt;\">Library PowerGridsMC was forked from https://github.com/PowerGrids/PowerGrids on 22 November 2024.</span></i></p>
<p><i><span style=\"font-size: 12pt;\">The following info is derived from the original version on that source, modified whenever changes introduced in this fork require this.</span></i></p>
<p>************************** </p>
</html>"));
end TwoGeneratorsLocalInitialization;
