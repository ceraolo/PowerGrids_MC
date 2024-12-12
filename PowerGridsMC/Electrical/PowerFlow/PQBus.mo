within PowerGridsMC.Electrical.PowerFlow;
model PQBus "PQ bus"
  extends BaseClasses.OnePortAC_PF(portVariablesPhases = true);
  extends Icons.Load;
  parameter Types.ActivePower P = SNom "Active power entering the bus";
  parameter Types.ReactivePower Q = 0 "Reactive power entering the bus";

  parameter Boolean showPortData=true "if Port Data are shown in diagram (P&Q or U)";
  outer Electrical.System systemPowerGrids "Reference to system object";
  parameter Boolean showDataOnDiagramsPu = systemPowerGrids.showDataOnDiagramsPu
   "=true, P,Q,V and phase are shown on the diagrams in per-unit of local machine base"
   annotation(Dialog(tab = "Visualization"));

equation
  port.P = P;
  port.Q = Q;

annotation (
    Icon(coordinateSystem(grid={2,2}),
     graphics={  Text(origin = {60, -60}, extent = {{-20, 20}, {48, -40}}, textString = "PQ"),
       Text(
          visible=showPortData,
          extent={{-102,62},{-2,30}},
          lineColor={238,46,47},
          textString=DynamicSelect("P",
             if showDataOnDiagramsPu then
               String(-port.PGenPu, format = "6.3f")
             else
               String(port.S.re/1e6, format = "9.2f"))),
       Text(
          visible=showPortData,
          extent={{0,62},{112,30}},
          lineColor={217,67,180},
          textString=DynamicSelect("Q",
            if showDataOnDiagramsPu then
               String(-port.QGenPu, format = "6.3f")
             else
               String(port.S.im/1e6, format = "9.2f")))}

),  Documentation(info = "<html>
<p>PQBus: prescribes the active power <code>P</code> and the reactive power <code>Q</code> entering the bus.</p>
</html>"),
    Diagram(coordinateSystem(grid={2,2})));
end PQBus;
