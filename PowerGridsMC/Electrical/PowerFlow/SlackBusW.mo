﻿within PowerGridsMC.Electrical.PowerFlow;
model SlackBusW "Slack Bus - Save PF data"

  extends SlackBus;

  // Modifications to allow data exchange with simulations:
  final parameter String name = getInstanceName();
  String nameShort;
  Integer index;
  Real out[1,7];

algorithm
  // remove path before instance name.
  when initial() then
    index :=Modelica.Utilities.Strings.findLast(name, ".");
    nameShort :=Modelica.Utilities.Strings.substring(
      name,
      index+1,
      Modelica.Utilities.Strings.length(name));
  end when;

equation
  when initial() then
    out[1,1]=port.U;
    out[1,2]=port.UPhase;
    out[1,3]=port.P;
    out[1,4]=port.Q;
    out[1,5]=port.VPu;
    out[1,6]=port.PPu;
    out[1,7]=port.QPu;
    Modelica.Utilities.Streams.writeRealMatrix(
      nameShort+".mat",  "y", out);
    Modelica.Utilities.Streams.print(
      "### PVBus model full path: '" + name+".mat" + "'");
    Modelica.Utilities.Streams.print(
      "*** PVBus model short path: '" + nameShort+".mat" + "'");
  end when;

  annotation (
  Icon(graphics={
    Text(
      visible=showPFdata,
      extent={{-170,46},{-32,12}},
      lineColor={28,108,200},
      textString=DynamicSelect("V", String(port.U/port.UNom, significantDigits=3))),
    Text(
      visible=showPFdata,
      extent={{-164,-12},{-28,-46}},
      lineColor={28,108,200},
      textString=DynamicSelect("Uph", String(port.UPhase*180/3.14159265359, format = "4.1f")+"°")),
    Text(
      extent={{36,-12},{80,-46}},
      textColor={162,29,33},
      textStyle={TextStyle.Italic},
          textString="W")}),
   Documentation(info="<html>
<p><i><span style=\"font-size: 12pt;\">Library PowerGridsMC is forked from https://github.com/PowerGrids/PowerGrids.</span></i></p>
<p>************************** </p>
<p>This is a new component not existing in the original library. It has the peculiarity that writes on an automatically generated file the PowerFlow data, that can be automatically retrieved by a corresponding subsequent transient model. </p>
<p>The data is stored and retrieved based on the instance name. Therefore, for an effective Powerflow-&gt;Transient chaining, the instance name of the PowerFlow writing and Transient reading models must be the same. </p>
<p>Examples on this usage are supplied in the &quot;Examples.PFT&quot; package</p>
</html>", revisions="<html>
<p>Created by Massimo Ceraolo based on original PowerGrid&apos;s SlackBus on November 2024</p>
</html>"));
end SlackBusW;
