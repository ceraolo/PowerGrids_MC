within PowerGridsMC.Electrical.BaseClasses;
partial model TwoPortAC "Base class for two-port AC components"
  parameter Types.Voltage UNomA(start = 400e3) "Nominal/rated voltage, port A" annotation(Evaluate = true);
  parameter Types.Voltage UNomB = UNomA "Nominal/rated voltage, port B" annotation(Evaluate = true);
  parameter Types.Power SNom(start = 100e6) "Nominal/rated power" annotation(Evaluate = true);

  parameter Boolean portVariablesPhases = false "Compute voltage and current phases for monitoring purposes only" annotation(Evaluate = true);
  constant Boolean portVariablesPu = true "Add per-unit variables to model";
  parameter Boolean computePowerBalance = true "Compute net balance of complex power entering the component";

  parameter Types.Voltage UStartA = UNomA "Start value of phase-to-phase voltage phasor at port A, absolute value"
    annotation(Dialog(tab = "Initialization"));
  parameter Types.Angle UPhaseStartA = 0 "Start value of phase-to-phase voltage phasor at port A, phase angle"
    annotation(Dialog(tab = "Initialization"));
  parameter Types.ActivePower PStartA = SNom "Start value of active power flowing into port A"
    annotation(Dialog(tab = "Initialization"));
  parameter Types.ReactivePower QStartA = 0 "Start value of reactive power flowing into port A"
    annotation(Dialog(tab = "Initialization"));

  parameter Types.Voltage UStartB = UNomB "Start value of phase-to-phase voltage phasor at port B, absolute value"
    annotation(Dialog(tab = "Initialization"));
  parameter Types.Angle UPhaseStartB = 0 "Start value of phase-to-phase voltage phasor at port B, phase angle"
    annotation(Dialog(tab = "Initialization"));
  parameter Types.ActivePower PStartB = -SNom "Start value of active power flowing into port B"
    annotation(Dialog(tab = "Initialization"));
  parameter Types.ReactivePower QStartB = 0 "Start value of reactive power flowing into port B"
    annotation(Dialog(tab = "Initialization"));

  PowerGridsMC.Interfaces.TerminalA terminalA annotation (
    Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGridsMC.Interfaces.TerminalB terminalB annotation (
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PortAC portA(final v = terminalA.v, final i = terminalA.i,
               final UNom = UNomA, final SNom = SNom,
               final portVariablesPu = portVariablesPu,
               final portVariablesPhases = portVariablesPhases,
               final generatorConvention = false,
               final UStart = UStartA,
               final UPhaseStart = UPhaseStartA,
               final PStart = PStartA,
               final QStart = QStartA)
               "AC port - terminalA";
  PortAC portB(final v = terminalB.v, final i = terminalB.i,
               final UNom = UNomB, final SNom = SNom,
               final portVariablesPu = portVariablesPu,
               final portVariablesPhases = portVariablesPhases,
               final generatorConvention = false,
               final UStart = UStartB,
               final UPhaseStart = UPhaseStartB,
               final PStart = PStartB,
               final QStart = QStartB)
               "AC port - terminalB";

  Types.ComplexPower Sbal = portA.S + portB.S if computePowerBalance "Complex power balance";

    parameter Boolean showPortData=true "=true, if PowerFlow data are to be shown";
    outer Electrical.System systemPowerGrids "Reference to system object";
    parameter Boolean showDataOnDiagramsPu = systemPowerGrids.showDataOnDiagramsPu
     "=true, P,Q,V and phase are shown on the diagrams in per-unit of local machine base"
     annotation(Dialog(tab = "Visualization"));

  annotation (
    Documentation(info = "<html><head></head><body><p>This is the base class for all the components with two AC terminals. It contains two corresponding <code>PortAC</code> components to compute useful quantities for modelling and monitoring purposes.</p>
</body></html>"),
  Icon(graphics = {
    Text(
       visible=showPortData,
       extent={{-160,78},{-50,48}},
       lineColor={238,46,47},
       textString=DynamicSelect("P",
          if showDataOnDiagramsPu then
             String(-portA.PGenPu, format = "6.3f")
          else
             String(portA.S.re/1e6, format = "9.2f"))),
      Text(
        visible=showPortData,
        extent={{-160,46},{-50,16}},
        lineColor={217,67,180},
        textString=DynamicSelect("Q",
          if showDataOnDiagramsPu then
             String(-portA.QGenPu, format = "6.3f")
          else
             String(portA.S.im/1e6, format = "9.2f"))),
      Text(
        visible=showPortData,
        extent={{48,78},{156,48}},
        lineColor={238,46,47},
       textString=DynamicSelect("P",
          if showDataOnDiagramsPu then
             String(-portB.PGenPu, format = "6.3f")
          else
             String(portB.S.re/1e6, format = "9.2f"))),
      Text(
        visible=showPortData,
        extent={{48,46},{156,16}},
        lineColor={217,67,180},
        textString=DynamicSelect("Q",
          if showDataOnDiagramsPu then
             String(-portB.QGenPu, format = "6.3f")
          else
             String(portB.S.im/1e6, format = "9.2f")))}));
end TwoPortAC;
