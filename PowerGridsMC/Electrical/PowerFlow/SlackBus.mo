within PowerGridsMC.Electrical.PowerFlow;
model SlackBus "Slack Bus"
  extends BaseClasses.OnePortAC_PF;
  extends Icons.Bus;
  parameter Types.Voltage U = UNom "Voltage magnitude, phase-to-phase";
  parameter Types.Angle theta = 0 "Phase of voltage phasor";

   parameter Boolean showPortData=true "=true, if PowerFlow data are to be shown";
  outer Electrical.System systemPowerGrids "Reference to system object";
  parameter Boolean showDataOnDiagramsPu = systemPowerGrids.showDataOnDiagramsPu
   "=true, P,Q,V and phase are shown on the diagrams in per-unit of local machine base"
   annotation(Dialog(tab = "Visualization"));


equation
  port.u = CM.fromPolar(U, theta) "Voltage of ideal generator, phase-to-ground";
annotation (
    Icon(coordinateSystem(grid={2,2}), graphics={
        Rectangle(
          extent={{-100,10},{100,-10}},
          lineColor={28,108,200},
          fillColor={0,140,72},
          fillPattern=FillPattern.Solid),
       Text(
          visible=showPortData,
          extent={{70,68},{172,32}},
          lineColor={238,46,47},
          textString=DynamicSelect("P",
            if showDataOnDiagramsPu then
              String(-port.PGenPu, format = "6.3f")
            else
              String(-port.PGen/1e6, format = "9.2f"))),
       Text(
          visible=showPortData,
          extent={{74,-16},{174,-50}},
          lineColor={217,67,180},
          textString=DynamicSelect("Q",
            if showDataOnDiagramsPu then
              String(-port.QGenPu, format = "6.3f")
            else
              String(-port.QGen/1e6, format = "9.2f")))}),
    Documentation(info = "<html>
<p>Slack bus: prescribes voltage magnitude and phase (default zero).</p>
<p>Exactly one slack bus is required in each interconnected AC system. If the system is isolated, the active and reactive power flows <code>port.P</code> and <code>port.Q</code> should be small, ideally zero; they are not if the system is not balanced in terms of active and reactive power production and consumption.</p>
</html>"));
end SlackBus;
