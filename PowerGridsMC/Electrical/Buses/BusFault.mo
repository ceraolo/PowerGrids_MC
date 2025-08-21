within PowerGridsMC.Electrical.Buses;

model BusFault
  extends Icons.Bus;
  extends Electrical.BaseClasses.OnePortAC;
  parameter Types.Resistance R = 0 "Series resistance to ground during fault" annotation(
    Dialog(group = "Fault data"));
  parameter Types.Reactance X = 0 "Series reactance to ground during fault" annotation(
    Dialog(group = "Fault data"));
  parameter SI.Time startTime "Start time of the fault" annotation(
    Dialog(group = "Fault data"));
  parameter SI.Time stopTime "End time of the fault" annotation(
    Dialog(group = "Fault data"));
  Types.ComplexVoltage v(re(nominal = port.VBase), im(nominal = port.VBase)) = port.v "Port voltage, phase-to-ground";
  Types.ComplexCurrent i(re(nominal = port.IBase), im(nominal = port.IBase)) = port.i "Port current";
  discrete Types.ComplexAdmittance Y(re(start = 0, fixed = true), im(start = 0, fixed = true)) "Shunt admittance";
  Boolean fault(start = false, fixed = true) "The fault is active";
  outer Electrical.System systemPowerGrids "Reference to system object";
  parameter Boolean showDataOnDiagramsPu = systemPowerGrids.showDataOnDiagramsPu "=true, P,Q,V and phase are shown on the diagrams in per-unit of local machine base" annotation(
    Dialog(tab = "Visualization"));
  parameter Boolean showPortData = true "=true, if PowerFlow data are to be shown";
  // State machine to compute the fault variable
algorithm
  when time >= startTime then
    fault := true;
  end when;
  when time >= stopTime then
    fault := false;
  end when;
// State machine to compute the shunt admittance
algorithm
  when pre(fault) then
    Y := 1/Complex(R, X);
  end when;
  when not pre(fault) then
    Y := Complex(0);
  end when;
equation
  i = Y*v;
  annotation(
    Icon(coordinateSystem(grid = {2, 2}), graphics = {Line(origin = {61.02, -34}, points = {{-3.01972, 29.9973}, {12.98, 14}, {-17.02, -4}, {10, -32}}, color = {238, 46, 47}, thickness = 3, arrow = {Arrow.None, Arrow.Filled}, arrowSize = 16), Text(visible = showPortData, textColor = {28, 108, 200}, extent = {{-168, 50}, {-30, 20}}, textString = DynamicSelect("V", if showDataOnDiagramsPu then String((port.U/port.UNom), "6.3f") else String((port.U/1000), "9.2f"))), Text(visible = showPortData, textColor = {28, 108, 200}, extent = {{-162, -20}, {-26, -50}}, textString = DynamicSelect("Uph", (String(((port.UPhase*180)/3.14159), "4.1f") + "°")))}),
    Diagram(coordinateSystem(grid = {2, 2})));
end BusFault;
