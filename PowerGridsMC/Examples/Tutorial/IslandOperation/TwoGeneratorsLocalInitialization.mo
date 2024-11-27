within PowerGridsMC.Examples.Tutorial.IslandOperation;
model TwoGeneratorsLocalInitialization
  extends PowerGridsMC.Examples.Tutorial.IslandOperation.TwoGeneratorsOneReferenceGenerator(
      systemPowerGrids(                                                                   initOpt                  = PowerGridsMC.Types.Choices.InitializationOption.localSteadyStateFixedPowerFlow));
equation

annotation (
    __OpenModelica_commandLineOptions = "--tearingMethod=minimalTearing",
    __OpenModelica_simulationFlags(nls="kinsol", lv="LOG_INIT_HOMOTOPY"));
end TwoGeneratorsLocalInitialization;
