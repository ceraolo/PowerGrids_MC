within PowerGridsMC.Examples.IEEE14bus;
model SynchronousCondenser "Model of a synchronous condenser for the IEEE-14 bus system"
  extends Icons.Machine;
  PowerGridsMC.Electrical.Machines.SynchronousMachine4Windings GEN(portVariablesPhases = true)  annotation (
    Placement(visible = true, transformation(                   extent={{14,-6},
            {34,14}},                                                                            rotation = 0)));
  PowerGridsMC.Interfaces.TerminalAC terminal annotation (
    Placement(visible = true, transformation(origin={24,24},      extent={{-4,-4},
            {4,4}},                                                                                rotation = 0), iconTransformation(                 extent={{-10,-10},
            {10,10}},                                                                                                                                                                  rotation = 0)));
  Electrical.Controls.ExcitationSystems.VRProportional AVR(Ka = 20, VcPuStart = GEN.UStart / GEN.UNom, VrMax = 5, VrMin = -5)  annotation (
    Placement(visible = true, transformation(origin={-20,-6},     extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Controls.FreeOffset VrefPu(use_u = true)  annotation (
    Placement(visible = true, transformation(origin={-50,-18},     extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression VrefPuDef(y = 1)  annotation (
    Placement(visible = true, transformation(origin={-78,-18},     extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression PmPu(y = 0) annotation (
    Placement(visible = true, transformation(origin={-20,24},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput omega annotation (
    Placement(visible = true, transformation(origin={54,10},    extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin={110,0},   extent = {{-10, -10}, {10, 10}}, rotation = 0)));

  parameter Boolean showPortData=true "=false, if PowerFlow data are to be shown";
  outer Electrical.System systemPowerGrids "Reference to system object";
  parameter Boolean showDataOnDiagramsPu = systemPowerGrids.showDataOnDiagramsPu
   "=true, P,Q,V and phase are shown on the diagrams in per-unit of local machine base"
   annotation(Dialog(tab = "Visualization"));

equation
  connect(GEN.terminal, terminal) annotation (
    Line(points={{24,4},{24,24}}));
  connect(AVR.VcPu, GEN.VPu) annotation (
    Line(points={{-29.8,0},{-44,0},{-44,36},{68,36},{68,-2},{34.2,-2}},               color = {0, 0, 127}));
  connect(AVR.efdPu, GEN.ufPuIn) annotation (
    Line(points={{-9.8,-6},{0,-6},{0,0},{13.6,0}},                           color = {0, 0, 127}));
  connect(VrefPu.y, AVR.VrefPu) annotation (
    Line(points={{-39,-18},{-36,-18},{-36,-12},{-29.8,-12}},                    color = {0, 0, 127}));
  connect(VrefPuDef.y, VrefPu.u) annotation (
    Line(points={{-67,-18},{-61,-18}},                                  color = {0, 0, 127}));
  connect(GEN.omega, omega) annotation (
    Line(points={{34.3,9.9},{42,9.9},{42,10},{54,10}},               color = {0, 0, 127}));
  connect(PmPu.y, GEN.pmPuIn) annotation (Line(points={{-9,24},{0,24},{0,8},{
          13.6,8},{13.6,7.4}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(grid={2,2}),   graphics={                                                                                                                                                   Text(origin={-72,-30},   extent={{-30,16},
              {30,-16}},
          textString="0",
          textColor={0,0,0}),
        Line(points={{-56,-30},{-37.1,-30.3}},   color={28,108,200}),
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
        Line(points={{-73,-67.7},{-37.1,-67.7},{-36.8,-66.9}}, color={28,108,200}),
       Text(
          visible=showPortData,
          extent={{-114,66},{-4,30}},
          lineColor={238,46,47},
          textString=DynamicSelect("P",
             if showDataOnDiagramsPu then
               String(-GEN.port.PGenPu, format = "6.3f")
             else
               String(-GEN.port.PGen/1e6, format = "9.2f"))),
       Text(
          visible=showPortData,
          extent={{0,66},{122,30}},
          lineColor={217,67,180},
         textString=DynamicSelect("Q",
             if showDataOnDiagramsPu then
               String(-GEN.port.QGenPu, format = "6.3f")
             else
               String(-GEN.port.QGen/1e6, format = "9.2f")))}

),  Diagram(coordinateSystem(extent={{-100,-40},{80,40}})),
    Documentation(info="<html>
<p><i><span style=\"font-family: Arial; font-size: 12pt;\">Library PowerGridsMC was forked from https://github.com/PowerGrids/PowerGrids on 22 November 2024.</span></i></p>
<p><i><span style=\"font-size: 12pt;\">The following info is derived from the original version on that source, modified whenever changes introduced in this fork require this.</span></i></p>
<p>************************** </p>
</html>"));
end SynchronousCondenser;
