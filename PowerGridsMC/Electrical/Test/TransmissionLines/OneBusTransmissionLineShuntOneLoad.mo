within PowerGridsMC.Electrical.Test.TransmissionLines;
model OneBusTransmissionLineShuntOneLoad
  extends TransmissionLines.OneBusTransmissionLineOneLoad(transmissionLine(
      B=0.02,
      G=0.01,
      portVariablesPu=true));
  annotation (
    Diagram(coordinateSystem(extent={{-60,-20},{60,40}}, grid={2,2})),
    experiment(StopTime = 1, Interval = 0.02),
    Documentation(info = "<html><head></head><body><p>This model is similar to<a href=\"modelica://PowerGridsMC.Electrical.Test.TransmissionLines.OneBusTransmissionLineOneLoad\">OneBusTransmissionLineOneLoad</a>, but also has nonzero shunt admittance.
</body></html>"));
end OneBusTransmissionLineShuntOneLoad;
