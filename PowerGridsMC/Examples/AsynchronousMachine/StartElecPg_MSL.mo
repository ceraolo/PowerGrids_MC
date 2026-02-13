within PowerGridsMC.Examples.AsynchronousMachine;
model StartElecPg_MSL
  "Compares MSL and PowerGridsMC asynchronous machine models start from standstill"
  import Modelica.Constants.pi;
  extends Modelica.Icons.Example;
  Modelica.Electrical.Machines.Utilities.TerminalBox terminalBox(terminalConnection = "Y") annotation(
    Placement(transformation(origin = {-2, 0}, extent = {{-14, 14}, {6, 34}})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation(
    Placement(transformation(origin = {-78, -10}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Polyphase.Basic.Star star annotation(
    Placement(transformation(origin = {-78, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  Modelica.Mechanics.Rotational.Sources.Torque torque annotation(
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin = {80, 0})));
  Modelica.Blocks.Sources.Constant const(k = -100.0) annotation(
    Placement(transformation(extent = {{-8, -8}, {8, 8}}, rotation = 180, origin = {110, 0})));
  Modelica.Electrical.Polyphase.Sources.SineVoltage sineVoltage(f = systemPowerGrids.fNom*ones(3), V = bus.UNom*sqrt(2/3)*ones(3)) annotation(
    Placement(transformation(origin={-100,0},  extent={{58,18},{38,38}})));
  Modelica.Mechanics.Rotational.Components.Inertia inertiaElec(J = inertiaPg.J) annotation(
    Placement(transformation(extent = {{42, -10}, {62, 10}})));
  Modelica.Mechanics.Rotational.Sources.Torque torque1 annotation(
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin = {80, -44})));
  Modelica.Mechanics.Rotational.Components.Inertia inertiaPg(J = 2) annotation(
    Placement(transformation(extent = {{42, -54}, {62, -34}})));
  Modelica.Electrical.Polyphase.Sensors.AronSensor pDcElec annotation(
    Placement(transformation(origin = {-2, 0}, extent = {{-32, 18}, {-12, 38}})));
  Modelica.Mechanics.Rotational.Sensors.PowerSensor pMeccElec annotation(
    Placement(transformation(extent = {{14, -10}, {34, 10}})));
  Modelica.Mechanics.Rotational.Sensors.PowerSensor pMeccQs annotation(
    Placement(transformation(extent = {{16, -54}, {36, -34}})));
  PowerGridsMC.Electrical.Buses.InfiniteBus bus(UNom = 100*sqrt(3), SNom = 100000) annotation(
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = -90, origin={-36,-44})));
  inner PowerGridsMC.Electrical.System systemPowerGrids(showDataOnDiagramsPu = true) annotation(
    Placement(transformation(origin={70,30},    extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Machines.BasicMachines.InductionMachines.IM_SquirrelCage
    aimc(p = aimcData.p, fsNominal = aimcData.fsNominal, Rs = aimcData.Rs,
    TsRef = aimcData.TsRef, alpha20s(displayUnit = "1/K") = aimcData.alpha20s,
    Lszero = aimcData.Lszero,
    Lssigma = aimcData.Lssigma,
    Jr = aimcData.Jr,
    Js = aimcData.Js, frictionParameters = aimcData.frictionParameters,
    wMechanical(start = 0, fixed = true),
    statorCoreParameters = aimcData.statorCoreParameters,
    strayLoadParameters = aimcData.strayLoadParameters,
    Lm = aimcData.Lm, Lrsigma = aimcData.Lrsigma,
    Rr = aimcData.Rr,
    TrRef = aimcData.TrRef,
    phiMechanical(fixed = true),
    TsOperational = 293.15, alpha20r = aimcData.alpha20r,
    TrOperational = 293.15) annotation(
    Placement(transformation(origin = {-2, 0}, extent = {{-14, -11}, {6, 9}})));
  Electrical.Machines.AsynchronousMachine aimcPg(
    startSteadyState=false,
    J=aimcData.Jr,
    Lsl=aimcData.Lssigma,
    Lrl=aimcData.Lrsigma,
    M=aimcData.Lm,
    Rr=aimcData.Rr,
    Rs=aimcData.Rs,
    SNom(displayUnit="V.A") = 0.1,
    UNom=100,
    wMechanical(
      fixed=true,
      start=0,
      displayUnit="rpm")) annotation (Placement(transformation(origin={23.3334,
            -24}, extent={{-43.3334,-30},{-23.3334,-10}})));

  parameter AsmaMSL aimcData annotation (Placement(
        transformation(origin={-72,-36}, extent={{-10,-10},{10,10}})));
equation
  connect(ground.p, star.pin_n) annotation(
    Line(points = {{-78, 0}, {-79, 0}, {-79, 8}, {-78, 8}}, color = {0, 0, 255}));
  connect(const.y, torque.tau) annotation(
    Line(points = {{101.2, 0}, {92, 0}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(inertiaElec.flange_b, torque.flange) annotation(
    Line(points = {{62, 0}, {70, 0}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(torque1.tau, const.y) annotation(
    Line(points = {{92, -44}, {101.2, -44}, {101.2, 0}}, color = {0, 0, 127}));
  connect(inertiaPg.flange_b, torque1.flange) annotation(
    Line(points = {{62, -44}, {70, -44}}, color = {0, 0, 0}));
  connect(pDcElec.plug_n, terminalBox.plugSupply) annotation(
    Line(points = {{-14, 28}, {-6, 28}, {-6, 20}}, color = {0, 0, 255}));
  connect(inertiaElec.flange_a, pMeccElec.flange_b) annotation(
    Line(points = {{42, 0}, {34, 0}}, color = {0, 0, 0}));
  connect(pMeccQs.flange_b, inertiaPg.flange_a) annotation(
    Line(points = {{36, -44}, {42, -44}}, color = {0, 0, 0}));
  connect(terminalBox.plug_sn, aimc.plug_sn) annotation(
    Line(points = {{-12, 18}, {-12, 9}}, color = {0, 0, 255}));
  connect(terminalBox.plug_sp, aimc.plug_sp) annotation(
    Line(points = {{0, 18}, {0, 9}}, color = {0, 0, 255}));
  connect(aimc.flange, pMeccElec.flange_a) annotation(
    Line(points = {{4, -1}, {4, 0}, {14, 0}}));
  connect(bus.terminal, aimcPg.terminal)
    annotation (Line(points={{-36,-44},{-20,-44}}));
  connect(aimcPg.flange, pMeccQs.flange_a)
    annotation (Line(points={{0,-44},{16,-44}}));
  connect(star.plug_p, sineVoltage.plug_n)
    annotation (Line(points={{-78,28},{-62,28}}, color={0,0,255}));
  connect(sineVoltage.plug_p, pDcElec.plug_p)
    annotation (Line(points={{-42,28},{-34,28}}, color={0,0,255}));
  annotation(
    Diagram(coordinateSystem(preserveAspectRatio=false,
    extent={{-100,-60},{120,  40}})),
    experiment(Interval = 0.0005, StartTime = 0, StopTime = 3, Tolerance = 1e-06),
    Documentation(info="<html>
<p>Shows electric starting from standstill and compares the result with the one from the MSL model. Machine parameters are exactly those of the MSL machine model. </p>
<p>Since &quot;Start from SteadyState&quot; is not selected in the PG machine initialization tab, the set initial condition is that all stator and rotor currents to be initially zero. This causes the transient to be identical to MSL&apos;s. Check in particular the trend of variable &quot;tauElectrical&quot; im both aimc models.</p>
<p>To see a moch smoother startup transient, similar to the one often reported in textbooks, check StartElec_QS, in which all derivatives of fluxes are initially set to zero.</p>
</html>"));
end StartElecPg_MSL;
