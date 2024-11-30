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
    Line(points={{-79.8,-4},{-172,-4},{-172,70},{40,70},{40,-6},{-15.8,-6}},          color = {0, 0, 127}));
  connect(AVR.efdPu, GEN.ufPuIn) annotation (
    Line(points={{-59.8,-10},{-50,-10},{-50,-4},{-36.4,-4},{-36.4,-4}},      color = {0, 0, 127}));
  connect(VrefPu.y, AVR.VrefPu) annotation (
    Line(points={{-89,-22},{-86,-22},{-86,-16},{-79.8,-16},{-79.8,-16}},        color = {0, 0, 127}));
  connect(VrefPuDef.y, VrefPu.u) annotation (
    Line(points={{-123,-22},{-110,-22},{-110,-22},{-111,-22}},          color = {0, 0, 127}));
  connect(GEN.omega, omega) annotation (
    Line(points={{-15.7,5.9},{-8,5.9},{-8,16},{10,16},{10,16}},      color = {0, 0, 127}));
  connect(PmPu.y, GEN.PmPu) annotation (
    Line(points={{-59,20},{-50,20},{-50,4},{-36.4,4},{-36.4,3.4}},      color = {0, 0, 127}));
  annotation (
    Icon(coordinateSystem(grid={2,2}),                            graphics={                                                                                                                                                   Text(origin = {-106, 0}, extent = {{-36, 40}, {36, -40}}, textString = "SC"),
        Line(points={{-73.9,-30},{-35.1,-30.3}}, color={28,108,200}),
        Polygon(
          points={{-44.2,-26.2},{-44.2,-34.1},{-35.1,-30.6},{-44.2,-26.2}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-46.2,-63.1},{-46.2,-71},{-36.8,-67.5},{-46.2,-63.1}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Line(points={{-73,-67.7},{-37.1,-67.7},{-36.8,-66.9}}, color={28,108,200})}),
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}}, grid = {0.5, 0.5})),
    Documentation(info="<html>
<p><i><span style=\"font-family: Arial; font-size: 12pt;\">Library PowerGridsMC was forked from https://github.com/PowerGrids/PowerGrids on 22 November 2024.</span></i></p>
<p><i><span style=\"font-size: 12pt;\">The following info is derived from the original version on that source, modified whenever changes introduced in this fork require this.</span></i></p>
<p>************************** </p>
</html>"));
end SynchronousCondenser;
