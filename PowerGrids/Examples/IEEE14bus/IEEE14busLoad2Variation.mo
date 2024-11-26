within PowerGrids.Examples.IEEE14bus;
model IEEE14busLoad2Variation "Simulation of a load increase on load 2 at t = 1 s"
  extends IEEE14busStaticNetwork(
    Load2(
      PRef = Load2.PRefConst*(if time < 1 then 1 else 2) "Active power consumption at reference voltage",
      QRef = Load2.QRefConst*(if time < 1 then 1 else 2) "Reactive power consumption at reference voltage"));
equation

  annotation (
    Icon(coordinateSystem(grid = {0.1, 0.1})),
    Diagram(coordinateSystem(extent={{-180,120},{180,-120}},      grid={2,2}),                            graphics={  Text(origin={-72,-105},   textColor={238,46,
              47},                                                                                                                                                       extent={{-22,7},
              {22,-7}},
          textString="Load2 changed
by modifiers",
          horizontalAlignment=TextAlignment.Left)}),
    experiment(StartTime = 0, StopTime = 40, Tolerance = 1e-6, Interval = 0.04));
end IEEE14busLoad2Variation;
