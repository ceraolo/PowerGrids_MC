within PowerGridsMC.Electrical.Loads;
model LoadPQVoltageDependenceR

//    y[1,1]=port.U;
//    y[1,2]=port.UPhase;
//    y[1,3]=port.P;
//    y[1,4]=port.Q;
//    y[1,5]=port.VPu;
//    y[1,6]=port.PPu;
//    y[1,7]=port.QPu;

//    PStart=GRIDL_.y[1, 3],
//    PRefConst=GRIDL_.y[1, 3],
//    QStart=GRIDL_.y[1, 4],
//    QRefConst=GRIDL_.y[1, 4],
//    URef=GRIDL_.y[1, 1],
//    UStart=GRIDL_.y[1, 1],
//    UPhaseStart=GRIDL_.y[1, 2],


  extends LoadPQVoltageDependence(PStart=y[1,3], PRefConst=y[1,3],
     QStart=y[1,4], QRefConst=y[1,4], URef=y[1,1],
     UStart=y[1,1], UPhaseStart=y[1,2]);

 //Code to read output from previous PowerFlow run:
  final parameter String name = getInstanceName();
  final parameter String nameShort = PowerGridsMC.Functions.giveShortName(name);
  parameter Real y[:, :] = Modelica.Utilities.Streams.readRealMatrix(nameShort + ".mat", "y", 1, 7);

  annotation (Icon(graphics={Text(
          extent={{-62,16},{-18,-18}},
          textColor={238,46,47},
          textString="R",
          textStyle={TextStyle.Italic})}));
end LoadPQVoltageDependenceR;
