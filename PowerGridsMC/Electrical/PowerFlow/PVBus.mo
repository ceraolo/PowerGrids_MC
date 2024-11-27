within PowerGridsMC.Electrical.PowerFlow;
model PVBus "PV bus"
  extends BaseClasses.OnePortAC_PF(portVariablesPhases = true);
  extends Icons.Machine;
  parameter Types.ActivePower P = SNom "Active power entering the bus";
  parameter Types.Voltage U = UNom "Absolute value of phase-to-phase voltage";
equation
  port.P = P;
  port.U = U;
annotation (
    Icon(graphics={
          Rectangle(
          extent={{26.5,24.6},{88,-18.9}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
          Text(origin={48.2,9.8}, extent = {{-20, 20}, {40, -40}}, textString = "PV")}),
    Documentation(info = "<html><head></head><body><p>PVBus: prescribes the line-to-line voltage magnitude <code>U</code> of the bus and the active power <code>P</code> entering the  bus.</p>
</body></html>"));
end PVBus;
