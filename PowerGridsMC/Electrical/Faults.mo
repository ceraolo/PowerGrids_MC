within PowerGridsMC.Electrical;
package Faults
  model ThreePhaseFault
    extends BaseClasses.OnePortAC;

    Types.ComplexVoltage v = port.v "Port voltage, phase-to-ground";
    Types.ComplexCurrent i = port.i "Port current";

    discrete Types.ComplexAdmittance Y(re(start = 0, fixed = true), im(start = 0, fixed = true)) "Shunt admittance";
    Boolean fault(start = false, fixed = true) "The fault is active";

    parameter Types.Resistance R = 0 "Series resistance to ground during fault" annotation(Dialog(group="Fault data"));
    parameter Types.Reactance X = 0 "Series reactance to ground during fault" annotation(Dialog(group="Fault data"));
    parameter SI.Time startTime "Start time of the fault" annotation(Dialog(group="Fault data"));
    parameter SI.Time stopTime "End time of the fault" annotation(Dialog(group="Fault data"));

    parameter Boolean showPortData=true "=true, if PowerFlow data are to be shown";
    parameter Boolean showDataOnDiagramsPu = systemPowerGrids.showDataOnDiagramsPu
     "=true, P,Q,V and phase are shown on the diagrams in per-unit of local machine base"
     annotation(Dialog(tab = "Visualization"));

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

    annotation (Icon(coordinateSystem(preserveAspectRatio=false,
          extent={{-60,-100},{60,60}},
          grid={2,2}),    graphics={
          Text(origin={0,-116},    textColor = {0, 0, 255},
          extent = {{-100, 10}, {100, -10}}, textString = "%name"),
          Line(origin={3.2366,        -70.242},
                   points = {{-3.01972, 29.9973}, {18.9803, 9.99729}, {-19.0197, -12.0027}, {2.98028, -30.0027}},
            arrow = {Arrow.None, Arrow.Filled}, arrowSize = 10,   color={238,46,47},
            thickness=1),  Rectangle(origin={0,-20},
              fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent={{-20,20},
                {20,-20}}),
             Text(origin={40,-18},   extent = {{-20, 20}, {20, -20}}, textString = "Z"),
        Text(
          visible = showPortData,
          textColor = {217, 67, 180},
          extent={{-81,-18},{-20,-36}},
          textString = DynamicSelect("Q",
          if showDataOnDiagramsPu then
            String(-port.QGenPu, "6.3f") else
            String((port.S.im/1000000), format="-9.2f")),horizontalAlignment = TextAlignment.Center),
        Text(visible = showPortData,
          textColor = {238, 46, 47}, extent={{-24,12},{-75,-12}},
          textString = DynamicSelect("P",
          if showDataOnDiagramsPu then
            String(-port.PGenPu, "6.3f")
          else
            String((port.S.re/1000000), format="-9.2f")),horizontalAlignment = TextAlignment.Center)}),
        Diagram(coordinateSystem(preserveAspectRatio=false)));
  end ThreePhaseFault;
end Faults;
