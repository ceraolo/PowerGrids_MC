within PowerGridsMC.Electrical.Test.AsynchronousMachines;
record AsmaMSL "Parameters for MSL induction machine"
  extends Modelica.Icons.Record;
  extends Modelica.Electrical.Machines.Utilities.ParameterRecords.InductionMachineData;
  import Modelica.Constants.pi;
  import SI = Modelica.Units.SI;
  parameter SI.Inductance Lm = 3*sqrt(1 - 0.0667)/(2*pi*fsNominal) "Stator main field inductance per phase" annotation(
    Dialog(tab = "Nominal resistances and inductances"));
  parameter SI.Inductance Lrsigma = 3*(1 - sqrt(1 - 0.0667))/(2*pi*fsNominal) "Rotor stray inductance per phase (equivalent three-phase winding)" annotation(
    Dialog(tab = "Nominal resistances and inductances"));
  parameter SI.Resistance Rr = 0.04 "Rotor resistance per phase (equivalent three-phase winding) at TRef" annotation(
    Dialog(tab = "Nominal resistances and inductances"));
  parameter SI.Temperature TrRef = 293.15 "Reference temperature of rotor resistance" annotation(
    Dialog(tab = "Nominal resistances and inductances"));
  parameter Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20 alpha20r = 0 "Temperature coefficient of rotor resistance at 20 degC" annotation(
    Dialog(tab = "Nominal resistances and inductances"));
  annotation(
    defaultComponentName = "aimcData",
    defaultComponentPrefixes = "parameter",
    Documentation(info = "<html>
  <p>Basic parameters of induction machines with squirrel cage are predefined with default values.</p>
  </html>"),
    Diagram(graphics = {Text(origin = {2, 15}, extent = {{-66, 11}, {66, -11}}, textString = "Asynchronous machine parameters
Values of the examples in the 
Modelica Standard Library")}));
end AsmaMSL;
