within PowerGridsMC.Examples.Tutorial.GridOperation.Controlled;
model ControlledGenPSS_R
  "Model of a synchronous generator with governor, AVR, and PSS"

//    y[1,1]=port.U;
//    y[1,2]=port.UPhase;
//    y[1,3]=port.P;
//    y[1,4]=port.Q;
//    y[1,5]=port.VPu;
//    y[1,6]=port.PPu;
//    y[1,7]=port.QPu;


  extends ControlledGenPSS(     GEN( PStart=y[1,3],QStart =y[1,4],
  UStart=y[1,1],UPhaseStart=y[1,2]),
    VrefPu(fixedOffset=false));

  //Code to read output from previous PowerFlow run:
  final parameter String name = getInstanceName();
  final parameter String nameShort = PowerGridsMC.Functions.giveShortName(name);
  final parameter Real y[:,:] = Modelica.Utilities.Streams.readRealMatrix(
          nameShort+".mat","y",1,7);

  parameter Boolean showPortData=true "if Port Data are shown in diagram (P&Q or U)";
  outer Electrical.System systemPowerGrids "Reference to system object";
  parameter Boolean showDataOnDiagramsPu = systemPowerGrids.showDataOnDiagramsPu
   "=true, P,Q,V and phase are shown on the diagrams in per-unit of local machine base"
   annotation(Dialog(tab = "Visualization"));


equation
  connect(GEN.ufPuIn, AVR.efdPu) annotation (
    Line(points={{23.6,-4},{16,-4},{16,-16},{9,-16}},         color = {0, 0, 127}));
  connect(TGOV.PMechPu, GEN.pmPuIn) annotation (Line(points={{8,28},{16,28},{16,
          3.4},{23.6,3.4}}, color={0,0,127}));
  connect(GEN.VPu, AVR.VcPu) annotation (
    Line(points={{44.2,-6},{74,-6},{74,54},{-70,54},{-70,-14},{-12,-14}},           color = {0, 0, 127}));
  connect(PSS.VstPu, AVR.VsPu) annotation (
    Line(points={{-27,0},{-20,0},{-20,-10},{-12,-10}},         color = {0, 0, 127}));
  connect(PSS.Vsi2Pu, GEN.PPu) annotation (
    Line(points={{-48.2,-6},{-64,-6},{-64,48},{70,48},{70,-2},{44.2,-2}},          color = {0, 0, 127}));
  connect(GEN.terminal, terminal) annotation (
    Line(points={{34,0},{34,26}}));
  connect(RefLPu.y, TGOV.RefLPu) annotation (
    Line(points={{-27,24},{-12,24}},     color = {0, 0, 127}));
  connect(VrefPu.y, AVR.VrefPu) annotation (
    Line(points={{-29,-30},{-24,-30},{-24,-18},{-12,-18}},         color = {0, 0, 127}));
  connect(GEN.omegaPu, TGOV.omegaPu) annotation (
    Line(points={{44.2,2},{66,2},{66,44},{-20,44},{-20,32},{-12,32}},           color = {0, 0, 127}));
  connect(AVR.VuelPu, zero.y) annotation (
    Line(points={{-12,-22},{-18,-22},{-18,-52},{-28.8,-52}},                   color = {0, 0, 127}));
  connect(GEN.omegaPu, PSS.Vsi1Pu) annotation (
    Line(points={{44.2,2},{66,2},{66,44},{-58,44},{-58,6},{-48,6}},                      color = {0, 0, 127}));
  connect(GEN.omega, omega) annotation (
    Line(points={{44.3,5.9},{48,5.9},{48,12},{58,12}},              color = {0, 0, 127}));
  annotation (
    Icon(coordinateSystem(grid={2,2}), graphics={
      Text(
          extent={{50,-58},{94,-92}},
          textColor={162,29,33},
          textStyle={TextStyle.Italic},
          textString="R"),
       Text(
          visible=showPortData,
          extent={{-114,66},{-4,30}},
          lineColor={238,46,47},
          textString=DynamicSelect("P",
             if showDataOnDiagramsPu then
               String(-GEN.port.PGenPu, format = "6.3f")
             else
               String(GEN.port.P/1e6, format = "9.2f"))),
       Text(
          visible=showPortData,
          extent={{2,66},{122,32}},
          lineColor={217,67,180},
          textString=DynamicSelect("Q",
            if showDataOnDiagramsPu then
              String(-GEN.port.QGenPu, format = "6.3f")
            else
              String(GEN.port.Q/1e6, format = "9.2f")))}

),  Diagram(coordinateSystem(    extent={{-80,-60},{80,60}})));
end ControlledGenPSS_R;
