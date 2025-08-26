within PowerGridsMC.Electrical.VoltageTransducers;
model TerminalVoltageTransducerIEEE "Terminal voltage transducer IEEE"
  parameter Modelica.Units.SI.Time Tr=0 "Transducer time constant";
  parameter Modelica.Units.SI.PerUnit Rc=0 "Load compensation resistance";
  parameter Modelica.Units.SI.PerUnit Xc=0 "Load compensation reactance";
  parameter Modelica.Blocks.Types.Init initType=Modelica.Blocks.Types.Init.NoInit "Type of initialization (1: no init, 2: steady state, 3/4: initial output)" annotation(Evaluate=true,
      Dialog(group="Initialization"));
  parameter Real yStart=0 "Initial or guess value of output (= state)" annotation (
  Dialog(group="Initialization"));
  Modelica.ComplexBlocks.Interfaces.ComplexInput Vt annotation (
    Placement(visible = true, transformation(origin={-128,70},    extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.ComplexBlocks.Interfaces.ComplexInput It annotation (
    Placement(visible = true, transformation(origin={-128,30},    extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Vc annotation (
    Placement(visible = true, transformation(origin={120,-10},   extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.ComplexBlocks.ComplexMath.RealToComplex constZc annotation (
    Placement(visible = true, transformation(origin={-68,-10},     extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant constRc(k = Rc)  annotation (
    Placement(visible = true, transformation(origin={-108,-4},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant constXc(k = Xc)  annotation (
    Placement(visible = true, transformation(origin={-108,-36},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.ComplexBlocks.ComplexMath.Add add1 annotation (
    Placement(visible = true, transformation(origin={12,-10},     extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.ComplexBlocks.ComplexMath.Product prod1 annotation (
    Placement(visible = true, transformation(origin={-28,-10},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.ComplexBlocks.ComplexMath.ComplexToPolar complexToPolar annotation (
    Placement(visible = true, transformation(origin={48,-10},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(T = Tr, initType = initType, y_start = yStart)  annotation (
    Placement(visible = true, transformation(origin={88,-10},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(firstOrder.y, Vc) annotation (
    Line(points={{99,-10},{120,-10}},                           color = {0, 0, 127}));
  connect(complexToPolar.len, firstOrder.u) annotation (
    Line(points={{60,-4},{68,-4},{68,-10},{76,-10}},                     color = {0, 0, 127}));
  connect(add1.y, complexToPolar.u) annotation (
    Line(points={{23,-10},{36,-10}},                             color = {85, 170, 255}));
  connect(Vt, add1.u1) annotation (
    Line(points={{-128,70},{-10,70},{-10,-4},{0,-4}},                       color = {85, 170, 255}));
  connect(prod1.y, add1.u2) annotation (
    Line(points={{-17,-10},{-10,-10},{-10,-16},{0,-16}},                        color = {85, 170, 255}));
  connect(It, prod1.u1) annotation (
    Line(points={{-128,30},{-48,30},{-48,-4},{-40,-4}},                     color = {85, 170, 255}));
  connect(constZc.y, prod1.u2) annotation (
    Line(points={{-57,-10},{-52,-10},{-52,-16},{-40,-16}},                      color = {85, 170, 255}));
  connect(constXc.y, constZc.im) annotation (
    Line(points={{-97,-36},{-90,-36},{-90,-16},{-80,-16}},                           color = {0, 0, 127}));
  connect(constRc.y, constZc.re) annotation (
    Line(points={{-97,-4},{-80,-4}},                                color = {0, 0, 127}));
  annotation (
    Icon(coordinateSystem(grid = {0.1, 0.1}), graphics={  Rectangle(lineColor = {0, 0, 127}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Text(origin = {-4, 119}, lineColor = {0, 0, 255}, extent = {{-48, 11}, {48, -11}}, textString = "%name"), Text(origin = {0, 26}, extent = {{-56, 36}, {56, -36}}, textString = "Vt It"), Text(origin = {-3, -25}, extent = {{-79, 59}, {87, -51}}, textString = "Transducer")}),
    Diagram(coordinateSystem(extent={{-120,-80},{120,80}})),
  Documentation(info = "<html><head></head><body>This model implements a terminal voltage transducer according to the IEEE Std 421.5TM-2005.<div><br></div><div>It includes a load compensator and a time constant, which is common for the combined voltage sensing and compensation signal.</div></body></html>"));
end TerminalVoltageTransducerIEEE;
