within PowerGrids.Electrical.PowerFlow;
model CapacitorBankFixedPF "Capacitor bank with fixed capacitance"
  extends Icons.CapacitorBank;
  extends BaseClasses.ShuntConductance_PF(Y = Complex(0,B));
  parameter Types.Susceptance B = 0 "Capacitor bank susceptance";
end CapacitorBankFixedPF;
