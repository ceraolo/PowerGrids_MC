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

  parameter Boolean showPortData=true "=true, if PowerFlow data are to be shown";

equation
  k = Complex(1);
  Y = 1/Complex(R, X);
  YA = Complex(G/2, B/2);
  YB = Complex(G/2, B/2);
annotation (
    Documentation(info = "<html>
<p>Transmission line with constant series impedance R+jX and constant shunt admittance G+jB. </p>
<p>Implemented as a child class of <a href=\"modelica://PowerGridsMC.Electrical.Branches.BaseClasses.PiNetwork\">PiNetwork</a>, where Ya=Yb=(G+jB)/2 and k = 1, see the corresponding documentation.</p>
</html>"),
Icon(graphics={
       Text(
          visible=showPortData,
          extent={{-160,88},{-50,52}},
          lineColor={238,46,47},
          textString=DynamicSelect("P", String(-portA.PGenPu, significantDigits=3))),
       Text(
          visible=showPortData,
          extent={{-166,48},{-44,12}},
          lineColor={217,67,180},
          textString=DynamicSelect("Q", String(-portA.QGenPu, significantDigits=3))),
       Text(
          visible=showPortData,
          extent={{-170,-20},{-38,-54}},
          lineColor={28,108,200},
          textString=DynamicSelect("V", String(portA.U/portA.UNom, significantDigits=3))),
       Text(
          visible=showPortData,
          extent={{48,88},{156,52}},
          lineColor={238,46,47},
          textString=DynamicSelect("P", String(-portB.PGenPu, significantDigits=3))),
       Text(
          visible=showPortData,
          extent={{42,48},{168,12}},
          lineColor={217,67,180},
          textString=DynamicSelect("Q", String(-portB.QGenPu, significantDigits=3))),
       Text(
          visible=showPortData,
          extent={{40,-20},{168,-54}},
          lineColor={28,108,200},
          textString=DynamicSelect("V", String(portB.U/portB.UNom, significantDigits=3)))}));
end LineConstantImpedance;
