within PowerGrids.Electrical.Buses;
model EquivalentGridR
  extends EquivalentGrid;


  //Code to read output from previous PowerFlow run:
  final parameter String name = getInstanceName();
  final parameter String nameShort = PowerGrids.Functions.giveShortName(name);
  parameter Real y[:,:] = Modelica.Utilities.Streams.readRealMatrix(
          nameShort+".mat","y",1,7);

  annotation (Icon(graphics={Rectangle(
          extent={{-54,-22},{-18,-54}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
                             Text(
          extent={{-58,-22},{-14,-56}},
          textColor={238,46,47},
          textString="R",
          textStyle={TextStyle.Italic})}));
end EquivalentGridR;
