within PowerGridsMC.Electrical.Loads;
model LoadPQ "PQ bus"
  extends PowerGridsMC.Electrical.BaseClasses.OnePortAC;
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
     graphics={  Text(origin={53.4118,-66.6664},
        extent={{-19.4118,8.66645},{46.5882,
              -17.3336}}, textString = "PQ"),
       Text(
          visible=showPortData,
          extent={{-100,44},{0,22}},
          lineColor={238,46,47},
          textString=DynamicSelect("P",
             if showDataOnDiagramsPu then
               String(-port.PGenPu, format = "6.3f")
             else
               String(port.S.re/1e6, format = "9.2f"))),
       Text(
          visible=showPortData,
          extent={{0,44},{102,22}},
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
end LoadPQ;
