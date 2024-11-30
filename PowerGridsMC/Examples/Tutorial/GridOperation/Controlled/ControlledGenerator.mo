within PowerGridsMC.Examples.Tutorial.GridOperation.Controlled;
model ControlledGenerator "Model of a synchronous generator with governor, AVR, and PSS"
  extends Icons.Machine;
  PowerGridsMC.Electrical.Machines.SynchronousMachine4Windings GEN(H = 4, PStart = -4.75e+08, QStart = -1.56e+08,SNom = 5e+08, Tpd0 = 5.143, Tppd0 = 0.042, Tppq0 = 0.083, Tpq0 = 2.16, UNom = 21000, UPhaseStart = 0.161156, UStart = 21e3 * 0.9917, portVariablesPhases = true, raPu = 0, xdPu = 2, xlPu = 0.15, xpdPu = 0.35, xppdPu = 0.25, xppqPu = 0.3, xpqPu = 0.5, xqPu = 1.8)  annotation (
    Placement(visible = true, transformation(origin={34,0},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGridsMC.Electrical.Controls.TurbineGovernors.IEEE_TGOV1 TGOV(PMechPuStart = -GEN.PStart / GEN.SNom,R = 0.05, T1 = 0.5, T2 = 3, T3 = 10, VMax = 1)  annotation (
    Placement(visible = true, transformation(origin={-2,28},   extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  PowerGridsMC.Electrical.Controls.ExcitationSystems.IEEE_AC4A AVR(Ka = 200, Ta = 0.05, Tb = 10, Tc = 3, VcPuStart = GEN.UStart / GEN.UNom, VrMax = 4)  annotation (
    Placement(visible = true, transformation(origin={-2,-16},   extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression zero annotation (
    Placement(visible = true, transformation(origin={-42,-52},    extent = {{-12, -10}, {12, 10}}, rotation = 0)));
  PowerGridsMC.Electrical.Controls.PowerSystemStabilizers.IEEE_PSS2A PSS(Ks1 = 10, Ks2 = 0.1564, M = 0, N = 0, T1 = 0.25, T2 = 0.03, T3 = 0.15, T4 = 0.015, T7 = 2, T8 = 0.5, T9 = 0.1, Tw1 = 2, Tw2 = 2, Tw3 = 2, Tw4 = 0, VstMax = 0.1, VstMin = -0.1)  annotation (
    Placement(visible = true, transformation(origin={-38,0},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGridsMC.Interfaces.TerminalAC terminal annotation (
    Placement(visible = true, transformation(origin={34,30},     extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGridsMC.Controls.FreeOffset RefLPu annotation (
    Placement(visible = true, transformation(origin={-38,24},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGridsMC.Controls.FreeOffset VrefPu annotation (
    Placement(visible = true, transformation(origin={-40,-30},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput omega "Angular frequency / (rad/s)" annotation (
    Placement(visible = true, transformation(origin={58,12},    extent = {{-6, -6}, {6, 6}}, rotation = 0), iconTransformation(origin = {70, 1.77636e-15}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(GEN.ufPuIn, AVR.efdPu) annotation (
    Line(points={{23.6,-4},{16,-4},{16,-16},{9,-16}},         color = {0, 0, 127}));
  connect(TGOV.PMechPu, GEN.PmPu) annotation (
    Line(points={{8,28},{16,28},{16,3.4},{23.6,3.4}},     color = {0, 0, 127}));
  connect(GEN.VPu, AVR.VcPu) annotation (
    Line(points={{44.2,-6},{74,-6},{74,54},{-70,54},{-70,-14},{-12,-14}},           color = {0, 0, 127}));
  connect(PSS.VstPu, AVR.VsPu) annotation (
    Line(points={{-27,0},{-20,0},{-20,-10},{-12,-10}},         color = {0, 0, 127}));
  connect(PSS.Vsi2Pu, GEN.PPu) annotation (
    Line(points={{-48.2,-6},{-64,-6},{-64,48},{70,48},{70,-2},{44.2,-2}},          color = {0, 0, 127}));
  connect(GEN.terminal, terminal) annotation (
    Line(points={{34,0},{34,30}}));
  connect(RefLPu.y, TGOV.RefLPu) annotation (
    Line(points={{-27,24},{-12,24}},     color = {0, 0, 127}));
  connect(VrefPu.y, AVR.VrefPu) annotation (
    Line(points={{-29,-30},{-24,-30},{-24,-18},{-12,-18}},         color = {0, 0, 127}));
  connect(GEN.omegaPu, TGOV.omegaPu) annotation (
    Line(points={{44.2,2},{66,2},{66,44},{-20,44},{-20,32},{-12,32}},           color = {0, 0, 127}));
  connect(AVR.VuelPu, zero.y) annotation (
    Line(points={{-12,-22},{-18,-22},{-18,-52},{-28.8,-52}},                   color = {0, 0, 127}));
  connect(GEN.omegaPu, PSS.Vsi1Pu) annotation (
    Line(points={{44.2,2},{66,2},{66,44},{-58,44},{-58,6},{-48,6}},                      color = {0, 0, 127}));
  connect(GEN.omega, omega) annotation (
    Line(points={{44.3,5.9},{48,5.9},{48,12},{58,12}},              color = {0, 0, 127}));
  annotation (
    Icon(coordinateSystem(grid={2,2}), graphics={
        Line(points={{-73.9,-28},{-35.1,-28.3}}, color={28,108,200}),
        Polygon(
          points={{-44.2,-24.2},{-44.2,-32.1},{-35.1,-28.6},{-44.2,-24.2}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Line(points={{-73,-65.7},{-37.1,-65.7},{-36.8,-64.9}}, color={28,108,200}),
        Polygon(
          points={{-46.2,-61.1},{-46.2,-69},{-36.8,-65.5},{-46.2,-61.1}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid)}),
    Diagram(coordinateSystem(grid={2,2},        extent={{-80,-80},{80,80}})));
end ControlledGenerator;
