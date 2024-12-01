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
          Text(origin={-77.2667,-42.0664},
                                  extent={{-18.7333,14.0664},{37.4667,-28.1336}},
                                                                   textString = "PV")}),
    Documentation(info = "<html><head></head><body><p>PVBus: prescribes the line-to-line voltage magnitude <code>U</code> of the bus and the active power <code>P</code> entering the  bus.</p>
</body></html>"));
end PVBus;
