within PowerGridsMC.Electrical.Banks;
model CapacitorBankFixed "Capacitor bank with fixed capacitance"
  extends Icons.CapacitorBank;
  extends BaseClasses.ShuntConductance(Y = Complex(0,B));
  parameter Types.Susceptance B = 0 "Capacitor bank susceptance";

  parameter Boolean showPortData=true "if Port Data are shown in diagram (P&Q or U)";
    outer Electrical.System systemPowerGrids "Reference to system object";
  parameter Boolean showDataOnDiagramsPu = systemPowerGrids.showDataOnDiagramsPu
   "=true, P,Q,V and phase are shown on the diagrams in per-unit of local machine base"
   annotation(Dialog(tab = "Visualization"));

  annotation (Icon(graphics={
       Text(
          visible=showPortData,
          extent={{-2,44},{104,22}},
          lineColor={217,67,180},
          textString=DynamicSelect("Q",
            if showDataOnDiagramsPu then
               String(-port.QGenPu, format = "6.3f")
             else
               String(port.S.im/1e6, format = "9.2f")))}));
end CapacitorBankFixed;
