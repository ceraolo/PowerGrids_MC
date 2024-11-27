within PowerGridsMC.Examples.Tutorial.GridOperation.Static;
model StaticGridComputedParameters "System operating in steady-state with computed inputs"
  extends StaticGrid(
    PmPu(y = -GEN.PStart / GEN.SNom),
    ufPuIn(y = GEN.ufPuInStart));
  annotation (
    Diagram(coordinateSystem(extent={{-80,-40},{80,40}})),
    experiment(StartTime = 0, StopTime = 2, Tolerance = 1e-6, Interval = 0.004),
    __OpenModelica_commandLineOptions = "--daeMode --tearingMethod=minimalTearing",
    __OpenModelica_simulationFlags(nls="kinsol", lv="LOG_INIT_HOMOTOPY"),
    Documentation(info="<html>
<p><i><span style=\"font-family: Arial; font-size: 12pt;\">Library PowerGridsMC was forked from https://github.com/PowerGrids/PowerGrids on 22 November 2024.</span></i></p>
<p><i><span style=\"font-size: 12pt;\">The following info is derived from the original version on that source, modified whenever changes introduced in this fork require this.</span></i></p>
<p>************************** </p>
</html>"));
end StaticGridComputedParameters;
