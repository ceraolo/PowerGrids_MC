within PowerGridsMC.Electrical.Test.AsynchronousMachine;
record AsmaBMB "Parameters for MSL induction machine"
  extends Modelica.Icons.Record;
  extends Modelica.Electrical.Machines.Utilities.ParameterRecords.InductionMachineData(Jr = 2.0, Rs = 0.435, Lssigma = 4.0e-3);
  import Modelica.Constants.pi;
  import SI = Modelica.Units.SI;
  parameter SI.Inductance Lm = 69.3e-3 "Stator main field inductance per phase" annotation(
    Dialog(tab = "Nominal resistances and inductances"));
  parameter SI.Inductance Lrsigma = 2.0e-3 "Rotor stray inductance per phase (equivalent three-phase winding)" annotation(
    Dialog(tab = "Nominal resistances and inductances"));
  parameter SI.Resistance Rr = 0.4 "Rotor resistance per phase (equivalent three-phase winding) at TRef" annotation(
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
    Diagram(graphics = {Text(extent = {{-66, 11}, {66, -11}}, textString = "Asynchronous machine parameters
Values of the machine called ")}));
end AsmaBMB;
