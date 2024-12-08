within PowerGridsMC.Examples.IEEE14bus;
model SynchronousCondenserR
  "Model of a synchronous condenser for the IEEE-14 bus system; Reads PF from file"
//    y[1,1]=port.U;
//    y[1,2]=port.UPhase;
//    y[1,3]=port.P;
//    y[1,4]=port.Q;
//    y[1,5]=port.VPu;
//    y[1,6]=port.PPu;
//    y[1,7]=port.QPu;

  extends ControlledGenNoPSS(   GEN( PStart=y[1,3],QStart =y[1,4],
  UStart=y[1,1],UPhaseStart=y[1,2]),
    PmRefPuDef(y=-y[1, 6]),
    VrefPuDef(y=y[1, 5]),
    VrefPu(fixedOffset=false),
    PmRefPu(use_u=true));

  //Code to read output from previous PowerFlow run:
  final parameter String name = getInstanceName();
  final parameter String nameShort = PowerGridsMC.Functions.giveShortName(name);
  final parameter Real y[:,:] = Modelica.Utilities.Streams.readRealMatrix(
          nameShort+".mat","y",1,7);

  annotation (Icon(graphics={Text(
          extent={{48,-56},{92,-90}},
          textColor={162,29,33},
          textStyle={TextStyle.Italic},
          textString="R"),
        Rectangle(
          extent={{-78,-20},{-54,-38}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-90,-20},{-54,-36}},
          textColor={0,0,0},
          textString="0")}),
             Documentation(info="<html>
<p><i><span style=\"font-family: Arial; font-size: 12pt;\">Library PowerGridsMC was forked from https://github.com/PowerGrids/PowerGrids on 22 November 2024.</span></i></p>
<p>************************** </p>
<p>This is a new component not existing in the original library. It has the peculiarity that reads from an automatically generated file the data from a previously executed PowerFlow. </p>
<p>The data is stored and retrieved based on the instance name. Therefore, for an effective Powerflo-&gt;Transient chaining the instance name of the PowerFlow writing and Transient reading models must be the same.</p>
</html>"));
end SynchronousCondenserR;
