﻿within PowerGridsMC.Electrical.Buses;
model Bus "Bus model"
  extends PowerGridsMC.Electrical.BaseClasses.OnePortAC(
    final PStart = 0,
    final QStart = 0);
  extends Icons.Bus;

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
      extent={{-212,46},{-74,12}},
      lineColor={28,108,200},
      textString=DynamicSelect("V", String(port.U/port.UNom, significantDigits=3))),
    Text(
      visible=showPFdata,
      extent={{-206,-12},{-70,-46}},
      lineColor={28,108,200},
      textString=DynamicSelect("Uph", String(port.UPhase*180/3.14159265359, format = "4.1f")+"°"))}));
end Bus;
