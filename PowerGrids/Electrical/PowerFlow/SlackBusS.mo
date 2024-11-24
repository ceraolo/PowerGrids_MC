within PowerGrids.Electrical.PowerFlow;
model SlackBusS "Slack Bus - Save PF data"

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

  annotation (Icon(graphics={Text(
          extent={{-98,48},{-54,14}},
          textColor={238,46,47},
          textStyle={TextStyle.Italic},
          textString="S")}));
end SlackBusS;
