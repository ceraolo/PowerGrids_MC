within PowerGridsMC.Electrical.Buses;
model EquivalentGridR

 //    y[1,1]=port.U;
//    y[1,2]=port.UPhase;
//    y[1,3]=port.P;
//    y[1,4]=port.Q;
//    y[1,5]=port.VPu;
//    y[1,6]=port.PPu;
//    y[1,7]=port.QPu;

//    PStart=GEN_.y[1, 3],
//    QStart=GEN_.y[1, 4],
//    UStart=GEN_.y[1, 1],
//    URef=GRID_.y[1, 1],
//    UPhaseStart=GEN_.y[1, 2],


  extends EquivalentGrid( PStart=y[1,3], QStart=y[1,4], UStart=y[1,1],
URef=y[1,1], UPhaseStart=y[1,2]);


  //Code to read output from previous PowerFlow run:
  final parameter String name = getInstanceName();
  final parameter String nameShort = PowerGridsMC.Functions.giveShortName(name);
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
          textStyle={TextStyle.Italic})}), Documentation(info="<html>
<p><i><span style=\"font-size: 12pt;\">Library PowerGridsMC is forked from https://github.com/PowerGrids/PowerGrids.</span></i></p>
<p>************************** </p>
<p>This is a new component not existing in the original library. It has the peculiarity that reads the PowerFlow data from a file automatically generated in a previous PowerFlow study. </p>
<p>The data is stored and retrieved based on the instance name. Therefore, for an effective Powerflow-&gt;Transient chaining, the instance name of the PowerFlow writing and Transient reading models must be the same.</p>
<p>Examples on this usage are supplied in the &quot;Examples.PFT&quot; package </p>
</html>"));
end EquivalentGridR;