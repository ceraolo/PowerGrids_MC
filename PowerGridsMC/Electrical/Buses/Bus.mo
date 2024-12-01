within PowerGridsMC.Electrical.Buses;
model Bus "Bus model"
  extends PowerGridsMC.Electrical.BaseClasses.OnePortAC(
    final PStart = 0,
    final QStart = 0);
  extends Icons.Bus;

   parameter Boolean showPFdata=true "=true, if PowerFlow data are to be shown";

equation
  port.i = Complex(0);

//      textString=DynamicSelect("Uph", String(port.UPhase, significantDigits=3)))}));
  annotation (
    Documentation(info = "<html>
Bus model, can be used to connect other components to its port.
</html>"),
  Icon(graphics={
    Text(
      visible=showPFdata,
      extent={{-170,46},{-32,12}},
      lineColor={28,108,200},
      textString=DynamicSelect("V", String(port.U/port.UNom, significantDigits=3))),
    Text(
      visible=showPFdata,
      extent={{-164,-12},{-28,-46}},
      lineColor={28,108,200},
      textString=DynamicSelect("Uph", String(port.UPhase*180/3.14159265359, format = "4.1f")+"°"))}));
end Bus;
