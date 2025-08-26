within PowerGridsMC.Electrical.VoltageTransducers;
model ExciterVoltageTransducerIEEE "Exciter voltage transducer"
  parameter SI.PerUnit kp = 9.3
                               "First potential circuit gain";
  parameter SI.Angle thetap = 0 "Potential circuit phase angle Thetap";
  parameter SI.PerUnit ki = 0 "Second potential circuit gain coefficient";
  parameter SI.PerUnit xl = 0.124 "Reactance associated with potential source";
  Modelica.ComplexBlocks.Interfaces.ComplexInput Vt annotation (
    Placement(visible = true, transformation(origin={-166,50},    extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.ComplexBlocks.Interfaces.ComplexInput It annotation (
    Placement(visible = true, transformation(origin={-166,-50},    extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Ve annotation (
    Placement(visible = true, transformation(origin={164,16},    extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant constKp(k = kp)  annotation (
    Placement(visible = true, transformation(origin={-146,16},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant constThetap(k = thetap)  annotation (
    Placement(visible = true, transformation(origin={-146,-16},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.ComplexBlocks.ComplexMath.Add add1 annotation (
    Placement(visible = true, transformation(origin={-26,10},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.ComplexBlocks.ComplexMath.ComplexToPolar complexToPolar annotation (
    Placement(visible = true, transformation(origin={130,10},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.ComplexBlocks.ComplexMath.PolarToComplex complexKp annotation (
    Placement(visible = true, transformation(origin={-106,10},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.ComplexBlocks.ComplexMath.Gain gainXl(k(
                                                 re   = 0, im   = xl))
                                                                      annotation (
    Placement(visible = true, transformation(origin={-66,10},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.ComplexBlocks.ComplexMath.Gain J(k(
                                            re   = 0, im   = 1))
                                                                annotation (
    Placement(visible = true, transformation(origin={14,10},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.ComplexBlocks.ComplexMath.Product prod1 annotation (
    Placement(visible = true, transformation(origin={54,10},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.ComplexBlocks.ComplexMath.Add add2 annotation (
    Placement(visible = true, transformation(origin={94,10},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.ComplexBlocks.ComplexMath.Product prod2 annotation (
    Placement(visible = true, transformation(origin={-66,44},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.ComplexBlocks.Sources.ComplexConstant constKi(k(
                                                         re   = ki, im   = 0))
                                                                              annotation (
    Placement(visible = true, transformation(origin={-46,-16},    extent = {{-10, -10}, {10, 10}}, rotation = 90)));
equation
  connect(constKi.y, add1.u2) annotation (
    Line(points={{-46,-5},{-46,4},{-38,4}},                             color = {85, 170, 255}));
  connect(Vt, prod2.u1) annotation (
    Line(points={{-166,50},{-78,50}},                            color = {85, 170, 255}));
  connect(complexToPolar.len, Ve) annotation (
    Line(points={{142,16},{164,16}},                            color = {0, 0, 127}));
  connect(add2.y, complexToPolar.u) annotation (
    Line(points={{105,10},{118,10}},                            color = {85, 170, 255}));
  connect(prod1.y, add2.u2) annotation (
    Line(points={{65,10},{74,10},{74,4},{82,4}},                   color = {85, 170, 255}));
  connect(prod2.y, add2.u1) annotation (
    Line(points={{-55,44},{74,44},{74,16},{82,16}},                    color = {85, 170, 255}));
  connect(complexKp.y, prod2.u2) annotation (
    Line(points={{-95,10},{-88,10},{-88,38},{-78,38}},          color = {85, 170, 255}));
  connect(It, prod1.u2) annotation (
    Line(points={{-166,-50},{32,-50},{32,4},{42,4}},                   color = {85, 170, 255}));
  connect(J.y, prod1.u1) annotation (
    Line(points={{25,10},{30,10},{30,16},{42,16}},                    color = {85, 170, 255}));
  connect(add1.y, J.u) annotation (
    Line(points={{-15,10},{2,10}},                           color = {85, 170, 255}));
  connect(gainXl.y, add1.u1) annotation (
    Line(points={{-55,10},{-50,10},{-50,16},{-38,16}},                     color = {85, 170, 255}));
  connect(complexKp.y, gainXl.u) annotation (
    Line(points={{-95,10},{-78,10}},                            color = {85, 170, 255}));
  connect(constThetap.y, complexKp.phi) annotation (
    Line(points={{-135,-16},{-128,-16},{-128,4},{-118,4}},                     color = {0, 0, 127}));
  connect(constKp.y, complexKp.len) annotation (
    Line(points={{-135,16},{-118,16}},                              color = {0, 0, 127}));
  annotation (
    Icon(coordinateSystem(grid = {0.1, 0.1}, initialScale = 0.1), graphics={  Rectangle(lineColor = {0, 0, 127}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Text(origin = {-4, 119}, lineColor = {0, 0, 255}, extent = {{-48, 11}, {48, -11}}, textString = "%name"), Text(origin = {0, 6}, extent = {{-56, 36}, {56, -36}}, textString = "Vt It"), Text(origin = {-11, -23}, extent = {{-65, 1}, {87, -51}}, textString = "Transducer"), Text(origin = {-1, 79}, extent = {{-65, 1}, {57, -39}}, textString = "Exciter")}),
    Diagram(coordinateSystem(extent={{-160,-60},{160,60}})),
  Documentation(info = "<html><head></head><body><span style=\"font-size: 12px;\">This class implements a model of the voltage transducer tipically used in static excitation systems,&nbsp;</span><span style=\"font-size: 12px;\">according to the IEEE Std 421.5TM-2005.</span><div><br></div><div>More precisely, said transducer is included in the exciters models of Type ST3A and ST4B of the IEEE Std 421.5TM-2005.</div></body></html>"));
end ExciterVoltageTransducerIEEE;
