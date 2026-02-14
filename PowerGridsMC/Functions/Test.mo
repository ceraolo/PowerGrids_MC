within PowerGridsMC.Functions;
package Test
  extends Modelica.Icons.ExamplesPackage;

  model TestTimeConstants
    extends Modelica.Icons.Example;
    Real T1 = largerTimeConstant(8, 15);
    Real T2 = smallerTimeConstant(8, 15);
    annotation(experiment(StopTime = 1),
      Documentation(info = "<html><head></head><body>Computes the time constants of 1 + 8s + 15 = (1+3s)(1+5s)
</body></html>"));
  end TestTimeConstants;


  model TestAsmaFunOfVW
    extends Modelica.Icons.Example;
    /* Function AsmFunOfSpeeed returns the steady-state equivalent impedance of 
    an asynchronous machine as a function of rotational speed, and the torque related 
    to this speed and the given the input voltage. 
    It refers to the single-phase equivalent circuit represented by impedances 
    described by complex numbers.
  */
    parameter PowerGridsMC.Examples.AsynchronousMachine.AsmaMSL r;
    import Modelica.Constants.pi;
    Real W "rotational velocity";
  //parameters
    parameter Integer pp=r.p "Pole pairs";
    parameter Real R1=r.Rs, R2=r.Rr "Stator and rotor resistances";
    parameter Real L1l=r.Lssigma, L2l=r.Lrsigma "Stator and rotor inductances";
    parameter Real Lm=r.Lm    "Magnetising inductance";
    parameter Real T1=10, T2=20 "Load torque constants";
    parameter Modelica.Units.SI.AngularVelocity Wsyn=100*pi/pp "synchronous (mechanical) rotational velocity";

    Real Req "Resistance of the equivalent impedance";
    Real Xeq "Reactance of the equivalent impedance";
    Real tauElectrical "Generated electromagnetical torque";
    Modelica.Units.SI.ComplexPower S1;

  equation
    // When simulation ends with time=0, we have reached the synchronous speed
     W=Wsyn*time;
    (Req,Xeq,tauElectrical,S1) = AsmaElecQsPg.Functions.asmaValuesFunOfSpeed(
        V=100,
        W=W,
        pp=pp,
        R1=R1,
        R2=R2,
        L1l=L1l,
        L2l=L2l,
        Lm=Lm,
        T1=T1,
        T2=T2,
        Wsyn=Wsyn);

    annotation (experiment(
        StopTime=0.976,
        __Dymola_NumberOfIntervals=20000,
        __Dymola_Algorithm="Dassl"), Documentation(info="<html>
<p>Tests function AsmaValuesFunOfSpeed. </p>
<p>The electric torque tauElectrical should be (and actually is) the same as in Examples.AsynchronousMachine.StartPg_MSL_QS.</p>
<p>More in general, the torque must be the same obtained neglecting transformer terms in asynchronous machine dynamic models, a condition that can be approximated ising &quot;startSteadyState=true&quot; in this library&apos;s asynchronous machine models.</p>
</html>"));
  end TestAsmaFunOfVW;

  model FindSteadyState
    /* this model contains 6 equations and variables.
    variables are: 
    Req, Xeq, tauElectrical, S1.P, S1.Q, W.
  */
    extends Modelica.Icons.Example;
    import Modelica.Constants.pi;
    parameter Modelica.Units.SI.Voltage V=100;

    parameter PowerGridsMC.Examples.AsynchronousMachine.AsmaMSL r;
    parameter Integer pp=r.p "Pole pairs";
    parameter Real R1=r.Rs, R2=r.Rr "Stator and rotor resistances";
    parameter Real L1l=r.Lssigma, L2l=r.Lrsigma "Stator and rotor inductances";
    parameter Real Lm=r.Lm    "Magnetising inductance";
    parameter Real T1=10, T2=50 "Load torque constants";
    parameter Modelica.Units.SI.AngularVelocity Wsyn=100*pi/pp "synchronous (mechanical) rotational velocity";

    Modelica.Units.SI.AngularVelocity W(start=Wsyn);
    Real Req "Resistance of the equivalent impedance";
    Real Xeq "Reactance of the equivalent impedance";
    Real tauElectrical "Generated electromagnetical and mechanical torques";
    Modelica.Units.SI.ComplexPower S1;

  equation
    (Req,Xeq,tauElectrical,S1) = AsmaElecQsPg.Functions.asmaValuesFunOfSpeed(
        V=V,
        W=W,
        pp=pp,
        R1=R1,
        R2=R2,
        L1l=L1l,
        L2l=L2l,
        Lm=Lm,
        T1=T1,
        T2=T2,
        Wsyn=Wsyn);
    //W is determined iteratively by imposing the equality of the torque generated
    //by the machine and the one absorbed by the mechanical load:
   tauElectrical=T1+T2*(W/Wsyn)^2;
  when initial() then
    Modelica.Utilities.Streams.print("\nss tau: "+String(tauElectrical)+", ss W: "+String(W));

    // da togliere successivamente:
   Modelica.Utilities.Streams.print("pp, R1, R2, L1l, L2l, Lm:\n"+String(pp)+  ", "
                                      +String(R1) +", "
                                      +String(R2) +", "
                                      +String(L1l)+", "
                                      +String(L2l)+", "
                                      +String(Lm));
    Modelica.Utilities.Streams.print("T1: "+String(T1)+", ss T2: "+String(T2));
    Modelica.Utilities.Streams.print("ss V: "+String(V)+", ss Wsyn: "+String(Wsyn)+"\n");
  end when
    annotation (

      Icon(coordinateSystem(preserveAspectRatio=false), graphics={                                                                                                                                                                                                        Text(extent={{-100,
                140},{102,110}},                                                                                                                                                                                                        lineColor={85,0,255},    fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid,
            textString="%name")}),
      Diagram(coordinateSystem(preserveAspectRatio=false)),
      Documentation(info="<html>
<p>This model is aimed at findng the steady-state asynchronousMachine operation point, for a mechanical load of the type A+B*W^2 (actually expressed as T1+T2*(W/Wsyn)^2).</p>
<p>The steady state point gives as ouptut absorbed active and reactive power, speed, equivalent resistance and reactance.</p>
<p>This SS operating point is useful for the implementation of PFT behaviour when asynchronous machines are incudes.</p>
</html>"));
    annotation (Icon(graphics={                                                     Text(textColor = {0, 0, 255}, extent={{-98,140},
                {98,104}},                                                                                                                            textString = "%name")}));
  end FindSteadyState;

  model TestStartAndSS_MSL
    "Compares MSL and PowerGridsMC asynchronous machine models start from standstill"
    import Modelica.Constants.pi;
    extends Modelica.Icons.Example;
    parameter Real T1=50, T2=100 "Load torque constants";
    parameter Real V=100;
    Modelica.Units.SI.Torque tauLoad=-inertiaPg.flange_b.tau;

    Modelica.Mechanics.Rotational.Components.Inertia inertiaPg(J = 2, phi(
          fixed=true, start=0))                                       annotation(
      Placement(transformation(extent={{16,-36},{36,-16}})));
    Modelica.Mechanics.Rotational.Sensors.PowerSensor pMecc
      annotation (Placement(transformation(extent={{-10,-36},{10,-16}})));
    PowerGridsMC.Electrical.Buses.InfiniteBus bus(UNom=V*sqrt(3), SNom=100000)       annotation(
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = -90, origin={-62,-26})));
    inner PowerGridsMC.Electrical.System systemPowerGrids(showDataOnDiagramsPu = true) annotation(
      Placement(transformation(origin={30,30},    extent = {{-10, -10}, {10, 10}})));
    PowerGridsMC.Electrical.Machines.AsynchronousMachine aimcPg(
      startSteadyState=true,
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
        displayUnit="rpm")) annotation (Placement(transformation(origin={-2.6666,-6},
            extent={{-43.3334,-30},{-23.3334,-10}})));

    parameter PowerGridsMC.Examples.AsynchronousMachine.AsmaMSL aimcData
      annotation (Placement(transformation(origin={-60,12},  extent={{-10,-10},{10,
              10}})));
    Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque tau2(
        tau_nominal=-T2, w_nominal=314.159/2)
      annotation (Placement(transformation(origin = {-6, -34}, extent = {{80, -20}, {60, 0}})));
    Modelica.Mechanics.Rotational.Sources.ConstantTorque tau1(tau_constant=-T1)
      annotation (Placement(transformation(origin = {-6, 44}, extent = {{80, -54}, {60, -34}})));
    AsmaElecQsPg.Functions.Test.FindSteadyState findSS(
      V=V,
      T1=T1,
      T2=T2) annotation (Placement(transformation(extent={{-12,2},{8,22}})));
  equation
    connect(pMecc.flange_b, inertiaPg.flange_a)
      annotation (Line(points={{10,-26},{16,-26}}, color={0,0,0}));
    connect(bus.terminal, aimcPg.terminal)
      annotation (Line(points={{-62,-26},{-46,-26}}));
    connect(aimcPg.flange, pMecc.flange_a)
      annotation (Line(points={{-26,-26},{-10,-26}}));
    connect(tau1.flange, inertiaPg.flange_b) annotation (Line(points = {{54, 0}, {48, 0}, {48, -26}, {36, -26}}));
    connect(
      tau2.flange, inertiaPg.flange_b) annotation (
      Line(points = {{54, -44}, {48, -44}, {48, -26}, {36, -26}}));
    annotation(
      Diagram(coordinateSystem(preserveAspectRatio=false,   extent={{-80,-60},{80,
              40}})),
      experiment(Interval = 0.0005, StartTime = 0, StopTime = 3, Tolerance = 1e-06),
      experimentSetupOutput,
      Documentation(info="<html>
<p>This model tries to check the effectiveness of model FindSteadyStateW to find the steady-state speed of an asynchronous machine when fed from a given voltage source amplitude.</p>
<p>This, in turn, is intended to be used by PFT with asynchronous machines to find the steady-state during PowerFlow analysis.</p>
</html>"));
  end TestStartAndSS_MSL;
end Test;
