within PowerGridsMC.Electrical.Loads;
model LoadZeta "Load model with impedance specified by PRef QRef and URef"
  extends PowerGridsMC.Electrical.Buses.BaseClasses.BusBase(
    e = Complex(0),
    Z = 1/ComplexMath.conj(Complex(PRef,QRef)/URef^2),
    PStart = PRefConst,
    QStart = QRefConst);
  extends Icons.Load;
  import Modelica.ComplexMath;

  parameter Boolean showPortData=true "=true, if PowerFlow data are to be shown";
  parameter Boolean showDataOnDiagramsPu = systemPowerGrids.showDataOnDiagramsPu
   "=true, P,Q,V and phase are shown on the diagrams in per-unit of local machine base"
   annotation(Dialog(tab = "Visualization"));

  parameter Types.ActivePower PRefConst = 0 "Active power consumption at reference voltage";
  parameter Types.ReactivePower QRefConst = 0 "Reactive power consumption at reference voltage";
  parameter Types.Voltage URef = UNom "Reference value of phase-to-phase voltage";
  Types.ActivePower PRef(nominal = SNom) = PRefConst "Active power consumption at reference voltage, the default binding can be changed when instantiating";
  Types.ActivePower QRef(nominal = SNom) = QRefConst "Reactive power consumption at reference voltage, the default binding can be changed when instantiating";

  annotation (
    Documentation(info = "<html><head></head><body>
<p>Model of a fixed impedance load, whose value is specified by the reference values <code>PRef</code>, <code>QRef</code>, and <code>URef</code>.</p>
</body></html>"),
  Diagram(graphics),
    Icon(graphics = {
      Text(visible = showPortData,
        textColor = {238, 46, 47}, extent = {{-110, 56}, {0, 26}},
        textString = DynamicSelect("P",
        if showDataOnDiagramsPu then
          String(-port.PGenPu, "6.3f")
        else
          String((port.S.re/1000000), format="9.2f"))),
      Text(
        visible = showPortData,
        textColor = {217, 67, 180},
        extent = {{0, 56}, {110, 26}},
        textString = DynamicSelect("Q",
        if showDataOnDiagramsPu then
          String(-port.QGenPu, "6.3f") else
          String((port.S.im/1000000), format="9.2f"))),
                 Text(origin={41.4118,-68.6664},
                                          extent={{-19.4118,8.66645},{46.5882,
              -17.3336}},
          textString="Z",
          textColor={0,0,0})}));
end LoadZeta;
