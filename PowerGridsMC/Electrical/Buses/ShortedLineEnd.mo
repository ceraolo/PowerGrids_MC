within PowerGridsMC.Electrical.Buses;
model ShortedLineEnd
  extends Icons.Ground;
  PowerGridsMC.Interfaces.TerminalAC terminal annotation (
    Placement(visible = true, transformation(                    extent={{-32,-32},
            {32,32}},                                                                                 rotation = 0), iconTransformation(origin={
            -3.55271e-15,98},                                                                                                                                                 extent = {{-8, -8}, {8, 8}}, rotation = 0)));
equation
  terminal.v = Complex(0);
  annotation (Icon(graphics={                                                                                                                                                              Text(origin={0,125},    lineColor = {0, 0, 255}, extent={{-100,11},
              {100,-11}},                                                                                                                                                                                                        textString = "%name"),
        Line(points={{0,90},{-24,36},{40,60},{0,-30}}, color={238,46,47}),
        Polygon(
          points={{2,-8},{14,-16},{0,-28},{2,-8}},
          lineColor={238,46,47},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}));
end ShortedLineEnd;
