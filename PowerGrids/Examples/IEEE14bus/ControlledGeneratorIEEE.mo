within PowerGrids.Examples.IEEE14bus;
model ControlledGeneratorIEEE "Model of controlled generator for the IEEE 14-bus benchmark - synchronous machine with proportional regulations"
  extends Icons.Machine;
  PowerGrids.Electrical.Machines.SynchronousMachine4Windings GEN(portVariablesPhases = true)  annotation (
    Placement(visible = true, transformation(                   extent={{26,-10},
            {46,10}},                                                                            rotation = 0)));
  PowerGrids.Interfaces.TerminalAC terminal annotation (
    Placement(visible = true, transformation(origin={36,-40},     extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Electrical.Controls.ExcitationSystems.VRProportional AVR(Ka = 20, VcPuStart = GEN.UStart / GEN.UNom, VrMax = 5, VrMin = -5)  annotation (
    Placement(visible = true, transformation(origin={-4,-10},     extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Electrical.Controls.TurbineGovernors.GoverProportional GOV(KGover = 5, PMaxPu = 1, PMinPu = 0, PPuStart = -GEN.PStart / GEN.PNom)  annotation (
    Placement(visible = true, transformation(origin={-4,30},     extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGrids.Controls.FreeOffset PmRefPu(use_u = true)  annotation (
    Placement(visible = true, transformation(origin={-36,42},     extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Controls.FreeOffset VrefPu(use_u = true)  annotation (
    Placement(visible = true, transformation(origin={-34,-22},     extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression VrefPuDef(y = 1)  annotation (
    Placement(visible = true, transformation(origin={-68,-22},     extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression PmRefPuDef(y = -GEN.PStart / GEN.PNom) annotation (
    Placement(visible = true, transformation(origin={-64,42},     extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput omega annotation (
    Placement(visible = true, transformation(origin={72,16},    extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {70, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(GEN.terminal, terminal) annotation (
    Line(points={{36,0},{36,-40}}));
  connect(GOV.omegaPu, GEN.omegaPu) annotation (
    Line(points={{-14,26},{-78,26},{-78,64},{84,64},{84,2},{46,2}},                 color = {0, 0, 127}));
  connect(AVR.VcPu, GEN.VPu) annotation (
    Line(points={{-13.8,-4},{-84,-4},{-84,70},{92,70},{92,-6},{46,-6}},               color = {0, 0, 127}));
  connect(AVR.efdPu, GEN.ufPuIn) annotation (
    Line(points={{6.2,-10},{12,-10},{12,-4},{26,-4}},                        color = {0, 0, 127}));
  connect(GOV.PMechPu, GEN.PmPu) annotation (
    Line(points={{6,30},{16,30},{16,4},{26,4}},                         color = {0, 0, 127}));
  connect(PmRefPu.y, GOV.PmRefPu) annotation (
    Line(points={{-25,42},{-24,42},{-24,34},{-14,34}},                     color = {0, 0, 127}));
  connect(VrefPu.y, AVR.VrefPu) annotation (
    Line(points={{-23,-22},{-24,-22},{-24,-16},{-13.8,-16}},                    color = {0, 0, 127}));
  connect(VrefPuDef.y, VrefPu.u) annotation (
    Line(points={{-57,-22},{-45,-22}},                                  color = {0, 0, 127}));
  connect(GEN.PPu, GOV.PPu) annotation (
    Line(points={{46,-2},{88,-2},{88,66},{-82,66},{-82,16},{2,16},{2,20}},                       color = {0, 0, 127}));
  connect(PmRefPuDef.y, PmRefPu.u) annotation (
    Line(points={{-53,42},{-47,42}},        color = {0, 0, 127}));
  connect(GEN.omega, omega) annotation (
    Line(points={{46.1,5.9},{54,5.9},{54,16},{72,16}},               color = {0, 0, 127}));
  annotation (
    Icon(coordinateSystem(grid = {0.1, 0.1}, initialScale = 0.1), graphics={  Text(origin = {12, -74}, extent = {{-58, 10}, {34, -4}}, textString = "CONTROL"), Rectangle(origin = {0, -70}, extent = {{-50, 10}, {50, -10}})}),
    Diagram(coordinateSystem(extent={{-100,-60},{100,80}})));
end ControlledGeneratorIEEE;
