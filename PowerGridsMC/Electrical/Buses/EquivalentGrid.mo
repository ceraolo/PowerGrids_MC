within PowerGridsMC.Electrical.Buses;
model EquivalentGrid "Equivalent grid model characterized by short circuit capacity"
  extends PowerGridsMC.Electrical.Buses.BaseClasses.BusBase(
    e = eSource,
    Z = ZGrid,
    UStart = URef, UPhaseStart = 0);
  extends Icons.Grid;
  import Modelica.ComplexMath;

  parameter Boolean showPortData = true "=true, if PowerFlow data are to be shown";
  parameter Boolean showDataOnDiagramsPu = systemPowerGrids.showDataOnDiagramsPu "=true, P,Q,V and phase are shown on the diagrams in per-unit of local machine base" annotation(
    Dialog(tab = "Visualization"));

  parameter Types.Voltage URef = UNom "Reference phase-to-phase voltage at connection terminal";
  parameter Types.Angle UPhaseRef = 0 "Voltage phase angle at connection terminal";
  parameter Types.ApparentPower SSC "Short-circuit capacity";
  parameter Types.PerUnit c = 1.1 "voltage factor for calculation of short-circuit capacity (IEC 60909, eq.4)";
  parameter Types.PerUnit R_X = 1/10 "Ratio of resistance to reactance of the grid";

  final parameter Types.ComplexPower Ssc = ComplexMath.fromPolar(SSC/c, atan(1/R_X))  "Short circuit active power";
  final parameter Types.ComplexImpedance ZGrid = 1/ComplexMath.conj(Ssc/UNom ^ 2) "Grid impedance";
  final parameter Types.ComplexVoltage eStart = ComplexMath.fromPolar(URef,UPhaseStart) "Tentative value of voltage source";
  final parameter Types.ComplexVoltage eSource(
    re(fixed = false, start = eStart.re),
    im(fixed = false, start = eStart.im)) "Constant value of voltage source";
initial equation
  // Initial voltage at port fixed at reference values
  port. u= ComplexMath.fromPolar(URef, UPhaseRef);
annotation (
    Documentation(info = "<html><head></head><body><p>This model describes an equivalent grid with an internal impedance driven by a constant voltage source.</p>
<p>The impedance is computed to provide a power flow <code>SSC/c </code> out of the voltage source, assuming the voltage is set to the nominal value <code>UNom</code> and that the grid terminal is shorted to ground.</p>
<p>The actual modulus and phase of the voltage source are computed to give the required voltage modulus and phase <code>URef, UPhaseRef</code> during initialization.</p>
</body></html>"), Icon(graphics={Rectangle(extent={{-100,100},{100,-100}},
            lineColor={28,108,200}),
         Text(visible = showPortData, origin={-7.654,-136},
                         textColor = {238, 46, 47}, extent={{
             -92.3461,66},{5.65386,44}},
           textString=
           DynamicSelect("P",
             if showDataOnDiagramsPu then
               String(-port.PGenPu, format="6.3f")
             else
             String((-port.PGenPu)*SNom/1000000, format="9.2f"))),
         Text(
           visible = showPortData,
           origin={7,-136},
           textColor = {217, 67, 180},
           extent = {{-9, 66}, {91, 44}},
           textString = DynamicSelect("Q",
             if showDataOnDiagramsPu then
               String(-port.QGenPu, format="6.3f")
             else
             String((-port.QGenPu)*SNom/1000000, format="9.2f")))}));
end EquivalentGrid;
