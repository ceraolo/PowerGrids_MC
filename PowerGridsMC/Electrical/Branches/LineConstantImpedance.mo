within PowerGridsMC.Electrical.Branches;
model LineConstantImpedance "Transmission line with constant impedance"
  extends BaseClasses.PiNetwork(
    UNomA = UNom,
    UNomB = UNomA);
  extends Icons.Line;

  parameter Types.Voltage UNom(start = 400e3) "Nominal/rated voltage";
  parameter Types.Resistance R "Series resistance";
  parameter Types.Reactance X "Series reactance";
  parameter Types.Conductance G = 0  "Shunt conductance";
  parameter Types.Susceptance B = 0 "Shunt susceptance";


equation
  k = Complex(1);
  Y = 1/Complex(R, X);
  YA = Complex(G/2, B/2);
  YB = Complex(G/2, B/2);
annotation (
    Documentation(info = "<html>
<p>Transmission line with constant series impedance R+jX and constant shunt admittance G+jB. </p>
<p>Implemented as a child class of <a href=\"modelica://PowerGridsMC.Electrical.Branches.BaseClasses.PiNetwork\">PiNetwork</a>, where Ya=Yb=(G+jB)/2 and k = 1, see the corresponding documentation.</p>
</html>"), Icon(graphics={
      Text(
        visible = showPortData,
        textColor={28,108,200},
        extent={{-172,-16},{-34,-38}},
          textString=DynamicSelect("V", if showDataOnDiagramsPu then String(
           (portA.U/portA.UNom), format ="6.3f") else String((portA.U/1000), format ="9.2f"))),
      Text(
        visible = showPortData,
        textColor = {28, 108, 200},
        extent={{32,-16},{168,-38}},
        textString = DynamicSelect("V", if showDataOnDiagramsPu then String(
           (portB.U/portB.UNom), format ="6.3f") else String((portB.U/1000), format ="9.2f")))}));
end LineConstantImpedance;
