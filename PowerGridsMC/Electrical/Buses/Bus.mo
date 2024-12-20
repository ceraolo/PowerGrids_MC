within PowerGridsMC.Electrical.Buses;
model Bus "Bus model"
  extends PowerGridsMC.Electrical.BaseClasses.OnePortAC(
    final PStart = 0,
    final QStart = 0);
  extends Icons.Bus;

  parameter Boolean showPortData = true "=true, if PowerFlow data are to be shown";
  outer Electrical.System systemPowerGrids "Reference to system object";
  parameter Boolean showDataOnDiagramsPu = systemPowerGrids.showDataOnDiagramsPu "=true, P,Q,V and phase are shown on the diagrams in per-unit of local machine base" annotation(
    Dialog(tab = "Visualization"));

equation
  port.i = Complex(0);

  annotation (
    Documentation(info = "<html>
Bus model, can be used to connect other components to its port.
</html>"),
    Icon(graphics = {
      Text(
        visible = showPortData,
        textColor = {28, 108, 200},
        extent = {{-168, 50}, {-30, 18}},
        textString = DynamicSelect("V",
          if showDataOnDiagramsPu then
            String((port.U/port.UNom), format="6.3f")
          else String((port.U/1000), format="9.2f"))),
      Text(
        visible = showPortData,
        textColor = {28, 108, 200},
        extent={{-162,-18},{-26,-50}},
        textString = DynamicSelect("Uph",
         String(((port.UPhase*180)/3.14159), format="4.1f") + "°"))}
));
end Bus;
