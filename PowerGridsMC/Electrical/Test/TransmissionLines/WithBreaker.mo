within PowerGridsMC.Electrical.Test.TransmissionLines;
package WithBreaker
  extends Modelica.Icons.ExamplesPackage;
  model TestTwoBusesTwoLinesOneLoadOneBreakerOpenClosePortsAB
    extends TestTwoBusesTwoTransmLinesWithBreakersOneLoad(transmissionLine1(
                                                          useBreakerB                   = true, portVariablesPu                   = true, useBreakerA                   = true),
        transmissionLine2(                                                                                                                                                      portVariablesPu                   = true, useBreakerA                   = true, useBreakerB                   = true));
    Modelica.Blocks.Sources.BooleanExpression BreakerStatusLine1AB(y = time < 1 or time >= 2)  annotation (
      Placement(transformation(origin = {-30, 30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Sources.BooleanExpression BreakerStatusLine2A(y = time < 3 or time >= 5)  annotation (
      Placement(transformation(origin = {22, 28}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Sources.BooleanExpression BreakerStatusLine2B(y = time < 4 or time >= 5)  annotation (
      Placement(transformation(origin = {36, 28}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  equation
    connect(BreakerStatusLine2B.y, transmissionLine2.breakerStatusB) annotation (
      Line(points = {{36, 17}, {36, 17}, {36, 1}, {38, 1}}, color = {255, 0, 255}));
    connect(BreakerStatusLine2A.y, transmissionLine2.breakerStatusA) annotation (
      Line(points = {{22, 17}, {22, 17}, {22, 1}, {24, 1}}, color = {255, 0, 255}));
    connect(BreakerStatusLine1AB.y, transmissionLine1.breakerStatusB) annotation (
      Line(points = {{-30, 19}, {-30, 19}, {-30, 11}, {-22, 11}, {-22, 1}, {-22, 1}}, color = {255, 0, 255}));
    connect(BreakerStatusLine1AB.y, transmissionLine1.breakerStatusA) annotation (
      Line(points = {{-30, 19}, {-30, 19}, {-30, 11}, {-38, 11}, {-38, 1}, {-36, 1}}, color = {255, 0, 255}));
    annotation (
      Icon(coordinateSystem(grid = {0.1, 0.1})),
      Diagram(coordinateSystem(extent = {{-80, 80}, {80, -20}})),
      experiment(StopTime = 9, Interval = 0.018, StartTime = 0, Tolerance = 1e-06),
      Documentation(info = "<html><head></head><body><p style=\"font-size: 12px;\">Same behaviour as&nbsp;<a href=\"modelica://PowerGridsMC.Electrical.Test.TransmissionLines.WithBreaker.TestTwoBusesTwoTransmLinesWithBreakersOneLoad\">TestTwoBusesTwoTransmLinesWithBreakersOneLoad</a>,&nbsp;but this time:</p><p style=\"font-size: 12px;\"></p><ul><li>both the breakers of the line1 are opened in the time interval from t=1 to t=2 seconds,</li><li>the breaker at portA of the line2 is opened in the time interval from t=3 to t=5 seconds,</li><li>the breaker at portB of the line 2 is opened in the time interval from t=4 to t=5 seconds.</li></ul><p></p><p style=\"font-size: 12px;\">When the line 1 is detached (both breakers open) the active power on from the line2 is doubled and the power from the infiniteBus1 becomes null.</p><p style=\"font-size: 12px;\">When the breaker at portA of the line2 is opened the active power from the line1 is doubled and the active power from the infiniteBus2 is reduced to the ones dissipated to the open line (i.e. Rseries+Rshunt).</p><p style=\"font-size: 12px;\">When also the breaker at portB of the line2 is opened the active power from the infiniteBus2 becomes null.</p></body></html>"));
  end TestTwoBusesTwoLinesOneLoadOneBreakerOpenClosePortsAB;

  model TestTwoBusesTwoLinesOneLoadOneBreakerOpenClosePortB
    extends TestTwoBusesTwoTransmLinesWithBreakersOneLoad(transmissionLine1(
                                                          useBreakerB                   = true));
    Modelica.Blocks.Sources.BooleanExpression BreakerStatus(y = time < 1 or time >= 10)  annotation (
      Placement(visible = true, transformation(origin = {-24, 22}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  equation
    connect(transmissionLine1.breakerStatusB, BreakerStatus.y) annotation (
      Line(points = {{-22, 2}, {-24, 2}, {-24, 12}, {-24, 12}}, color = {255, 0, 255}));
    annotation (
      Icon(coordinateSystem(grid = {0.1, 0.1})),
      Diagram(coordinateSystem(extent = {{-80, 80}, {80, -20}})),
      experiment(StopTime = 20, Interval = 0.04, StartTime = 0, Tolerance = 1e-06),
      Documentation(info = "<html><head></head><body><p style=\"font-size: 12px;\">Same behaviour as&nbsp;<a href=\"modelica://PowerGridsMC.Electrical.Test.TransmissionLines.WithBreaker.TestTwoBusesTwoTransmLinesWithBreakersOneLoad\">TestTwoBusesTwoTransmLinesWithBreakersOneLoad</a>,&nbsp;but this time the breaker at portB of the line1 is opened in the time interval 1 to 10 seconds.</p><p style=\"font-size: 12px;\">When the breaker is open, the active power from line 2 is doubled, while the active power from the infiniteBus1 is reduced to the ones dissipated to the open line (i.e. Rseries+Rshunt).</p></body></html>"));
  end TestTwoBusesTwoLinesOneLoadOneBreakerOpenClosePortB;

  model TestTwoBusesTwoLinesOneLoadOneBreakerOpenClosePortA
    extends TestTwoBusesTwoTransmLinesWithBreakersOneLoad(transmissionLine2(
                                                          useBreakerA                   = true));
    Modelica.Blocks.Sources.BooleanExpression BreakerStatus(y = time < 1 or time >= 10)  annotation (
      Placement(visible = true, transformation(origin={0,14},     extent = {{-10, -10}, {10, 10}}, rotation=0)));
  equation
    connect(BreakerStatus.y, transmissionLine2.breakerStatusA) annotation (
      Line(points={{11,14},{14,14},{14,1},{23,1}},          color = {255, 0, 255}));
    annotation (
      Icon(coordinateSystem(grid = {0.1, 0.1})),
      Diagram(coordinateSystem(extent={{-80,-20},{80,40}}, grid={2,2})),
      experiment(StopTime = 20, Interval = 0.04, StartTime = 0, Tolerance = 1e-06),
      Documentation(info = "<html><head></head><body><p><span style=\"font-size: 12px;\">Same behaviour as&nbsp;</span><a href=\"modelica://PowerGridsMC.Electrical.Test.TransmissionLines.WithBreaker.TestTwoBusesTwoTransmLinesWithBreakersOneLoad\" style=\"font-size: 12px;\">TestTwoBusesTwoTransmLinesWithBreakersOneLoad</a><span style=\"font-size: 12px;\">,&nbsp;</span>but this time the breaker at portA of the line2 is opened in the time interval 1 to 10 seconds.</p><p>When the breaker is open, the active power from line 1 is doubled, while the active power from the infiniteBus2 is reduced to the ones dissipated to the open line (i.e. Rseries+Rshunt).</p><p><br></p><p><br></p><p><br></p></body></html>"));
  end TestTwoBusesTwoLinesOneLoadOneBreakerOpenClosePortA;

  model TestTwoBusesTwoTransmLinesWithBreakersOneLoad
    extends Modelica.Icons.Example;
    PowerGridsMC.Electrical.Buses.InfiniteBus infiniteBus1(SNom = 1e+07, UNom = 10000, portVariablesPu = true, theta = 0.523599) annotation (
      Placement(visible = true, transformation(origin={-54,0},    extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    PowerGridsMC.Electrical.Loads.LoadAlphaBeta loadPQ(
      PRefConst=1e+07,
      QRefConst=0,
      SNom=1e+07,
      UNom=10000,
      alpha=0,
      beta=0,
      portVariablesPhases=true) annotation (Placement(visible=true,
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=0)));
    inner PowerGridsMC.Electrical.System systemPowerGrids annotation (
      Placement(transformation(origin={30,30},    extent = {{-10, -10}, {10, 10}})));
    PowerGridsMC.Electrical.Branches.LineConstantImpedanceWithBreakers transmissionLine1(B = 0.02, G = 0.01,R = 0.3, SNom = 1e+07, UNom = 10000, X = 1.5, portVariablesPu = true) annotation (
      Placement(visible = true, transformation(origin={-30,0},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PowerGridsMC.Electrical.Branches.LineConstantImpedanceWithBreakers transmissionLine2(B = 0.02, G = 0.01,R = 0.3, SNom = 1e+07, UNom = 10000, X = 1.5, portVariablesPu = true) annotation (
      Placement(visible = true, transformation(origin={30,0},   extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PowerGridsMC.Electrical.Buses.InfiniteBus infiniteBus2(SNom = 1e+07, UNom = 10000, portVariablesPu = true, theta = 0.523599) annotation (
      Placement(visible = true, transformation(origin={62,0},    extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  equation
    connect(transmissionLine2.terminalB, infiniteBus2.terminal) annotation (
      Line(points={{40,0},{62,0}}));
    connect(loadPQ.terminal, transmissionLine2.terminalA) annotation (
      Line(points={{0,0},{20,0}}));
    connect(transmissionLine1.terminalB, loadPQ.terminal) annotation (
      Line(points={{-20,0},{0,0}}));
    connect(infiniteBus1.terminal, transmissionLine1.terminalA) annotation (
      Line(points={{-54,0},{-40,0}}));
    annotation (
      Icon(coordinateSystem(grid = {0.1, 0.1})),
      Diagram(coordinateSystem(extent={{-70,-20},{70,40}}, grid={2,1})),
      experiment(StopTime = 1, Interval = 0.02),
      Documentation(info = "<html><head></head><body><p><span style=\"font-size: 12px;\">Same behaviour as&nbsp;</span><a href=\"modelica://PowerGridsMC.Electrical.Test.TransmissionLines.WithBreaker.TestOneBusTransmissionLineWithBreakersOneLoad\" style=\"font-size: 12px;\">TestOneBusTransmissionLineWithBreakersOneLoad</a><span style=\"font-size: 12px;\">, but this time the load is supplied by two identical lines. 
The system is symmetrical, so the active power is equally divided between the two lines.
The breakers are kept closed and all electrical parameters are the same of the OneBusTransmissionLineShuntOneLoad test for each line and for the load.</span></p></body></html>"));
  end TestTwoBusesTwoTransmLinesWithBreakersOneLoad;

  model TestOneBusTransmissionLineWithBreakersOneLoad
    extends Modelica.Icons.Example;
    PowerGridsMC.Electrical.Buses.InfiniteBus infiniteBus(SNom = 1e+07, UNom = 10000, portVariablesPu = true, theta = 0.523599) annotation (
      Placement(visible = true, transformation(origin = {-40, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    PowerGridsMC.Electrical.Loads.LoadAlphaBeta loadPQ(
      PRefConst=1e+07,
      QRefConst=0,
      SNom=1e+07,
      UNom=10000,
      alpha=0,
      beta=0,
      portVariablesPhases=true) annotation (Placement(visible=true,
          transformation(
          origin={20,0},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    inner PowerGridsMC.Electrical.System systemPowerGrids annotation (
      Placement(transformation(origin = {30, 50}, extent = {{-10, -10}, {10, 10}})));
    PowerGridsMC.Electrical.Branches.LineConstantImpedanceWithBreakers transmissionLine(B = 0.02, G = 0.01,R = 0.3, SNom = 1e+07, UNom = 10000, X = 1.5, portVariablesPu = true) annotation (
      Placement(visible = true, transformation(origin = {-10, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(infiniteBus.terminal, transmissionLine.terminalA) annotation (
      Line(points = {{-40, 0}, {-20, 0}}));
    connect(transmissionLine.terminalB, loadPQ.terminal) annotation (
      Line(points = {{0, 0}, {20, 0}}));
    annotation (
      Icon(coordinateSystem(grid = {0.1, 0.1})),
      Diagram(coordinateSystem(extent = {{-60, 60}, {40, -20}})),
      experiment(StopTime = 1, Interval = 0.02),
      Documentation(info = "<html><head></head><body><p>Same behaviour as <a href=\"modelica://PowerGridsMC.Electrical.Test.TransmissionLines.OneBusTransmissionLineShuntOneLoad\">OneBusTransmissionLineShuntOneLoad</a>, but this time the line has two breakers, one for each port. The breakers are kept closed and all electrical quantities are the same of the OneBusTransmissionLineShuntOneLoad test.
</body></html>"));
  end TestOneBusTransmissionLineWithBreakersOneLoad;
end WithBreaker;
