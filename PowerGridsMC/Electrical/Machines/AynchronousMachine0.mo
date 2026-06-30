within PowerGridsMC.Electrical.Machines;

model AynchronousMachine0
  import Modelica.Constants.pi;
  extends Electrical.BaseClasses.OnePortAC3;
  outer Electrical.System systemPowerGrids;
  parameter Integer pp = 2 "Pole pairs";
  parameter Modelica.Units.SI.Resistance Rs = 0.435 "Stator's phase resistance";
  parameter Modelica.Units.SI.Inductance Lsl = 4.0e-3 "Stator's leakage inductance";
  parameter Modelica.Units.SI.Inductance M = 69.3e-3 "Stator's leakage inductance";
  parameter Modelica.Units.SI.Resistance Rr = 0.4 "Rotor's phase resistance";
  parameter Modelica.Units.SI.Inductance Lrl = 2.0e-3 "Rotor's leakage inductance";
  parameter Modelica.Units.SI.AngularFrequency wNom = 2*pi*50 "Nominal angular speed (to compute impedances)";
  final parameter Modelica.Units.SI.Inductance Ls = Lsl + M, Lr = Lrl + M;
  final parameter Modelica.Units.SI.ComplexImpedance Z1 = Complex(Rs, wNom*Lsl), Zm = Complex(0, wNom*M);
  parameter Modelica.Units.SI.MomentOfInertia J = 2.0 "Rotor's moment of inertia";
  Modelica.Units.SI.Torque tauElectrical, tauElec;
  Modelica.Units.SI.AngularFrequency wMechanical = inertia.w "Mechanical speed" annotation(
    Dialog(group = "Initialization", showStartAttribute = true));
  Modelica.Units.SI.AngularFrequency W0(start = wNom/pp) "Synchronous mechanical speed";
  Real s "slip";
  Modelica.Units.SI.ComplexImpedance Z2, Zeq;
  Modelica.Units.SI.ComplexCurrent i1 = port.i, i2, im;
  Modelica.Units.SI.ComplexVoltage v1 = port.v, vm;
  Modelica.Units.SI.ComplexMagneticFlux lambdaS, lambdaR;
  parameter Modelica.Units.SI.Time timeConstant = 0.01 "time constant to ease convergence";
  Real smallS "Indicates when we have a very small slip";
  parameter Real eps = 1e-5;
  Complex vMecc = Rr/s*i2;
  //Only for debug
  Modelica.Mechanics.Rotational.Sources.Torque torque annotation(
    Placement(transformation(extent = {{16, -10}, {36, 10}})));
  Modelica.Blocks.Sources.RealExpression tauGen(y = tauElectrical) annotation(
    Placement(transformation(extent = {{-32, -12}, {-2, 12}})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia(J = J) annotation(
    Placement(transformation(extent = {{44, -10}, {64, 10}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange annotation(
    Placement(transformation(extent = {{70, -10}, {90, 10}}), iconTransformation(extent = {{90, -10}, {110, 10}})));
equation
// W0 + timeConstant*der(W0) = wNom/pp;
  W0 + timeConstant*der(W0) = systemPowerGrids.omegaRef/pp;
//  W0=wNom/pp;
//  W0 = (systemPowerGrids.omegaRef + der(port.UPhase))/pp;
  s = (W0 - inertia.w)/W0;
  Z2.im = wNom*Lrl;
  if noEvent(abs(s) > eps) then
    Z2.re + timeConstant*der(Z2.re) = Rr/s;
    smallS = 0.;
  else
    Z2.re + timeConstant*der(Z2.re) = Rr/eps;
    smallS = 1.;
  end if;
/* the following four Kirchhoff's equations, along with an external 
 constitutive equation, allow determining the five variables port.v, port.i, i2, im, vm
 */
//Kirchhoff's node equation:
  v1 = vm + Z1*i1;
  i1 = im + i2;
//Kirchhoff's voltage equations:
  vm = Z2*i2;
  vm = Zm*im;
  Zeq = Z2*Zm/(Z2 + Zm) + Z1;
/*
  Equivalent formulation (instead of previous definitions of v1, i1, vm, im)
  v1=Zeq*i1;
  vm=v1-Z1*i1;
  im=vm/Zm;
  i2=i1-im;
*/
//Air gap torque Tag is applied to rotor's inertia (for the moment in graphical form).
  tauElectrical = 3*Z2.re*(i2.re^2 + i2.im^2)/W0;
//Verifica con altra formula (serve per mostrare che quest'altra formula dà
//lo stesso risultato; risulterà utile per altri modelli della macchina asincrona)
  lambdaS = Ls*i1 - M*i2;
  lambdaR = Lr*i1 - M*i2;
  tauElec = -3*pp*(lambdaS.im*i1.re - lambdaS.re*i1.im);
  connect(tauGen.y, torque.tau) annotation(
    Line(points = {{-0.5, 0}, {14, 0}}, color = {0, 0, 127}));
  connect(inertia.flange_b, flange) annotation(
    Line(points = {{64, 0}, {80, 0}}, color = {0, 0, 0}));
  connect(torque.flange, inertia.flange_a) annotation(
    Line(points = {{36, 0}, {44, 0}}, color = {0, 0, 0}));
  annotation(
    Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -20}, {80, 20}})),
    Icon(coordinateSystem(preserveAspectRatio = true, grid = {2, 2}), graphics = {Text(textColor = {0, 0, 255}, extent = {{-120, 150}, {120, 112}}, textString = "%name"), Rectangle(lineColor = {28, 108, 200}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Line(points = {{-108, 0}, {-58, 0}}, color = {28, 108, 200}), Rectangle(fillColor = {95, 95, 95}, fillPattern = FillPattern.HorizontalCylinder, extent = {{62, 10}, {102, -10}}), Rectangle(fillColor = {175, 175, 175}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-70, 60}, {76, -54}}), Polygon(fillPattern = FillPattern.Solid, points = {{-60, -84}, {-50, -84}, {-20, -14}, {30, -14}, {60, -84}, {70, -84}, {70, -94}, {-60, -94}, {-60, -84}}), Text(origin = {1, 0}, textColor = {255, 255, 255}, extent = {{-59, 56}, {59, 4}}, textString = "IM")}),
    Documentation(info = "<html><head></head><body><p>This model models an asynchronous machine based on a quasi-stationary approximation: the equivalent single-phase circuit.</p>
<p>This model is very fast and compact, and gives result with sufficient precision in phasor-based needs.</p>
</body></html>"),
    experiment(__Dymola_NumberOfIntervals = 5000, __Dymola_Algorithm = "Dassl"));
end AynchronousMachine0;
