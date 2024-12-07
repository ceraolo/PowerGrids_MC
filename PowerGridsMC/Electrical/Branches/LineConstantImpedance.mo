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
  outer Electrical.System systemPowerGrids "Reference to system object";
  parameter Boolean showDataOnDiagramsPu = systemPowerGrids.showDataOnDiagramsPu
   "=true, P,Q,V and phase are shown on the diagrams in per-unit of local machine base"
   annotation(Dialog(tab = "Visualization"));

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
     textString=DynamicSelect("P",
        if showDataOnDiagramsPu then
           String(-portA.PGenPu, format = "6.3f")
        else
           String(-portA.PGen/1e6, format = "9.3f"))),
    Text(
      visible=showPortData,
      extent={{-166,46},{-44,12}},
      lineColor={217,67,180},
      textString=DynamicSelect("Q",
        if showDataOnDiagramsPu then
           String(-portA.QGenPu, format = "6.3f")
        else
           String(-portA.QGen/1e6, format = "9.3f"))),
    Text(
      visible=showPortData,
      extent={{48,88},{156,52}},
      lineColor={238,46,47},
     textString=DynamicSelect("P",
        if showDataOnDiagramsPu then
           String(-portB.PGenPu, format = "6.3f")
        else
           String(-portB.PGen/1e6, format = "9.3f"))),
    Text(
      visible=showPortData,
      extent={{42,46},{168,12}},
      lineColor={217,67,180},
      textString=DynamicSelect("Q",
        if showDataOnDiagramsPu then
           String(-portB.QGenPu, format = "6.3f")
        else
           String(-portB.QGen/1e6, format = "9.3f")))}));
end LineConstantImpedance;
