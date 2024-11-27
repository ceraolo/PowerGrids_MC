within PowerGridsMC.Examples.IEEE14bus;
model ControlledGeneratorIEEE "Model of controlled generator for the IEEE 14-bus benchmark - synchronous machine with proportional regulations"
  extends Icons.Machine;
  PowerGridsMC.Electrical.Machines.SynchronousMachine4Windings GEN(portVariablesPhases = true)  annotation (
    Placement(visible = true, transformation(                   extent={{28,-26},
            {48,-6}},                                                                            rotation = 0)));
  PowerGridsMC.Interfaces.TerminalAC terminal annotation (
    Placement(visible = true, transformation(origin={38,-46},     extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Electrical.Controls.ExcitationSystems.VRProportional AVR(Ka = 20, VcPuStart = GEN.UStart / GEN.UNom, VrMax = 5, VrMin = -5)  annotation (
    Placement(visible = true, transformation(origin={-2,-26},     extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Electrical.Controls.TurbineGovernors.GoverProportional GOV(KGover = 5, PMaxPu = 1, PMinPu = 0, PPuStart = -GEN.PStart / GEN.PNom)  annotation (
    Placement(visible = true, transformation(origin={4,14},      extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGridsMC.Controls.FreeOffset PmRefPu(use_u = true)  annotation (
    Placement(visible = true, transformation(origin={-28,26},     extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Controls.FreeOffset VrefPu(use_u = true)  annotation (
    Placement(visible = true, transformation(origin={-32,-38},     extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression VrefPuDef(y = 1)  annotation (
    Placement(visible = true, transformation(origin={-62,-38},     extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression PmRefPuDef(y = -GEN.PStart / GEN.PNom) annotation (
    Placement(visible = true, transformation(origin={-54,26},     extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput omega annotation (
    Placement(visible = true, transformation(origin={56,8},     extent = {{-10, -10}, {10, 10}}, rotation=90),  iconTransformation(origin = {70, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(GEN.terminal, terminal) annotation (
    Line(points={{38,-16},{38,-46}}));
  connect(GOV.omegaPu, GEN.omegaPu) annotation (
    Line(points={{-6,10},{-68,10},{-68,48},{66,48},{66,-14},{48,-14}},              color = {0, 0, 127}));
  connect(AVR.VcPu, GEN.VPu) annotation (
    Line(points={{-11.8,-20},{-76,-20},{-76,52},{74,52},{74,-22},{48,-22}},           color = {0, 0, 127}));
  connect(AVR.efdPu, GEN.ufPuIn) annotation (
    Line(points={{8.2,-26},{14,-26},{14,-20},{28,-20}},                      color = {0, 0, 127}));
  connect(GOV.PMechPu, GEN.PmPu) annotation (
    Line(points={{15,14},{22,14},{22,-12},{28,-12}},                    color = {0, 0, 127}));
  connect(PmRefPu.y, GOV.PmRefPu) annotation (
    Line(points={{-17,26},{-12,26},{-12,18},{-6,18}},                      color = {0, 0, 127}));
  connect(VrefPu.y, AVR.VrefPu) annotation (
    Line(points={{-21,-38},{-16,-38},{-16,-32},{-11.8,-32}},                    color = {0, 0, 127}));
  connect(VrefPuDef.y, VrefPu.u) annotation (
    Line(points={{-51,-38},{-43,-38}},                                  color = {0, 0, 127}));
  connect(GEN.PPu, GOV.PPu) annotation (
    Line(points={{48,-18},{70,-18},{70,50},{-72,50},{-72,0},{10,0},{10,4}},                      color = {0, 0, 127}));
  connect(PmRefPuDef.y, PmRefPu.u) annotation (
    Line(points={{-43,26},{-39,26}},        color = {0, 0, 127}));
  connect(GEN.omega, omega) annotation (
    Line(points={{48.1,-10.1},{56,-10.1},{56,8}},                    color = {0, 0, 127}));
  annotation (
    Icon(coordinateSystem(grid = {0.1, 0.1}, initialScale = 0.1), graphics={  Text(origin = {12, -74}, extent = {{-58, 10}, {34, -4}}, textString = "CONTROL"), Rectangle(origin = {0, -70}, extent = {{-50, 10}, {50, -10}})}),
    Diagram(coordinateSystem(extent={{-80,-60},{80,60}})));
end ControlledGeneratorIEEE;
