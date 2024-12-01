within PowerGridsMC.Electrical.PowerFlow;
model PQBus "PQ bus"
  extends BaseClasses.OnePortAC_PF(portVariablesPhases = true);
  extends Icons.Load;
  parameter Types.ActivePower P = SNom "Active power entering the bus";
  parameter Types.ReactivePower Q = 0 "Reactive power entering the bus";

  parameter Boolean showPortData=true "if Port Data are shown in diagram (P&Q or U)";

equation
  port.P = P;
  port.Q = Q;

annotation (
    Icon(coordinateSystem(grid={2,2}),  graphics={  Text(origin = {60, -60}, extent = {{-20, 20}, {48, -40}}, textString = "PQ"),
       Text(
          visible=showPortData,
          extent={{-119.1,68.3},{-9.1,32.3}},
          lineColor={238,46,47},
          textString=DynamicSelect("P", String(port.PGenPu, significantDigits=3))),
       Text(
          visible=showPortData,
          extent={{-5.1,68.3},{116.9,32.3}},
          lineColor={217,67,180},
          textString=DynamicSelect("Q", String(port.QGenPu, significantDigits=3)))}),
    Documentation(info = "<html>
<p>PQBus: prescribes the active power <code>P</code> and the reactive power <code>Q</code> entering the bus.</p>
</html>"),
    Diagram(coordinateSystem(grid={2,2})));
end PQBus;
