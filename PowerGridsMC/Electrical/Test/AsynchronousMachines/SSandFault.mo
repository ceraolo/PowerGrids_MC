within PowerGridsMC.Electrical.Test.AsynchronousMachines;
model SSandFault
  "Steady-state start and fault analysis"
  import Modelica.Constants.pi;
  extends Modelica.Icons.Example;
  parameter Real T1=10, T2=50 "Load torque constants";
  parameter Real Vnom=100;

  PowerGridsMC.Electrical.Buses.InfiniteBus bus(UNom=Vnom*sqrt(3), SNom=100000, R = 0.005, X = 0.05)       annotation(
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = -90, origin={-34,-30})));
  inner PowerGridsMC.Electrical.System systemPowerGrids(showDataOnDiagramsPu = true) annotation(
    Placement(transformation(origin={10,10},    extent = {{-10, -10}, {10, 10}})));

  parameter PowerGridsMC.Electrical.Test.AsynchronousMachines.AsmaMSL aimcData
    annotation (Placement(transformation(origin={-32,8}, extent={{-10,-10},{10,
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
    T2=T2) annotation (Placement(transformation(origin={14,0}, extent={{-20,-40},
            {0,-20}})));
  PowerGridsMC.Electrical.Buses.BusFault busFault(
    UNom=100,
    SNom=1e5,
    R=0.01,
    X=0.01,
    startTime=0.3,
    stopTime=0.6) annotation (
    Placement(transformation(origin = {-20, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
equation
  connect(
    bus.terminal, busFault.terminal)
    annotation (
    Line(points = {{-34, -30}, {-20, -30}}));
  connect(
    busFault.terminal, pgAsma2.terminal)
    annotation (
    Line(points = {{-20, -30}, {-6, -30}}));
  annotation(
    Diagram(coordinateSystem(preserveAspectRatio=false,   extent={{-60,-40},{20,
            20}})),
    experiment(
      StopTime=1,
      Interval=0.0005,
      Tolerance=1e-06, StartTime = 0),
    Documentation(info= "<html><head></head><body><p>This model tests AsynchronousMachine2 model.</p>
<p>It shows that the system starts in steady-state, no matter what the values of load torque and external system internal impedance is, given that there exists a speed able to match machine and load torque.</p>
<p>Then a perturbation is made on the system, causing a transient.</p>
<p>For instance, the user can check the trend of machines' tauElectrical and wMechanical, as well as its terminal voltage over time.</p>
<p>NOTE: this model does not run on Dymola, which complains about the busFault component. This iissue is not addressed yet.</p>
</body></html>"));
end SSandFault;
