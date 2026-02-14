within PowerGridsMC.Electrical.Machines;
model AsynchronousMachine2
  "In addition to AsynchrnousMachine allows Steady-state initialization"
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
  parameter Modelica.Units.SI.Inductance Lsl = 4.0e-3 "stator's leakage inductance";
  parameter Modelica.Units.SI.Inductance M = 69.3e-3 "stator's leakage inductance";
  parameter Modelica.Units.SI.Resistance Rr = 0.4 "rotor's phase resistance";
  parameter Modelica.Units.SI.Inductance Lrl = 2.0e-3 "rotor's leakage inductance";
  parameter Modelica.Units.SI.MomentOfInertia J = 2.0 "rotor's moment of inertia";
  final parameter Modelica.Units.SI.Inductance Ls = Lsl + M, Lr = Lrl + M;
  Modelica.Units.SI.Torque tauElectrical, tauElec;
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
  Modelica.Mechanics.Rotational.Components.Inertia inertia(J = J, w(start=
          wStart), phi(start=0, fixed=true))    annotation(
    Placement(transformation(origin = {-46, 0}, extent = {{44, -10}, {64, 10}})));
  Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque tau2(
      tau_nominal=-T2, w_nominal=Wsyn)
    annotation (Placement(transformation(origin={-26,-16},   extent = {{80, -20}, {60, 0}})));
  Modelica.Mechanics.Rotational.Sources.ConstantTorque tau1(tau_constant=-T1)
    annotation (Placement(transformation(origin={-28,62},   extent = {{80, -54}, {60, -34}})));
//  Modelica.Units.SI.Resistance Req "Resistance of the equivalent impedance";
//  Modelica.Units.SI.Reactance Xeq "Reactance of the equivalent impedance";
//  Modelica.Units.SI.ComplexPower S1;
  parameter Modelica.Units.SI.Torque T1=10, T2=20 "Load torque constants";
  final parameter Modelica.Units.SI.AngularVelocity Wsyn=systemPowerGrids.omegaNom/pp "initial synchronous (mechanical) angular velocity";
  final parameter Modelica.Units.SI.AngularVelocity wStart(start=Wsyn, fixed=false);

initial equation
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

// (Req,Xeq,tauElectrical,S1)=Functions.asmaValuesFunOfSpeed(
  (,,tauElectrical) = Functions.asmaValuesFunOfSpeed(
    V=CM.abs(v_s),
    W=wStart,
    pp=pp,
    R1=Rs,
    R2=Rr,
    L1l=Lsl,
    L2l=Lrl,
    Lm=M,
    T1=T1,
    T2=T2,
    Wsyn=Wsyn);
  //wStart is determined iteratively by imposing the equality of the torque generated
  //by the machine and the one absorbed by the mechanical load:
    tauElectrical=T1+T2*(wStart/Wsyn)^2;
  Modelica.Utilities.Streams.print("\ninitial tau: "+String(tauElectrical)+", initial W: "+String(wStart));
  Modelica.Utilities.Streams.print("initial inertia.w: "+String(inertia.w)+"\n");

/*  IMPORTANT USAGE NOTE
    Effectiveness of function asmaVlaluesFunOfSpeed is checked thourouhgly in Functions.Test.FindSteadyState.
    Very strangely, however, there are combinations of T11 and T2 that, using Dymola, cause lack of convergence or convergence with positive angular speeds ONLY IN THIS PgAsma2, AND NOT IN FindSteadyState.
    Indeed, the same function with the same inputs should give rise to the same results.
    Nevertheless, the technique used here and in FindSteadyState, operates very smoothly in OpenModelica, thus offering good initialization.
 */

equation
  W0 = (systemPowerGrids.omegaRef + der(port.UPhase))/pp;
  s = (W0 - inertia.w)/W0;
  /* The following five complex equations, along with an external constitutive equation, 
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
  v_s.re = Rs*i_s.re + der(lambdaS.re) - w0*lambdaS.im;
  //Stator's faraday-real
  v_s.im = Rs*i_s.im + der(lambdaS.im) + w0*lambdaS.re;
  //Stator's faraday-imaginary
  0 = Rr*i_r.re + der(lambdaR.re) - w0*s*lambdaR.im;
  //Rotor's faraday-real
  0 = Rr*i_r.im + der(lambdaR.im) + w0*s*lambdaR.re;
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
  connect(torque.flange, inertia.flange_a) annotation(
    Line(points = {{-10, 0}, {-2, 0}}));
  connect(tau1.flange, inertia.flange_b)
    annotation (Line(points={{32,18},{30,18},{30,0},{18,0}}, color={0,0,0}));
  connect(tau2.flange, inertia.flange_b)
    annotation (Line(points={{34,-26},{30,-26},{30,0},{18,0}}, color={0,0,0}));
  annotation(
    Diagram(coordinateSystem(preserveAspectRatio = true, extent={{-100,-40},{60,
            40}})),
    Icon(coordinateSystem(preserveAspectRatio = true, grid = {2, 2}), graphics = {Text(textColor = {0, 0, 255}, extent = {{-120, 150}, {120, 112}}, textString = "%name"), Rectangle(lineColor = {28, 108, 200}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Line(points = {{-108, 0}, {-58, 0}}, color = {28, 108, 200}),                                                                                                                     Rectangle(fillColor = {175, 175, 175}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-70, 60}, {76, -54}}), Polygon(fillPattern = FillPattern.Solid, points = {{-60, -84}, {-50, -84}, {-20, -14}, {30, -14}, {60, -84}, {70, -84}, {70, -94}, {-60, -94}, {-60, -84}}), Text(origin = {3, 10.9231}, textColor = {255, 255, 255}, extent = {{-71, 43.0769}, {71, 3.07689}}, textString = "Park IM")}),
    Documentation(info="<html>
<p>This is a modification of AsynchronousMachine model.</p>
<p>This allows steady-state initialisation, when the load torque is of the type <span style=\"font-family: Arial;\">A+B*W^2 (actually expressed as T1+T2*(W/Wsyn)^2).</span></p>
<p><span style=\"font-family: Arial;\">It incorporates load torque; its inertia constant J is the aggregate of machine and load inertia.</span></p>
<p>This model does not work on Dymola 2025, but works well with OpenModelica 1.26. Checks made show that this shoulg be a dymola&apos;s problem (See &quot;IMPORTANT USAGE NOTE&quot; in the code)</p>
</html>"),
    experiment(StopTime=0.1, __Dymola_Algorithm="Dassl"));
end AsynchronousMachine2;
