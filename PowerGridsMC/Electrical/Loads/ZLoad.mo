within PowerGridsMC.Electrical.Loads;
model ZLoad "Load with constant impedance"
  extends BaseClasses.OnePortAC;
  extends Icons.Load;
  parameter Types.ActivePower PNom = SNom "Nominal active power";
  parameter Types.ActivePower QNom = 0 "Nominal reactive power";

  parameter Types.ComplexImpedance Z = UNom^2/Complex(PNom, -QNom) "Constant impedance of the load";
equation
  port.v = Z*port.i;
annotation (
    Icon(coordinateSystem(grid = {0.1, 0.1}, initialScale = 0.1), graphics={  Text(origin = {72, -60}, extent = {{-20, 20}, {20, -20}}, textString = "PQ")}),
    Documentation(info="<html>
<p>Load with constant impedance <span style=\"font-family: Courier New;\">Z</span>. The impedance is computed by default from the nominal values <span style=\"font-family: Courier New;\">PNom, QNom, UNom,</span> but can also be provided directly, by overriding the default binding for <span style=\"font-family: Courier New;\">Z</span>.</p>
<p>This is somehow a duplicate of LoadZeta: it is programmed to unify these two models in the  near future.</p>
</html>"));
end ZLoad;
