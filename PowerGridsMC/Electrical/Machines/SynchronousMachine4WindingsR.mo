within PowerGridsMC.Electrical.Machines;
model SynchronousMachine4WindingsR

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
//    UPhaseStart=GEN_.y[1, 2],


  extends SynchronousMachine4Windings(PStart=y[1,3],QStart=y[1,4],
UStart=y[1,1],UPhaseStart=y[1,2]);

  //Code to read output from previous PowerFlow run:
  final parameter String name = getInstanceName();
  final parameter String nameShort = PowerGridsMC.Functions.giveShortName(name);
  parameter Real y[:,:] = Modelica.Utilities.Streams.readRealMatrix(
          nameShort+".mat","y",1,7);

  annotation (Icon(graphics={Text(
          extent={{-88,-56},{-44,-90}},
          textColor={238,46,47},
          textString="R",
          textStyle={TextStyle.Italic})}));
end SynchronousMachine4WindingsR;
