within PowerGridsMC.Electrical.Test;
model TestGridModels "Test case EquivalentGrid model"
  extends Modelica.Icons.Example;
  import Modelica.ComplexMath;
  inner PowerGridsMC.Electrical.System systemPowerGrids annotation (
    Placement(transformation(origin={30,10},    extent = {{-10, -10}, {10, 10}})));
  PowerGridsMC.Electrical.Buses.InfiniteBus voltageSource( SNom = 5e+08,
      UNom = 380000,
      URef = 380000,
      portVariablesPhases = true,
      portVariablesPu = true) annotation (
    Placement(visible = true, transformation(origin={-58,-14},   extent={{-10,10},
            {10,-10}},                                                                            rotation = 90)));
  PowerGridsMC.Electrical.Branches.LineConstantImpedance eqLine(
    R=6.32207,
    SNom=500000000,
    UNom=380000,
    X=63.2207,
    portVariablesPhases=true,
    portVariablesPu=true) annotation (Placement(visible=true, transformation(
        origin={-20,-14},
        extent={{10,-10},{-10,10}},
        rotation=0)));
  Buses.EquivalentGrid equivalentGrid(R_X = 1 / 10, SNom = 5e+08,
      SSC = 2.5e+09,
      UNom = 380000,
      URef = 1.050 * 380e3, c = 1.1,
      portVariablesPhases = true,
      portVariablesPu = true)  annotation (
    Placement(visible = true, transformation(origin={-52,20},  extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Buses.ShortedLineEnd shortedEnd annotation (Placement(visible=true,
        transformation(
        origin={10,-16},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  PowerGridsMC.Electrical.Loads.LoadAlphaBeta load(
    PRefConst=1e+07,
    QRefConst=2e+07,
    SNom=5e+08,
    UNom=380000,
    portVariablesPhases=true) annotation (Placement(visible=true,
        transformation(
        origin={-20,20},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Branches.LineConstantImpedance eqLine1(
    R=6.32207,
    SNom=500000000,
    UNom=380000,
    X=63.2207,
    portVariablesPhases=true,
    portVariablesPu=true) annotation (Placement(visible=true, transformation(
        origin={-20,-30},
        extent={{10,-10},{-10,10}},
        rotation=0)));
  PowerGridsMC.Electrical.Loads.LoadAlphaBeta  load1(
    PRefConst=1e+07,
    QRefConst=2e+07,
    SNom=5e+08,
    UNom=380000,
    portVariablesPhases=true) annotation (Placement(visible=true,
        transformation(
        origin={34,-24},
        extent={{-10,-10},{10,10}},
        rotation=0)));
equation
  connect(shortedEnd.terminal, eqLine.terminalA)
    annotation (Line(points={{10,-6.2},{-4,-6.2},{-4,-14},{-10,-14}}));
  connect(eqLine.terminalB, voltageSource.terminal)
    annotation (Line(points={{-30,-14},{-58,-14}}));
  connect(eqLine1.terminalB, voltageSource.terminal) annotation (Line(points={{
          -30,-30},{-40,-30},{-40,-14},{-58,-14}}, color={0,0,0}));
  connect(load1.terminal, eqLine1.terminalA) annotation (Line(points={{34,-24},
          {16,-24},{16,-30},{-10,-30}}, color={0,0,0}));
  connect(equivalentGrid.terminal, load.terminal)
    annotation (Line(points={{-52,20},{-20,20}},
                                               color={0,0,0}));
  annotation (
    Diagram(coordinateSystem(extent={{-80,-40},{60,40}}), graphics={Text(
          extent={{-72,-26},{-56,-32}},
          textColor={28,108,200},
          textString="Null 
imternal 
impedance")}),
    __OpenModelica_commandLineOptions = "",
  Documentation(info="<html>
<p><i><span style=\"font-family: Arial;\">Library PowerGridsMC was forked from https://github.com/PowerGrids/PowerGrids on 22 November 2024.</span></i></p>
<p><i><span style=\"font-family: Arial;\">This model is derivedfrom the model &quot;TestEquiivalentGrid of the original Powergrid, but has been changed in contents and purposes.</span></i></p>
<p><i><span style=\"font-family: Arial;\">therefore the description below does not consider the original description od testRquivalentgrid</span></i></p>
<p>************************</p>
<p>In Powergr4idsMC ewququivalent grids can ge implemented using either equivalentGrid or VoltageSource components:</p>
<ul>
<li>EquivalentGrid has its internal impedance defined in terms of scroti circuit power, wuyile </li>
<li>VoltageSource has the same impedance expressed in terms of internal resistance and reactance.</li>
</ul>
<p>Moreover, equivalentGrid contains the parameter &quot;c&quot; present in IEEE 60909 eq. 4.</p>
<p>Obviously, the two models must give the same results in comparable situations. Here, the equivalent grid has its intermal impedance defined through mask&apos;s paramerters, while voltageSource has them set equal to zero; the corresponding values of R and X are put outside the component, in the eqLine and eqLine1 components.</p>
<p>The lower model, using Voltage Source, gives the load the exact power of the upper model; moreover, the lower model is also shorted shoing that it delivers the shor the SSC, as definidef for both grids.</p>
<p>All powers can be seen directly on the diagram, using the built-in dynamic text of the library.</p>
</html>"));
end TestGridModels;
