within PowerGridsMC.Examples.IEEE14bus;
model ControlledGenNoPSS
  "Model of controlled generator for the IEEE 14-bus benchmark - synchronous machine with proportional regulations"
  extends Icons.Machine;
  PowerGridsMC.Electrical.Machines.SynchronousMachine4Windings GEN(portVariablesPhases = true)  annotation (
    Placement(visible = true, transformation(                   extent={{28,-26},
            {48,-6}},                                                                            rotation = 0)));
  PowerGridsMC.Interfaces.TerminalAC terminal annotation (
    Placement(visible = true, transformation(origin={38,26},      extent={{-6,-6},
            {6,6}},                                                                                rotation = 0), iconTransformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Electrical.Controls.ExcitationSystems.VRProportional AVR(Ka = 20, VcPuStart = GEN.UStart / GEN.UNom, VrMax = 5, VrMin = -5)  annotation (
    Placement(visible = true, transformation(origin={-2,-26},     extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Electrical.Controls.TurbineGovernors.GoverProportional GOV(KGover = 5, PMaxPu = 1, PMinPu = 0, PPuStart = -GEN.PStart / GEN.PNom)  annotation (
    Placement(visible = true, transformation(origin={4,14},      extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGridsMC.Controls.FreeOffset mpRefPu(use_u = true)  annotation (
    Placement(visible = true, transformation(origin={-28,26},     extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Controls.FreeOffset vRefPu(use_u=true) annotation (Placement(visible=true,
        transformation(
        origin={-32,-38},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.RealExpression vRrefPuDef(y=1) annotation (Placement(
        visible=true, transformation(
        origin={-62,-38},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.RealExpression mpRefPuDef(y = -GEN.PStart / GEN.PNom) annotation (
    Placement(visible = true, transformation(origin={-54,26},     extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput omega annotation (
    Placement(visible = true, transformation(origin={56,8},     extent = {{-10, -10}, {10, 10}}, rotation=90),  iconTransformation(origin={110,0},   extent = {{-10, -10}, {10, 10}}, rotation = 0)));

  parameter Boolean showPortData=true "=false, if PowerFlow data are to be shown";
  outer Electrical.System systemPowerGrids "Reference to system object";
  parameter Boolean showDataOnDiagramsPu = systemPowerGrids.showDataOnDiagramsPu
   "=true, P,Q,V and phase are shown on the diagrams in per-unit of local machine base"
   annotation(Dialog(tab = "Visualization"));

equation
  connect(GEN.terminal, terminal) annotation (
    Line(points={{38,-16},{38,26}}));
  connect(GOV.omegaPu, GEN.omegaPu) annotation (
    Line(points={{-6,10},{-68,10},{-68,48},{66,48},{66,-14},{48.2,-14}},            color = {0, 0, 127}));
  connect(AVR.VcPu, GEN.VPu) annotation (
    Line(points={{-11.8,-20},{-76,-20},{-76,52},{74,52},{74,-22},{48.2,-22}},         color = {0, 0, 127}));
  connect(AVR.efdPu, GEN.ufPuIn) annotation (
    Line(points={{8.2,-26},{14,-26},{14,-20},{27.6,-20}},                    color = {0, 0, 127}));
  connect(GOV.PMechPu, GEN.pmPuIn) annotation (Line(points={{15,14},{22,14},{22,
          -12.6},{27.6,-12.6}}, color={0,0,127}));
  connect(mpRefPu.y, GOV.PmRefPu) annotation (
    Line(points={{-17,26},{-12,26},{-12,18},{-6,18}},                      color = {0, 0, 127}));
  connect(vRefPu.y, AVR.VrefPu) annotation (Line(points={{-21,-38},{-16,-38},{-16,
          -32},{-11.8,-32}}, color={0,0,127}));
  connect(vRrefPuDef.y, vRefPu.u)
    annotation (Line(points={{-51,-38},{-43,-38}}, color={0,0,127}));
  connect(GEN.PPu, GOV.PPu) annotation (
    Line(points={{48.2,-18},{70,-18},{70,50},{-72,50},{-72,0},{10,0},{10,4}},                    color = {0, 0, 127}));
  connect(mpRefPuDef.y,mpRefPu. u) annotation (
    Line(points={{-43,26},{-39,26}},        color = {0, 0, 127}));
  connect(GEN.omega, omega) annotation (
    Line(points={{48.3,-10.1},{56,-10.1},{56,8}},                    color = {0, 0, 127}));
  connect(terminal, terminal)
    annotation (Line(points={{38,26},{38,26}}, color={0,0,0}));
  annotation (
    Icon(coordinateSystem(grid={2,2}), graphics={
        Line(points={{-71.9,-28},{-33.1,-28.3}}, color={28,108,200}),
        Line(points={{-71,-71.7},{-35.1,-71.7},{-34.8,-70.9}}, color={28,108,200}),
        Polygon(
          points={{-42.2,-24.2},{-42.2,-32.1},{-33.1,-28.6},{-42.2,-24.2}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-44.2,-67.1},{-44.2,-75},{-34.8,-71.5},{-44.2,-67.1}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
       Text(
          visible=showPortData,
          extent={{-110,64},{-6,34}},
          lineColor={238,46,47},
          textString=DynamicSelect("P",
             if showDataOnDiagramsPu then
               String(-GEN.port.PGenPu, format = "6.3f")
             else
               String(GEN.port.S.re/1e6, format = "9.2f"))),
       Text(
          visible=showPortData,
          extent={{0,64},{104,34}},
          lineColor={217,67,180},
          textString=DynamicSelect("Q",
             if showDataOnDiagramsPu then
               String(-GEN.port.QGenPu, format = "6.3f")
             else
               String(GEN.port.S.im/1e6, format = "9.2f")))}



),  Diagram(coordinateSystem(extent={{-80,-60},{80,60}})),
    Documentation(info="<html>
<p><i><span style=\"font-family: Arial; font-size: 12pt;\">Library PowerGridsMC was forked from https://github.com/PowerGrids/PowerGrids on 22 November 2024.</span></i></p>
<p><i><span style=\"font-size: 12pt;\">The following info is derived from the original version on that source, modified whenever changes introduced in this fork require this.</span></i></p>
<p>************************** </p>
</html>"));
end ControlledGenNoPSS;
