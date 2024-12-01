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
          Text(origin={-79.2668,-43.3999},
                                  extent={{-16.7332,17.3999},{33.4668,-34.8001}},
                                                                   textString = "PV")}),
    Documentation(info = "<html><head></head><body><p>PVBus: prescribes the line-to-line voltage magnitude <code>U</code> of the bus and the active power <code>P</code> entering the  bus.</p>
</body></html>"));
end PVBus;
