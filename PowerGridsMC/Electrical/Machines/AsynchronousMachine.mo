within PowerGridsMC.Electrical.Machines;
model AsynchronousMachine "With dynamic equations from Fitzgerald-Ceraolo"
  import Modelica.Constants.pi;
  extends PowerGridsMC.Electrical.BaseClasses.OnePortAC3;
  //The component nead special  initialization. Therefore we add specific parameters:
  parameter Boolean startSteadyState = false "If true start with zero derivatives; otherwise zero currents." annotation(
    Dialog(tab = "Initialization"),
    choices(checkBox = true));
  outer PowerGridsMC.Electrical.System systemPowerGrids;
  import Modelica.ComplexMath.*;
  parameter Boolean useFluxDerivatives = true;
  parameter Integer pp = 2 "pole pairs";
  parameter Modelica.Units.SI.Resistance Rs = 0.435 "stator's phase resistance";
  parameter Modelica.Units.SI.Inductance L1 = 4.0e-3 "stator's leakage inductance";
  parameter Modelica.Units.SI.Inductance M = 69.3e-3 "stator's leakage inductance";
  parameter Modelica.Units.SI.Resistance Rr = 0.4 "rotor's phase resistance";
  parameter Modelica.Units.SI.Inductance L2 = 2.0e-3 "rotor's leakage inductance";
  parameter Modelica.Units.SI.AngularFrequency wNom = 2*pi*50 "Nominal angular speed";
  parameter Modelica.Units.SI.MomentOfInertia J = 2.0 "rotor's moment of inertia";
  final parameter Real Ls = L1 + M, Lr = L2 + M;
  Modelica.Units.SI.Torque tauElectrical, tauElec;
  /* inertia.w è una variabile di stato. Modelica riconosce le variabili di stato 
        e automaticamente mette a maschera la possibilità di sceglierne il valore iniziale.
        Con il seguente assegnamento, anche wMechanical è riconosciuta come variabile 
        di stato, e questo, oltre a dare un nome diretto alla variabile, consente di 
        avere automaticamente a maschera il suo valore iniziale.*/
  Modelica.Units.SI.AngularVelocity wMechanical = inertia.w "Mechanical speed" annotation(
    Dialog(tab = "Initialization", showStartAttribute = true, enable = startSteadyState));
  Modelica.Units.SI.AngularFrequency W0 "Synchronous mechanical speed";
  Modelica.Units.SI.AngularFrequency w0 = W0*pp "Synchronous electrical speed";
  Real s "slip";
  Modelica.Units.SI.ComplexCurrent i_s, i_r;
  Modelica.Units.SI.ComplexVoltage v_s, v_m;
  Modelica.Units.SI.ComplexPower S = 3*v_s*Modelica.ComplexMath.conj(i_s);
  Modelica.Units.SI.ComplexMagneticFlux lambdaS, lambdaR;
  Modelica.Mechanics.Rotational.Sources.Torque torque annotation(
    Placement(transformation(origin = {-46, 0}, extent = {{16, -10}, {36, 10}})));
  Modelica.Blocks.Sources.RealExpression tauGen(y = tauElec) annotation(
    Placement(transformation(origin = {-46.2667, 0}, extent = {{-27.7333, -12}, {-1.73333, 12}})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia(J = J) annotation(
    Placement(transformation(origin = {-46, 0}, extent = {{44, -10}, {64, 10}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange annotation(
    Placement(transformation(origin = {-46, 0}, extent = {{70, -10}, {90, 10}}), iconTransformation(extent = {{90, -10}, {110, 10}})));
  parameter Real fluxDerFactor(fixed = false);
initial equation
  if useFluxDerivatives then
    fluxDerFactor = 1;
  else
    fluxDerFactor = 0.001;
  end if;
  if startSteadyState then
    der(lambdaS.re)=0;
    der(lambdaS.im)=0;
    der(lambdaR.re)=0;
    der(lambdaR.im)=0;
  else
    i_s.re=0;
    i_s.im=0;
    i_r.re=0;
    i_r.im=0;
  end if;
equation
  W0 = (systemPowerGrids.omegaRef + der(port.UPhase))/pp;
  s = (W0 - inertia.w)/W0;
  /* The following four complex equations, along with an external constitutive equation, 
     allow determining the five variables 
     v_s, i_s, i_r, lambdaS, lambdaR
     Note: because of the use of der() operator, the first two equations 
     are split into their real components.
      On-line comments show the correspondence with power system's equations. 
      The main difference there is that PS uses vectors instead of complexes.
      E.g. i[1] corresponds to i_s.re and i[2] to i_s.im.
  */
  //The following four equations are eqs in rows 713-716 of PS's AsynchronBase
  //when omega[2]=omega and n_r=1 (v_rd=v_rq=0 by PS's in rows 688-689)
  v_s.re = Rs*i_s.re + fluxDerFactor*der(lambdaS.re) - w0*lambdaS.im;
  //Stator's faraday-real
  v_s.im = Rs*i_s.im + fluxDerFactor*der(lambdaS.im) + w0*lambdaS.re;
  //Stator's faraday-imaginary
  0 = Rr*i_r.re + fluxDerFactor*der(lambdaR.re) - w0*s*lambdaR.im;
  //Rotor's faraday-real
  0 = Rr*i_r.im + fluxDerFactor*der(lambdaR.im) + w0*s*lambdaR.re;
  //Rotor's faraday.imaginary
  lambdaS = Ls*i_s + M*i_r;
  //Eq in row 708 in PS's AsynchronBase
  lambdaR = Lr*i_r + M*i_s;
  //Eqs in rows 709-710 in PS's AsynchronBase
  port.v = v_s;
  port.i = i_s;
  //v_m (only for monitoring):
  v_m.re = M*der(i_s.re + i_r.re);
  v_m.im = M*der(i_s.im + i_r.im);
  //
  //electrical torque
  tauElectrical = -3*pp*(lambdaS.im*i_s.re - lambdaS.re*i_s.im);
  tauElec = tauElectrical;
  connect(tauGen.y, torque.tau) annotation(
    Line(points={{-46.7,0},{-32,0}},      color = {0, 0, 127}));
  connect(inertia.flange_b, flange) annotation(
    Line(points = {{18, 0}, {34, 0}}));
  connect(torque.flange, inertia.flange_a) annotation(
    Line(points = {{-10, 0}, {-2, 0}}));
  annotation(
    Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -20}, {40, 20}})),
    Icon(coordinateSystem(preserveAspectRatio = true, grid = {2, 2}), graphics = {Text(textColor = {0, 0, 255}, extent = {{-120, 150}, {120, 112}}, textString = "%name"), Rectangle(lineColor = {28, 108, 200}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Line(points = {{-108, 0}, {-58, 0}}, color = {28, 108, 200}), Rectangle(fillColor = {95, 95, 95}, fillPattern = FillPattern.HorizontalCylinder, extent = {{62, 10}, {102, -10}}), Rectangle(fillColor = {175, 175, 175}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-70, 60}, {76, -54}}), Polygon(fillPattern = FillPattern.Solid, points = {{-60, -84}, {-50, -84}, {-20, -14}, {30, -14}, {60, -84}, {70, -84}, {70, -94}, {-60, -94}, {-60, -84}}), Text(origin = {3, 10.9231}, textColor = {255, 255, 255}, extent = {{-71, 43.0769}, {71, 3.07689}}, textString = "Park IM")}),
    Documentation(info="<html>
<p>This model models a asynchronous machines based on Park&apos;s equations written in a reference frame rotating at the synchronous speed.</p>
<p>The equations contain the transformer terms (derivatives of flux), which determine oscillating torques, during severe transients, such as startup from a constant-frequency grid. They can be nearly totally omitted selecting &quot;useTransformerTerms=false&quot;.</p>
<p>Note that a very small contribution of transformer terms is still present since the implementation of &quot;useTransformerTerms=false&quot; is made using one thousandth of the transformer terms in the equations, This trick is due to difficulties in initialisation while omitting these terms totally from the used equations.</p>
<h4>Initialization</h4>
<p>Currently initialisation can be made settin either </p>
<p>1. all currents to zero or </p>
<p>2. all derivativves of fluxes to zero.</p>
<p>Solution 1 is adequate to simulate machine startups from standstill as per the example StartElecPg_MSL</p>
<p>Solution 2 is adequate to simulate simulations in steady state, without current, fluz and torque oscillations, machine startups from standstill as per the example StartPg_MSL_QS, PG_SS</p>
<h4>Problematiche di inizializzazione</h4>
<p>La maschera del modello contiene delle opzioni di inizializzazione. Al momento la situazione &egrave; embrrionale per due ragioni:</p>
<p>- la maschera propone UStart, UPhaseStart, Pstart e Qstart che sono quelli del terminal di PowerGrids e non si sa che fine fanno</p>
<p>- manca del tutto un&apos;opzione adatta alll&apos;inizializzazione assieme al pPower flow.</p>
</html>"));
end AsynchronousMachine;
