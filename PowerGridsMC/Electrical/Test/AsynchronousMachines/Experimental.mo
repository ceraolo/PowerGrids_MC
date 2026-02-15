within PowerGridsMC.Electrical.Test.AsynchronousMachines;
model Experimental "Like AsynchronousMachine2, but without busFault"
  import Modelica.Constants.pi;
  extends Modelica.Icons.Example;
  parameter Real T1=10, T2=50 "Load torque constants";
  parameter Real Vnom=100;

  PowerGridsMC.Electrical.Buses.InfiniteBus bus(UNom=Vnom*sqrt(3), SNom=100000, R = 0.005, X = 0.05)       annotation(
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = -90, origin={-20,-30})));
  inner PowerGridsMC.Electrical.System systemPowerGrids(showDataOnDiagramsPu = true) annotation(
    Placement(transformation(origin={24,10},    extent = {{-10, -10}, {10, 10}})));

  parameter PowerGridsMC.Electrical.Test.AsynchronousMachines.AsmaMSL aimcData
    annotation (Placement(transformation(origin={-18,8}, extent={{-10,-10},{10,
            10}})));
  PowerGridsMC.Electrical.Machines.AsynchronousMachine2 pgAsma2(
    startSteadyState=true,
    useFluxDerivatives=false,
    pp=aimcData.p,
    Lsl=aimcData.Lssigma,
    Lrl=aimcData.Lrsigma,
    J=aimcData.Jr,
    M=aimcData.Lm,
    Rr=aimcData.Rr,
    Rs=aimcData.Rs,
//    SNom(displayUnit="V.A") = 0.1,
//    UNom=100,
    T1=T1,
    T2=T2) annotation (Placement(transformation(origin={28,0}, extent={{-20,-40},
            {0,-20}})));
equation
  connect(bus.terminal, pgAsma2.terminal)
    annotation (Line(points={{-20,-30},{8,-30}}, color={0,0,0}));
  annotation(
    Diagram(coordinateSystem(preserveAspectRatio=false,   extent={{-40,-40},{40,
            20}})),
    experiment(
      StopTime=1,
      Interval=0.0005,
      Tolerance=1e-06, StartTime = 0),
    Documentation(info="<html>
<p>This is a variation of AsynchronousMachine2 model, created to show an initialization problem with Dymola.</p>
<p>Once this problem is solved, this model will be deleted.</p>
</html>"));
end Experimental;
