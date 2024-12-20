within PowerGridsMC.Electrical.Buses;
model ReferenceBus "Reference bus for an isolated grid"
  extends PowerGridsMC.Electrical.BaseClasses.OnePortAC;
  extends Icons.Bus;
  import PowerGridsMC.Types.Choices.InitializationOption;
  parameter Boolean setPhaseOnly = false "= true if only the initial voltage phase is to be set";
  parameter InitializationOption initOpt = systemPowerGrids.initOpt "Initialization option";
  final parameter Types.ComplexPerUnit nStart = CM.fromPolar(1, UPhaseStart) "Unit phasor with angle UPhaseStart";
  final parameter Types.ActivePower PSlack(fixed = false) "Constant slack active power leaving system through bus";
  final parameter Types.ReactivePower QSlack(fixed = false) "Constant slack reactive power leaving system through bus";

  parameter Boolean showPortData=true "=true, if PowerFlow data are to be shown";
  outer Electrical.System systemPowerGrids "Reference to system object";
  parameter Boolean showDataOnDiagramsPu = systemPowerGrids.showDataOnDiagramsPu
   "=true, P,Q,V and phase are shown on the diagrams in per-unit of local machine base"
   annotation(Dialog(tab = "Visualization"));


initial equation
  if not setPhaseOnly then
    port.u = CM.fromPolar(UStart, UPhaseStart) "Set initial bus voltage, phase-to-phase";
  else
    port.u.re*nStart.im = port.u.im*nStart.re "port.u has the same phase as nStart";
    QSlack = 0 "No reactive power leaving system through bus";
  end if;
  assert(abs(PSlack)/SNom < 0.01, "The active power flowing into or out of the reference bus is above 0.01 pu.\n"+
    "You probably need a better balancing of the active power generators in the system.\n" +
    "Please check the documentation of ReferenceBus for further reference", AssertionLevel.warning);
  assert(abs(QSlack)/SNom < 0.01, "The reactive power flowing into or out of the reference bus is above 0.01 pu.\n"+
    "You probably need a better setup of excitation voltages, or you can set setPhaseOnly = true.\n" +
    "Please check the documentation of ReferenceBus for further reference", AssertionLevel.warning);

equation
  port.P = PSlack;
  port.Q = QSlack;
  annotation (
   Icon(coordinateSystem(grid={2,2}), graphics={
        Rectangle(
          extent={{-100,10},{100,-10}},
          lineColor={28,108,200},
          fillColor={0,140,72},
          fillPattern=FillPattern.Solid),
       Text(
          visible=showPortData,
          extent={{-154,60},{-52,24}},
          lineColor={238,46,47},
          textString=DynamicSelect("P",
            if showDataOnDiagramsPu then
              String(-port.PGenPu, format = "6.3f")
            else
              String(port.P/1e6, format = "9.2f"))),
       Text(
          visible=showPortData,
          extent={{-150,-24},{-50,-58}},
          lineColor={217,67,180},
          textString=DynamicSelect("Q",
            if showDataOnDiagramsPu then
              String(-port.QGenPu, format = "6.3f")
            else
              String(port.Q/1e6, format = "9.2f")))}),


    Documentation(info = "<html><head></head><body><p>When an isolated synchronous grid is initialized in steady state, the reference angle remains undefined. In order to make the angles well defined, this ReferenceBus component should be used in the position where the power flow problem has the slack node.</p>
<p>The purpose of this component when the grid is initialized in steady state is twofold:</p>
<ul>
<li>Set the initial voltage of the node to the same value as in the power flow model, i.e. with magnitude <code>UStart</code> and phase <code>UPhaseStart</code></li>
<li>Absorb the excess active power <code>PSlack</code> and reactive power <code>QSlack</code> that allow to balance the power flows at the nominal value of frequency. These two values correspond to the active and reactive power flows into the slack node of the power flow model. <code>PSlack</code> and <code>QSlack</code> then remain constant throughout the simulation. If the power flow is correcty balanced, those two values are nearly zero, so the Reference Bus is not absorbing any significant active or reactive power during the simulation.</li>
</ul>
If <code>setPhaseOnly</code> is set to true, then only the initial phase of the bus voltage is set to the same value of the power flow, i.e., <code>UPhaseStart</code>. The initial voltage magnitude is computed to ensure zero reactive power flow <code>QSlack</code>.</body></html>"),
    Icon(coordinateSystem(grid={2,2}),                            graphics={  Text(origin = {130, 10}, extent = {{-30, 20}, {30, -40}}, textString = "R")}));
end ReferenceBus;
