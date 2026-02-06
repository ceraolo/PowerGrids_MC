within PowerGridsMC.Electrical.Test;
model TestExciterVoltageTransducerIEEE
  extends Modelica.Icons.Example;
  Modelica.ComplexBlocks.Sources.ComplexConstant V(k(
                                                   re   = -1, im   = 1))
                                                                        annotation (
    Placement(visible = true, transformation(origin = {-70, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.ComplexBlocks.Sources.ComplexConstant I(k(
                                                   re   = 1, im   = 1))
                                                                       annotation (
    Placement(visible = true, transformation(origin = {-70, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGridsMC.Electrical.Sensors.IEEEExciterVoltageTransducer exciterVoltageTransducer(
    ki=1,
    kp=sqrt(2),
    thetap=0.785398,
    xl=1) annotation (Placement(visible=true, transformation(
        origin={-3.33067e-15,-4.21885e-15},
        extent={{-20,-20},{20,20}},
        rotation=0)));
equation
  connect(I.y, exciterVoltageTransducer.It) annotation (Line(points={{-59,-30},{
          -40,-30},{-40,-12},{-20,-12},{-20,-12}}, color={85,170,255}));
  connect(V.y, exciterVoltageTransducer.Vt) annotation (Line(points={{-59,10},{-18,
          10},{-18,12},{-20,12}}, color={85,170,255}));
  annotation (
    Diagram(coordinateSystem(extent = {{-80, 40}, {20, -60}})),
    experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02),
    __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "dassl"),
  Documentation(info="<html>
<p>This model demonstrates the correct implementation of the IEEE exciter rectifier regulation characteristic.</p>
</html>"));
end TestExciterVoltageTransducerIEEE;
