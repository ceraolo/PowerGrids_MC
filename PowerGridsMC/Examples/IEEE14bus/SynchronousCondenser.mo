within PowerGridsMC.Examples.IEEE14bus;
model SynchronousCondenser "Model of a synchronous condenser for the IEEE-14 bus system"
  extends Icons.Machine;
  PowerGridsMC.Electrical.Machines.SynchronousMachine4Windings GEN(portVariablesPhases = true)  annotation (
    Placement(visible = true, transformation(origin = {-26, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGridsMC.Interfaces.TerminalAC terminal annotation (
    Placement(visible = true, transformation(origin = {-26, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Electrical.Controls.ExcitationSystems.VRProportional AVR(Ka = 20, VcPuStart = GEN.UStart / GEN.UNom, VrMax = 5, VrMin = -5)  annotation (
    Placement(visible = true, transformation(origin = {-70, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Controls.FreeOffset VrefPu(use_u = true)  annotation (
    Placement(visible = true, transformation(origin = {-100, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression VrefPuDef(y = 1)  annotation (
    Placement(visible = true, transformation(origin = {-134, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression PmPu(y = 0) annotation (
    Placement(visible = true, transformation(origin = {-70, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput omega annotation (
    Placement(visible = true, transformation(origin = {10, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {70, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(GEN.terminal, terminal) annotation (
    Line(points = {{-26, 0}, {-26, -50}}));
  connect(AVR.VcPu, GEN.VPu) annotation (
    Line(points={{-79.8,-4},{-172,-4},{-172,70},{40,70},{40,-6},{-16,-6}},            color = {0, 0, 127}));
  connect(AVR.efdPu, GEN.ufPuIn) annotation (
    Line(points={{-59.8,-10},{-50,-10},{-50,-4},{-36,-4},{-36,-4}},          color = {0, 0, 127}));
  connect(VrefPu.y, AVR.VrefPu) annotation (
    Line(points={{-89,-22},{-86,-22},{-86,-16},{-79.8,-16},{-79.8,-16}},        color = {0, 0, 127}));
  connect(VrefPuDef.y, VrefPu.u) annotation (
    Line(points={{-123,-22},{-110,-22},{-110,-22},{-111,-22}},          color = {0, 0, 127}));
  connect(GEN.omega, omega) annotation (
    Line(points={{-15.9,5.9},{-8,5.9},{-8,16},{10,16},{10,16}},      color = {0, 0, 127}));
  connect(PmPu.y, GEN.PmPu) annotation (
    Line(points={{-59,20},{-50,20},{-50,4},{-36,4},{-36,4}},            color = {0, 0, 127}));
  annotation (
    Icon(coordinateSystem(grid = {0.1, 0.1}, initialScale = 0.1), graphics={  Text(origin = {12, -74}, extent = {{-58, 10}, {34, -4}}, textString = "CONTROL"), Rectangle(origin = {0, -70}, extent = {{-50, 10}, {50, -10}}), Text(origin = {-106, 0}, extent = {{-36, 40}, {36, -40}}, textString = "SC")}),
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}}, grid = {0.5, 0.5})),
    Documentation(info="<html>
<p><i><span style=\"font-family: Arial; font-size: 12pt;\">Library PowerGridsMC was forked from https://github.com/PowerGrids/PowerGrids on 22 November 2024.</span></i></p>
<p><i><span style=\"font-size: 12pt;\">The following info is derived from the original version on that source, modified whenever changes introduced in this fork require this.</span></i></p>
<p>************************** </p>
</html>"));
end SynchronousCondenser;
