within PowerGridsMC;
package Icons "Icons for the PowerGridsMC library"
  extends Modelica.Icons.IconsPackage;

  model Bus
    parameter Boolean showPortData=true "=true, if PowerFlow data are to be shown";
    outer Electrical.System systemPowerGrids "Reference to system object";
    parameter Boolean showDataOnDiagramsPu = systemPowerGrids.showDataOnDiagramsPu
     "=true, P,Q,V and phase are shown on the diagrams in per-unit of local machine base";

  equation

  annotation (
      Icon(graphics={  Rectangle(origin = {0, 2}, fillPattern = FillPattern.Solid,
           extent = {{-100, 6}, {100, -10}}), Text(origin={67,34},
           lineColor = {0, 0, 255}, extent={{-65,10},
                {65,-10}},                                                                                                                                                                               textString = "%name"),
      Text(
        visible=showPortData,
        extent={{-168,50},{-30,16}},
        lineColor={28,108,200},
        textString=DynamicSelect("V",
          if showDataOnDiagramsPu then
             String(port.U/port.UNom, format = "6.3f")
          else
             String(port.U/1e3, format = "9.3f"))),
      Text(
        visible=showPortDdata,
        extent={{-162,-8},{-26,-42}},
        lineColor={28,108,200},
        textString=DynamicSelect("Uph", String(port.UPhase*180/3.14159265359, format = "4.1f")+"°"))},                                                                                                                          coordinateSystem(initialScale = 0.1)));
  end Bus;

  model Line
  equation

  annotation (
      Icon(graphics={  Rectangle(origin = {-1, -1}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-59, 11}, {61, -11}}), Line(origin = {-80, 0}, points = {{-20, 0}, {20, 0}}), Line(origin = {80, 0}, points = {{-20, 0}, {20, 0}}), Text(origin = {0, 30}, lineColor = {0, 0, 255}, extent = {{-80, 10}, {80, -10}}, textString = "%name")}, coordinateSystem(initialScale = 0.1)));
  end Line;

  model Transformer
  equation

  annotation (
      Icon(graphics={  Ellipse(origin = {-15, -7}, extent = {{-45, 47}, {35, -33}}, endAngle = 360), Ellipse(origin = {3, -9}, extent = {{57, 49}, {-23, -31}}, endAngle = 360), Line(origin = {-80, 0}, points = {{-20, 0}, {20, 0}, {20, 0}}), Line(origin = {80, 0}, points = {{-20, 0}, {20, 0}}), Text(origin = {0, 61}, lineColor = {0, 0, 255}, extent = {{-80, 11}, {80, -11}}, textString = "%name")}, coordinateSystem(initialScale = 0.1)));
  end Transformer;

  model Load
  equation

  annotation (
      Icon(graphics={  Line(origin = {0, -20}, points = {{0, 20}, {0, -20}, {0, -20}}), Polygon(origin = {0, -70}, fillPattern = FillPattern.Solid, points = {{-40, 30}, {40, 30}, {0, -30}, {-40, 30}}), Text(origin={0,-120},     lineColor = {0, 0, 255}, extent={{-98,10},
                {98,-10}},                                                                                                                                                                                                        textString = "%name")}, coordinateSystem(initialScale = 0.1)));
  end Load;

  model Machine
  annotation (
      Icon(graphics={  Text(origin={0,-121},    textColor = {0, 0, 255}, extent = {{-100, 9}, {100, -9}}, textString = "%name"),
        Rectangle(                  fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent={{-100,80},
                {100,-100}}),
        Ellipse(origin={0,-51},    extent = {{-40, 41}, {40, -40}}),
        Line(origin = {0.00014, -50.5485},points=
          {{-20, 0},
          {-15.375,13.3},
          {-13.8,16.6},
          {-12.35,18.65},
          {-10.95,19.775},
          {-9.8,19.95},
          {-8.15,19.15},
          {-6.725,17.425},
          {-5.325,14.85},
          {-3.725,11.025},
          {-1.7075,5.3},
          {1.7075,-5.3},
          {3.725,-11.025},
          {5.325,-14.85},
          {6.725,-17.425},
          {8.15,-19.15},
          {9.8,-19.95},
          {10.95,-19.775},
          {12.35,-18.65},
          {13.8,-16.6},
          {15.375,-13.3},
          {20,0}}, smooth = Smooth.Bezier)}, coordinateSystem(initialScale = 0.1)));
  end Machine;

  model CapacitorBank
  equation

    annotation (
      Icon(graphics={  Polygon(origin = {0, -70}, fillPattern = FillPattern.Solid, points = {{-40, 30}, {40, 30}, {0, -30}, {-40, 30}}), Rectangle(origin = {0, -14}, fillPattern = FillPattern.Solid, extent = {{-20, 2}, {20, -2}}), Rectangle(origin = {0, -26}, fillPattern = FillPattern.Solid, extent = {{-20, 2}, {20, -2}}), Line(origin = {0, -7}, points = {{0, 7}, {0, -7}}), Line(origin = {0, -34}, points = {{0, 8}, {0, -8}}), Text(origin = {-1, -119}, lineColor = {0, 0, 255}, extent = {{-81, 11}, {81, -11}}, textString = "%name")}, coordinateSystem(initialScale = 0.1)));
  end CapacitorBank;

  model Ground
  equation

    annotation (
      Icon(graphics={  Line(origin = {0, -20}, points = {{0, 20}, {0, -20}, {0, -20}}), Line(origin = {0, -40}, points = {{-40, 0}, {40, 0}, {40, 0}, {40, 0}}), Line(origin = {0, -60}, points = {{-20, 0}, {20, 0}, {20, 0}}), Line(origin = {0, -80}, points = {{-4, 0}, {4, 0}})}, coordinateSystem(initialScale = 0.1)));
  end Ground;

  model Grid
  equation

    annotation (
      Icon(coordinateSystem(initialScale = 0.1), graphics={  Rectangle(origin = {0, -1}, fillColor = {255, 255, 255}, fillPattern = FillPattern.CrossDiag, extent = {{-60, 61}, {60, -59}}), Text(origin = {-1, 80}, lineColor = {0, 0, 255}, extent = {{-81, 12}, {81, -12}}, textString = "%name")}));
  end Grid;
end Icons;
