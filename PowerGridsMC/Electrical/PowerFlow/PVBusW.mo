within PowerGridsMC.Electrical.PowerFlow;
model PVBusW "PV bus - Save PF data on disk"

  extends PVBus;

  // Modifications to allow data exchange with simulations:
  final parameter String name = getInstanceName();
  String nameShort;
  Integer index;
  Real out[1,7];

  parameter Boolean showPortData=true "=true, if PowerFlow data are to be shown";
  outer Electrical.System systemPowerGrids "Reference to system object";
  parameter Boolean showDataOnDiagramsPu = systemPowerGrids.showDataOnDiagramsPu
   "=true, P,Q,V and phase are shown on the diagrams in per-unit of local machine base"
   annotation(Dialog(tab = "Visualization"));


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

  annotation (Icon(graphics={
      Text(
          extent={{46,-54},{90,-88}},
          textColor={162,29,33},
          textStyle={TextStyle.Italic},
          textString="W"),
       Text(
          visible=showPortData,
          extent={{-106,66},{-4,34}},
          lineColor={238,46,47},
          textString=DynamicSelect("P",
             if showDataOnDiagramsPu then
               String(-port.PGenPu, format = "6.3f")
             else
               String(port.S.re/1e6, format = "9.2f"))),
       Text(
          visible=showPortData,
          extent={{2,66},{102,34}},
          lineColor={217,67,180},
          textString=DynamicSelect("Q",
            if showDataOnDiagramsPu then
              String(-port.QGenPu, format = "6.3f")
            else
              String(port.S.im/1e6, format = "9.2f")))}),
                             Documentation(info="<html>
<p><i><span style=\"font-size: 12pt;\">Library PowerGridsMC is forked from https://github.com/PowerGrids/PowerGrids.</span></i></p>
<p>************************** </p>
<p>This is a  component not existing in the original library. It has the peculiarity that writes on an automatically generated file the PowerFlow data, that can be automatically retrieved by a corrensponding subsequent transient model. </p>
<p>The data is stored and retrieved based on the instance name. Therefore, for an effective Powerflow-&gt;Transient chaining, the instance name of the PowerFlow writing and Transient reading models must be the same.</p>
<p>Examples on this usage are supplied in the &quot;Examples.PFT&quot; package</p>
</html>", revisions="<html>
<p>Created by Massimo Ceraolo based on original PowerGrid&apos;s PVBus on November 2024</p>
</html>"));
end PVBusW;
