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
    Icon( graphics={  Text(origin={67,-70},    extent={{-19,18},{19,-18}},
          textString="Z",
          textColor={0,0,0})}),
    Documentation(info="<html>
<p>Load with constant impedance <span style=\"font-family: Courier New;\">Z</span>. The impedance is computed by default from the nominal values <span style=\"font-family: Courier New;\">PNom, QNom, UNom,</span> but can also be provided directly, by overriding the default binding for <span style=\"font-family: Courier New;\">Z</span>.</p>
<p>This is somehow a duplicate of LoadZeta: it is programmed to unify these two models in the  near future.</p>
</html>"));
end ZLoad;
