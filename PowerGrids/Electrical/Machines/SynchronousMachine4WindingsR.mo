within PowerGrids.Electrical.Machines;
model SynchronousMachine4WindingsR
  /* This should be exactly equivalent to SynchronousMachine4WindingsR, 
  but in Dymola this causes an erroneous error message */

  extends SynchronousMachine4Windings;

  //Code to read output from previous PowerFlow run:
  final parameter String name = getInstanceName();
  final parameter String nameShort = PowerGrids.Functions.giveShortName(name);
  parameter Real y[:,:] = Modelica.Utilities.Streams.readRealMatrix(
          nameShort+".mat","y",1,7);

  annotation (Icon(graphics={Text(
          extent={{-88,-56},{-44,-90}},
          textColor={238,46,47},
          textString="R",
          textStyle={TextStyle.Italic})}));
end SynchronousMachine4WindingsR;
