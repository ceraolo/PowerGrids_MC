within PowerGridsMC.Examples.IEEE14bus;
model ControlledGenNoPSS_R
//    PFout[1,1]=port.U;
//    PFout[1,2]=port.UPhase;
//    PFout[1,3]=port.P;
//    PFout[1,4]=port.Q;
//    PFout[1,5]=port.VPu;
//    PFout[1,6]=port.PPu;
//    PFout[1,7]=port.QPu;

  extends ControlledGenNoPSS(GEN(
      PStart=PFout[1, 3],
      QStart=PFout[1, 4],
      UStart=PFout[1, 1],
      UPhaseStart=PFout[1, 2]), vRefPu(fixedOffset=false));

  //Code to read output from previous PowerFlow run:
  final parameter String name = getInstanceName();
  final parameter String nameShort = PowerGridsMC.Functions.giveShortName(name);
  final parameter Real PFout[:,:] = Modelica.Utilities.Streams.readRealMatrix(
          nameShort+".mat","y",1,7);

  annotation (Icon(graphics={Text(
          extent={{48,-56},{92,-90}},
          textColor={162,29,33},
          textStyle={TextStyle.Italic},
          textString="R")}), Documentation(info="<html>
<p><i><span style=\"font-family: Arial; font-size: 12pt;\">Library PowerGridsMC was forked from https://github.com/PowerGrids/PowerGrids on 22 November 2024.</span></i></p>
<p>************************** </p>
<p>This is a new component not existing in the original library. It has the peculiarity that reads from an automatically generated file the data from a previously executed PowerFlow. </p>
<p>The data is stored and retrieved based on the instance name. Therefore, for an effective Powerflow-&gt;Transient chaining the instance name of the PowerFlow writing and Transient reading models must be the same.</p>
<p>The machine has voltage and power reference values equal to the corresponding values computed in the PowerFlow.</p>
</html>"));
end ControlledGenNoPSS_R;
