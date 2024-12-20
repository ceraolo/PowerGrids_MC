within PowerGridsMC.Electrical.Loads;
model LoadImpedancePQ_R
  "Load model with impedance specified by PRef and QRef"

//    PFout[1,1]=port.U;
//    PFout[1,2]=port.UPhase;
//    PFout[1,3]=port.P;
//    PFout[1,4]=port.Q;
//    PFout[1,5]=port.VPu;
//    PFout[1,6]=port.PPu;
//    PFout[1,7]=port.QPu;

  extends LoadImpedancePQ(PStart=PFout[1,3], PRefConst=PFout[1,3],
     QStart=PFout[1,4], QRefConst=PFout[1,4], URef=PFout[1,1],
     UStart=PFout[1,1], UPhaseStart=PFout[1,2]);

 //Code to read output from previous PowerFlow run:
  final parameter String name = getInstanceName();
  final parameter String nameShort = PowerGridsMC.Functions.giveShortName(name);
  final parameter Real PFout[:, :] = Modelica.Utilities.Streams.readRealMatrix(nameShort + ".mat", "y", 1, 7);

  parameter Boolean showPFdata=true "=true, if PowerFlow data are to be shown";

  annotation (Icon(graphics={Text(
          extent={{-70,-4},{-26,-38}},
          textColor={162,29,33},
          textStyle={TextStyle.Italic},
          textString="R"),
       Text(
          visible=showPFdata,
          extent={{-110,56},{0,26}},
          lineColor={238,46,47},
          textString=DynamicSelect("P", String(PGenPu, significantDigits=3))),
       Text(
          visible=showPFdata,
          extent={{-2,56},{112,26}},
          lineColor={217,67,180},
          textString=DynamicSelect("Q", String(QGenPu, significantDigits=3)))}),
                                           Documentation(info="<html>
<p><i><span style=\"font-size: 12pt;\">Library PowerGridsMC is forked from https://github.com/PowerGrids/PowerGrids.</span></i></p>
<p>************************** </p>
<p>Model of a fixed impedance load, whose value is specified by the reference values <code>PRef</code>, 
<code>QRef</code>, and <code>URef</code>.</p>
<p>This is a  component not existing in the original library. It has the peculiarity that reads the PowerFlow data from a file automatically generated in a previous PowerFlow study. </p>
<p>The data is stored and retrieved based on the instance name. Therefore, for an effective Powerflow-&gt;Transient chaining, the instance name of the PowerFlow writing and Transient reading models must be the same.</p>
<p>Examples on this usage are supplied in the &quot;Examples.PFT&quot; package </p>
</html>", revisions="<html>
<p>Created by Massimo Ceraolo based on original PowerGrid&apos;s LoadPQVoltageDependence on November 2024</p>
</html>"));

end LoadImpedancePQ_R;
