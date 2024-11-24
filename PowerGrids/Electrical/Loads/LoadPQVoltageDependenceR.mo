within PowerGrids.Electrical.Loads;
model LoadPQVoltageDependenceR
  extends LoadPQVoltageDependence;

 //Code to read output from previous PowerFlow run:
  final parameter String name = getInstanceName();
  final parameter String nameShort = PowerGrids.Functions.giveShortName(name);
  parameter Real y[:, :] = Modelica.Utilities.Streams.readRealMatrix(nameShort + ".mat", "y", 1, 7);

  annotation (Icon(graphics={Text(
          extent={{-62,16},{-18,-18}},
          textColor={238,46,47},
          textString="R",
          textStyle={TextStyle.Italic})}));
end LoadPQVoltageDependenceR;
