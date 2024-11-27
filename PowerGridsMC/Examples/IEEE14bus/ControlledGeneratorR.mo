within PowerGridsMC.Examples.IEEE14bus;
model ControlledGeneratorR
//    y[1,1]=port.U;
//    y[1,2]=port.UPhase;
//    y[1,3]=port.P;
//    y[1,4]=port.Q;
//    y[1,5]=port.VPu;
//    y[1,6]=port.PPu;
//    y[1,7]=port.QPu;

//    PStart=y[1, 3],
//    QStart=y[1, 4],
//    UStart=y[1, 1],
//    UPhaseStart=y[1, 2],


  extends ControlledGeneratorIEEE(GEN( PStart=y[1,3],QStart =y[1,4],
  UStart=y[1,1],UPhaseStart=y[1,2]),
    PmRefPuDef(y=-y[1, 6]),
    VrefPuDef(y=1),
    VrefPu(fixedOffset=false));

  //Code to read output from previous PowerFlow run:
  final parameter String name = getInstanceName();
  final parameter String nameShort = PowerGridsMC.Functions.giveShortName(name);
  parameter Real y[:,:] = Modelica.Utilities.Streams.readRealMatrix(
          nameShort+".mat","y",1,7);


  annotation (Icon(graphics={Text(
          extent={{-102,-64},{-58,-98}},
          textColor={238,46,47},
          textStyle={TextStyle.Italic},
          textString="S")}), Documentation(info="<html>
<p><i><span style=\"font-size: 12pt;\">Library PowerGridsMC is forked from https://github.com/PowerGrids/PowerGrids.</span></i></p>
<p>************************** </p>
<p>This is a new component not existing in the original library. It has the peculiarity that reads from an automatically generated file the data from a previously executed PowerFlow. </p>
<p>The data is stored and retrieved based on the instance name. Therefore, for an effective Powerflo-&gt;Transient chaining the instance name of the PowerFlow writing and Transient reading models must be the same.</p>
</html>"));
end ControlledGeneratorR;
