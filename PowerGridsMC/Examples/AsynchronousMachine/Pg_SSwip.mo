within PowerGridsMC.Examples.AsynchronousMachine;
model Pg_SSwip "Start in quasi steady-state with grid feeding"
  import Modelica.Constants.pi;
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.Constant const(k=-50.0)    annotation(
    Placement(transformation(extent = {{-8, -8}, {8, 8}}, rotation = 180, origin={106,-10})));
  Modelica.Mechanics.Rotational.Sources.Torque torque1 annotation(
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin={64,-10})));
  Modelica.Mechanics.Rotational.Components.Inertia inertiaPg(J = 2,
    phi(fixed=true, start=0),
    w(fixed=true,
      start=153.4144412503,
      displayUnit="rpm"))                                           annotation(
    Placement(transformation(extent={{26,-20},{46,0}})));
  Modelica.Mechanics.Rotational.Sensors.PowerSensor pMeccQs annotation(
    Placement(transformation(extent={{0,-20},{20,0}})));
  PowerGridsMC.Electrical.Buses.InfiniteBus bus(UNom=400, SNom=100000)             annotation(
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = -90, origin={-54,-10})));
  inner PowerGridsMC.Electrical.System systemPowerGrids(showDataOnDiagramsPu = true) annotation(
    Placement(transformation(origin={70,22},    extent = {{-10, -10}, {10, 10}})));
  Electrical.Machines.AsynchronousMachine aimcPg(
    startSteadyState=true,
    J=aimcData.Jr,
    L1=aimcData.Lssigma,
    L2=aimcData.Lrsigma,
    M=aimcData.Lm,
    Rr=aimcData.Rr,
    Rs=aimcData.Rs,
    SNom(displayUnit="V.A") = 0.1,
    UNom=100,
    wMechanical(start=0, displayUnit="rpm"))
                          annotation (Placement(transformation(origin={7.3334,
            10},  extent={{-43.3334,-30},{-23.3334,-10}})));

  parameter AsmaElecQsPg.AllSimModels.AsmaBMB aimcData
    annotation (Placement(transformation(extent={{30,14},{50,34}})));
equation
  connect(torque1.tau, const.y) annotation(
    Line(points={{76,-10},{97.2,-10}},                   color = {0, 0, 127}));
  connect(inertiaPg.flange_b, torque1.flange) annotation(
    Line(points={{46,-10},{54,-10}},      color = {0, 0, 0}));
  connect(pMeccQs.flange_b, inertiaPg.flange_a) annotation(
    Line(points={{20,-10},{26,-10}},      color = {0, 0, 0}));
  connect(bus.terminal, aimcPg.terminal)
    annotation (Line(points={{-54,-10},{-36,-10}}));
  connect(aimcPg.flange, pMeccQs.flange_a)
    annotation (Line(points={{-16,-10},{0,-10}}));
  annotation(
    Diagram(coordinateSystem(preserveAspectRatio=false,   extent={{-80,-40},{
            120,40}})),
    experiment(Interval = 0.0005, StartTime = 0, StopTime = 3, Tolerance = 1e-06),
    experimentSetupOutput,
    Documentation(info="<html>
<p><i>Work In Progress</i></p>
<p>This model is intended to strt in steady-state at a power compatible to the mechanical load.</p>
</html>"));
end Pg_SSwip;
