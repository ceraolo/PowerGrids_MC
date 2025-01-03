within PowerGridsMC.Electrical.Loads;
model LoadAlphaBetaInputs
  "Load model with voltage dependent P and Q specified by inputs"
  extends LoadAlphaBeta          (
    final PRef = PRefIn,
    final QRef = QRefIn,
    final PRefConst = 0,
    final QRefConst = 0,
    PStart = 0,
    QStart = 0);
  Modelica.Blocks.Interfaces.RealInput PRefIn(unit="W", displayUnit="MW") "Active reference power at VPu = 1, W" annotation (
    Placement(visible = true, transformation(origin = {-100, 36}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput QRefIn(unit="var", displayUnit = "MVA") "Reactive reference power at VPu = 1, var" annotation (
    Placement(visible = true, transformation(origin = {-100, -44}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, -100}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  annotation (
    Icon(coordinateSystem(grid={2,2}), graphics={Text(
          extent={{-90,0},{-54,-24}},
          textColor={0,0,0},
          textString="P"), Text(
          extent={{-88,-68},{-52,-92}},
          textColor={0,0,0},
          textString="Q")}),
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
  Documentation(info = "<html><head></head><body><p>Model of a PQ load with voltage dependence.</p>
<p><code style=\"font-size: 12px;\">port.P = PRefIn*(port.U/URef)^alpha;</code><span style=\"font-size: 12px;\">&nbsp;</span><br style=\"font-size: 12px;\"><code style=\"font-size: 12px;\">port.Q = QRefIn*(port.U/URef)^beta;</code></p>
<p>The reference active and reactive powers are provided by input connectors.</p><p>By default <code>alpha = 0</code> and <code>beta = 0</code>, so there is no voltage dependence.</p>
</body></html>"));
end LoadAlphaBetaInputs;
