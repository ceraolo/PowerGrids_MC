within PowerGridsMC.Electrical.Controls.ExcitationSystems;
block IEEE_AC4A "Static excitation system - IEEE type AC4A"
  extends Controls.BaseClasses.BaseControllerFramework;

  parameter SI.PerUnit ViMax = 100 "Input voltage max limit in p.u.";
  parameter SI.PerUnit ViMin = -100 "Input voltage min limit in p.u.";
  parameter SI.Time Tc = 3 "Lead time constant";
  parameter SI.Time Tb = 10 "Lag delay time constant";
  parameter SI.PerUnit Ka(min = 0) = 200 "Overall equivalent gain";
  parameter SI.Time Ta = 0.05 "Overall time constant";
  parameter SI.PerUnit VrMax = 4 "Output voltage max limit in p.u.";
  parameter SI.PerUnit VrMin = 0 "Output voltage min limit in p.u.";
  parameter SI.PerUnit VcPuStart = 1 "Required start value of VcPu when fixInitialControlledVariable = true" annotation(Dialog(enable = fixInitialControlledVariable));
  parameter SI.PerUnit oversaturationPu = 0.1 "abs(u-usat)/(Vmax-Vmin) in case of saturated initial condition" annotation(Dialog(enable = fixInitialControlledVariable));
  final parameter Real delta = (inputLimiter.uMax-inputLimiter.uMin)*oversaturationPu "Actuator saturation margin";

  Modelica.Blocks.Interfaces.RealInput VsPu "PSS output p.u" annotation (
    Placement(visible = true, transformation(origin={-128,30},    extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput VcPu "Machine terminal voltage p.u." annotation (
    Placement(visible = true, transformation(origin={-128,0},    extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput VrefPu "Voltage reference p.u." annotation (
    Placement(visible = true, transformation(origin={-128,-30},    extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput VuelPu "Underexcitation limit p.u." annotation (
    Placement(visible = true, transformation(origin={4,-40},     extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput efdPu "Exciter output voltage p.u." annotation (
    Placement(visible = true, transformation(origin={110,0},    extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin={110,0},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add3 addIng(k1 = +1, k2 = -1, k3 = +1)  annotation (
    Placement(visible = true, transformation(origin={-68,0},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter inputLimiter(uMax=ViMax, uMin=ViMin)
    annotation (Placement(visible=true, transformation(
        origin={-28,0},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  PowerGridsMC.Controls.LeadLag leadLag(T1 = Tc, T2 = Tb, initType = Modelica.Blocks.Types.Init.SteadyState, k = 1, yStart = 1 / Ka)  annotation (
    Placement(visible = true, transformation(                 extent={{2,-10},{22,
            10}},                                                                              rotation = 0)));
  PowerGridsMC.Controls.FirstOrderWithNonWindupLimiter firstOrderLim(T = Ta, initType = Modelica.Blocks.Types.Init.SteadyState, k = Ka, yMax = VrMax, yMin = VrMin, yStart = 1)  annotation (
    Placement(visible = true, transformation(origin={92,0},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.VariableLimiter variableLimiter annotation (
    Placement(visible = true, transformation(origin={54,0},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant largeReal(k = 1e9)  annotation (
    Placement(visible = true, transformation(origin={12,40},   extent = {{-10, -10}, {10, 10}}, rotation = 0)));
initial equation
  /* The following equation could be written as
 
     if fixInitialControlledVariable then
       if inputLimiter.u > inputLimiter.uMax or firstOrderLim.u > firstOrderLim.yMax/Ka then
         inputLimiter.u = inputLimiter.uMax + delta;
       elseif inputLimiter.u < inputLimiter.uMin or firstOrderLim.u < firstOrderLim.yMin/Ka then
         inputLimiter.u = inputLimiter.uMin - delta;
       else
         VcPu = VcPuStart;
       end if;
     end if;
      
     However, we need to use homotopy with a simplified linear model, to
     avoid the need of explicitly initializing all the internal controller
     variables. This is only possible by writing those equations in implicit form
  */
  if fixInitialControlledVariable then
    0 = homotopy(
      actual = if inputLimiter.u > inputLimiter.uMax then inputLimiter.u - (inputLimiter.uMax + delta)
               else if inputLimiter.u < inputLimiter.uMin then inputLimiter.u - (inputLimiter.uMin - delta)
               else VcPu - VcPuStart,
      simplified = VcPu - VcPuStart);
  end if;
equation
  connect(firstOrderLim.y, efdPu) annotation (
    Line(points={{103,0},{110,0}},                         color = {0, 0, 127}));
  connect(inputLimiter.y, leadLag.u) annotation (
    Line(points={{-17,0},{0,0}},                            color = {0, 0, 127}));
  connect(addIng.y, inputLimiter.u) annotation (
    Line(points={{-57,0},{-40,0}},                          color = {0, 0, 127}));
  connect(VrefPu, addIng.u3) annotation (
    Line(points={{-128,-30},{-96,-30},{-96,-8},{-80,-8}},                       color = {0, 0, 127}));
  connect(VsPu, addIng.u1) annotation (
    Line(points={{-128,30},{-96,30},{-96,8},{-80,8}},                      color = {0, 0, 127}));
  connect(VcPu, addIng.u2) annotation (
    Line(points={{-128,0},{-80,0}},                          color = {0, 0, 127}));
  connect(variableLimiter.y, firstOrderLim.u) annotation (
    Line(points={{65,0},{80,0}},      color = {0, 0, 127}));
  connect(leadLag.y, variableLimiter.u) annotation (
    Line(points={{23,0},{42,0}},      color = {0, 0, 127}));
  connect(largeReal.y, variableLimiter.limit1) annotation (
    Line(points={{23,40},{32,40},{32,8},{42,8}},          color = {0, 0, 127}));
  connect(VuelPu, variableLimiter.limit2) annotation (
    Line(points={{4,-40},{34,-40},{34,-8},{42,-8}},           color = {0, 0, 127}));
  annotation (
    Icon( graphics={  Rectangle(origin={0.5,0.7},extent = {{-100, 99}, {100, -101}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),                                             Text(origin = {24, 4}, extent = {{-94, 70}, {56, -72}}, textString = "IEEE
AC4A"), Text(origin = {0, 120}, lineColor = {0, 0, 255}, extent = {{-80, 14}, {80, -14}}, textString = "%name")}),
    Diagram(coordinateSystem(extent={{-120,-80},{120,80}})),
  Documentation(info = "<html>
<p>The class implements a model of a static exictation system according to the IEEE Std 421.5TM-2005.</p>
<p>The type implemented is the AC4A, described in the chapter 6.4 of the same IEEE Std 421.5TM-2005.</p>
<p>Unlike the aforementioned standard, the output voltage ceiling limitation is fixed to VrMax, while in the standard it depends to the field current IFd.</p>
<p>If <code>fixInitialControlledVariable = true</code>, an initial equation is added to ensure that the machine voltage <code>VcPu</code> is equal to its start value <code>VcPuStart</code>. In order to fulfill this condition, the initial value of the reference signal should be free, so that the Modelica tool can back-compute it automatically. For this purpose, the <a href=\"modelica://PowerGridsMC.Controls.FreeOffset\">PowerGridsMC.Controls.FreeOffset</a> block should be used to generate the reference signal to be connected to the <code>VrefPu</code> input.</p>
<p>In case the condition <code>VcPu = VcPuStart</code> cannot be fulfilled without violating the controller saturations, then an alternative initial condition is enforced, which prescribes the saturation block input so as to obtain a certain degree of oversaturation <code>oversaturationPu</code>. This allows to back-compute a unique initial value of the reference signal, which is of course dependent on <code>oversaturationPu</code> and hence somewhat arbitrary.</p>
</html>"));
end IEEE_AC4A;
