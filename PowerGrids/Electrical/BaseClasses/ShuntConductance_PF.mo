within PowerGrids.Electrical.BaseClasses;
model ShuntConductance_PF
  "Connects the port to ground via a conductor"
  extends OnePortAC_PF;
  input Types.ComplexAdmittance Y "Shunt admittance";
  Types.ComplexVoltage v(re(nominal = port.VBase), im(nominal = port.VBase)) = port.v;
  Types.ComplexCurrent i(re(nominal = port.IBase), im(nominal = port.IBase)) = port.i;
equation
  i = Y*v;
end ShuntConductance_PF;