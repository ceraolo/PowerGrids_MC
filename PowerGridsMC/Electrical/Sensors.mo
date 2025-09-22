within PowerGridsMC.Electrical;
package Sensors "Voltage transducer models"
  extends Modelica.Icons.Package;
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
      Icon( graphics={  Rectangle(lineColor = {0, 0, 127}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Text(origin = {-4, 119}, lineColor = {0, 0, 255}, extent = {{-48, 11}, {48, -11}}, textString = "%name"), Text(origin = {0, 26}, extent = {{-56, 36}, {56, -36}}, textString = "Vt It"), Text(origin = {-3, -25}, extent = {{-79, 59}, {87, -51}}, textString = "Transducer")}),
      Diagram(coordinateSystem(extent={{-120,-80},{120,80}})),
    Documentation(info = "<html><head></head><body>This model implements a terminal voltage transducer according to the IEEE Std 421.5TM-2005.<div><br></div><div>It includes a load compensator and a time constant, which is common for the combined voltage sensing and compensation signal.</div></body></html>"));
  end TerminalVoltageTransducerIEEE;

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
      Icon(coordinateSystem(initialScale = 0.1), graphics={  Rectangle(lineColor = {0, 0, 127}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Text(origin={-1.65,
                123.25},                                                                                                                                                                                                        lineColor = {0, 0, 255}, extent={{-99.95,
                13.75},{99.95,-13.75}},                                                                                                                                                                                                        textString = "%name"), Text(origin = {0, 6}, extent = {{-56, 36}, {56, -36}}, textString = "Vt It"), Text(origin = {-11, -23}, extent = {{-65, 1}, {87, -51}}, textString = "Transducer"), Text(origin = {-1, 79}, extent = {{-65, 1}, {57, -39}}, textString = "Exciter")}),
      Diagram(coordinateSystem(extent={{-160,-60},{160,60}})),
    Documentation(info = "<html><head></head><body><span style=\"font-size: 12px;\">This class implements a model of the voltage transducer tipically used in static excitation systems,&nbsp;</span><span style=\"font-size: 12px;\">according to the IEEE Std 421.5TM-2005.</span><div><br></div><div>More precisely, said transducer is included in the exciters models of Type ST3A and ST4B of the IEEE Std 421.5TM-2005.</div></body></html>"));
  end ExciterVoltageTransducerIEEE;

  model UIsensorC "Measures complex voltage and current"
    extends PowerGridsMC.Electrical.BaseClasses.TwoPortAC;
    Modelica.ComplexBlocks.Interfaces.ComplexOutput u annotation (Placement(
          transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={-40,-50}), iconTransformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={-40,-50})));
    Modelica.ComplexBlocks.Interfaces.ComplexOutput i annotation (Placement(
          transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={40,-50}), iconTransformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={40,-50})));
  equation
    portA.v=portB.v;
    portA.i+portB.i=Complex(0);
    u=portA.u;
    i=portA.i;

      annotation (Line(points={{-40,-50},{-40,-50}}, color={85,170,255}),
                Icon(graphics = {Line(points = {{-92, 0}, {96, 0}}, color = {28, 108, 200}), Ellipse(extent = {{-50, 50}, {50, -50}}, lineColor = {28, 108, 200}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Text(extent = {{-48, 14}, {44, -20}}, textColor = {28, 108, 200}, textString = "UI"), Text(extent = {{-100, 90}, {100, 56}}, textColor = {0, 0, 255}, textString = "%name")}),
  Diagram(coordinateSystem(extent={{-100,-60},{100,60}})));
  end UIsensorC;

  model UIsensorR "Measures complex voltage and current as real arrays"
    extends PowerGridsMC.Electrical.BaseClasses.TwoPortAC;
    Modelica.Blocks.Interfaces.RealOutput u[2] annotation (Placement(
          transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={-40,-50}), iconTransformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={-40,-50})));
    Modelica.Blocks.Interfaces.RealOutput i[2] annotation (Placement(
          transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={40,-50}), iconTransformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={40,-50})));
  equation
    portA.v=portB.v;
    portA.i+portB.i=Complex(0);
    u[1]=portA.u.re;
    u[2]=portA.u.im;
    i[1]=portA.i.re;
    i[2]=portA.i.im;
      annotation (Line(points={{-40,-50},{-40,-50}}, color={85,170,255}),
                Icon(graphics = {Line(points = {{-92, 0}, {96, 0}}, color = {28, 108, 200}), Ellipse(extent = {{-50, 50}, {50, -50}}, lineColor={0,0,0},          fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Text(extent = {{-48, 14}, {44, -20}}, textColor={0,0,0},
            textString="UI"),                                                                                                                                                                                                        Text(extent = {{-100, 90}, {100, 56}}, textColor = {0, 0, 255}, textString = "%name")}),
  Diagram(coordinateSystem(extent={{-100,-60},{100,60}})));
  end UIsensorR;

  model MultisensorR
    "Measures complex voltage and current as real arrays, and voltage phase"
    parameter Boolean usePU=false;
    final parameter Real INom=SNom/(sqrt(3)*UNomA);
    extends PowerGridsMC.Electrical.BaseClasses.TwoPortAC;
    Modelica.Blocks.Interfaces.RealOutput u[2] annotation (Placement(
          transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={-40,-50}), iconTransformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={-40,-50})));
    Modelica.Blocks.Interfaces.RealOutput i[2] annotation (Placement(
          transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={40,-50}), iconTransformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={40,-50})));
    Modelica.Blocks.Interfaces.RealOutput uPhase annotation (Placement(
          transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={0,-60}),  iconTransformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={0,-60})));
  equation
    portA.v=portB.v;
    portA.i+portB.i=Complex(0);
    if usePU then
      u[1]=portA.u.re/UNomA;
      u[2]=portA.u.im/UNomA;
      i[1]=portA.i.re/INom;
      i[2]=portA.i.im/INom;
    else
      u[1]=portA.u.re;
      u[2]=portA.u.im;
      i[1]=portA.i.re;
      i[2]=portA.i.im;
    end if;
    uPhase=portA.UPhase;
      annotation (Line(points={{-40,-50},{-40,-50}}, color={85,170,255}),
                Icon(graphics = {Line(points = {{-92, 0}, {96, 0}}, color = {28, 108, 200}), Ellipse(extent = {{-50, 50}, {50, -50}}, lineColor={0,0,0},          fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Text(extent = {{-48, 14}, {44, -20}}, textColor={0,0,0},
            textString="UI"),                                                                                                                                                                                                        Text(extent = {{-100, 90}, {100, 56}}, textColor = {0, 0, 255}, textString = "%name")}),
  Diagram(coordinateSystem(extent={{-100,-60},{100,60}})));
  end MultisensorR;
  annotation (
    Icon(coordinateSystem(grid = {0.1, 0.1})),
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})));
end Sensors;
