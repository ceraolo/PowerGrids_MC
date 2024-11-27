within PowerGridsMC.Examples.IEEE14bus;
model IEEE14busPowerFlow "Power flow model of the IEEE 14-bus benchmark"
  extends Modelica.Icons.Example;
  inner PowerGridsMC.Electrical.System systemPowerGrids annotation (
    Placement(transformation(origin={-130,82},    extent = {{-10, -10}, {10, 10}})));

// Buses
  PowerGridsMC.Electrical.PowerFlow.SlackBus bus1(
    SNom = 100e6,
    U = 69e3*1.0598,
    UNom = 69000)
    annotation (
    Placement(visible = true, transformation(origin = {-130, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGridsMC.Electrical.Buses.Bus bus2(
    SNom = 100e6,
    UNom = 69e3)
    annotation (
    Placement(visible = true, transformation(origin = {-90, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGridsMC.Electrical.Buses.Bus bus3(
    SNom = 100e6,
    UNom = 69e3)
    annotation (
    Placement(visible = true, transformation(origin={104,-80},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGridsMC.Electrical.Buses.Bus bus4(
    SNom = 100e6,
    UNom = 69e3)
    annotation (
    Placement(visible = true, transformation(origin={98,-40},     extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGridsMC.Electrical.Buses.Bus bus5(
    SNom = 100e6,
    UNom = 69e3)
    annotation (
    Placement(visible = true, transformation(origin = {-30, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGridsMC.Electrical.Buses.Bus bus6(
    SNom = 100e6,
    UNom = 13.8e3)
    annotation (
    Placement(visible = true, transformation(origin = {-30, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGridsMC.Electrical.Buses.Bus bus7(
    SNom = 100e6,
    UNom = 13.8e3)
    annotation (
    Placement(visible = true, transformation(origin={104,0},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGridsMC.Electrical.Buses.Bus bus8(
    SNom = 100e6,
    UNom = 13.8e3)
    annotation (
    Placement(visible = true, transformation(origin={144,20},    extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  PowerGridsMC.Electrical.Buses.Bus bus9(
    SNom = 100e6,
    UNom = 13.8e3)
    annotation (
    Placement(visible = true, transformation(origin={94,40},     extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGridsMC.Electrical.Buses.Bus bus10(
    SNom = 100e6,
    UNom = 13.8e3)
    annotation (
    Placement(visible = true, transformation(origin = {40, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGridsMC.Electrical.Buses.Bus bus11(
    SNom = 100e6,
    UNom = 13.8e3)
    annotation (
    Placement(visible = true, transformation(origin = {-10, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGridsMC.Electrical.Buses.Bus bus12(
    SNom = 100e6,
    UNom = 13.8e3)
    annotation (
    Placement(visible = true, transformation(origin = {-90, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGridsMC.Electrical.Buses.Bus bus13(
    SNom = 100e6,
    UNom = 13.8e3)
    annotation (
    Placement(visible = true, transformation(origin = {-30, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGridsMC.Electrical.Buses.Bus bus14(
    SNom = 100e6,
    UNom = 13.8e3)
    annotation (
    Placement(visible = true, transformation(origin = {30, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

// Lines
  PowerGridsMC.Electrical.Branches.LineConstantImpedance L1to2(
    portVariablesPhases = true,
    R = 0.922682,
    X = 2.81708,
    G = 0,
    B = 0.00110901,
    SNom = 100e6,
    UNom = 69e3)
    annotation (
    Placement(visible = true, transformation(origin={-136,-30},    extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  PowerGridsMC.Electrical.Branches.LineConstantImpedanceWithBreakers L1to5(
    portVariablesPhases = true,
    R = 2.57237,
    X = 10.6189,
    B = 0.0010334,
    G = 0,
    SNom = 100e6,
    UNom = 69e3)
    annotation (
    Placement(visible = true, transformation(origin = {-90, -52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGridsMC.Electrical.Branches.LineConstantImpedance L2to3(
    portVariablesPhases = true,
    R = 2.23719,
    X = 9.42535,
    G = 0,
    B = 0.000919975,
    SNom=100000000,
    UNom=69000,
    showPFdata=true)
    annotation (
    Placement(visible = true, transformation(origin = {0, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGridsMC.Electrical.Branches.LineConstantImpedance L2to4(
    portVariablesPhases = true,
    R = 2.76662,
    X = 8.3946,
    G = 0,
    B = 0.000714136,
    SNom = 100e6,
    UNom = 69e3)
    annotation (
    Placement(visible = true, transformation(origin = {40, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGridsMC.Electrical.Branches.LineConstantImpedance L2to5(
    portVariablesPhases = true,
    R = 2.71139,
    X = 8.27843,
    G = 0,
    B = 0.000726738,
    SNom = 100e6,
    UNom = 69e3)
    annotation (
    Placement(visible = true, transformation(origin = {-60, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGridsMC.Electrical.Branches.LineConstantImpedance L3to4(
    portVariablesPhases = true,
    R = 3.19035,
    X = 8.14274,
    G = 0,
    B = 0.000268851,
    SNom = 100e6,
    UNom = 69e3)
    annotation (
    Placement(visible = true, transformation(origin={104,-60},    extent = {{10, -10}, {-10, 10}}, rotation = -90)));
  PowerGridsMC.Electrical.Branches.LineConstantImpedance L4to5(
    portVariablesPhases = true,
    R = 0.635593,
    X = 2.00486,
    G = 0,
    B = 0,
    SNom = 100e6,
    UNom = 69e3)
    annotation (
    Placement(visible = true, transformation(origin = {40, -52}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  PowerGridsMC.Electrical.Branches.LineConstantImpedance L6to11(
    portVariablesPhases = true,
    R = 0.18088,
    X = 0.378785,
    G = 0,
    B = 0,
    SNom = 100e6,
    UNom = 13.8e3)
    annotation (
    Placement(visible = true, transformation(origin = {-10, 20}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
  PowerGridsMC.Electrical.Branches.LineConstantImpedance L6to12(
    portVariablesPhases = true,
    R = 0.23407,
    X = 0.487165,
    G = 0,
    B = 0,
    SNom = 100e6,
    UNom = 13.8e3)
    annotation (
    Placement(visible = true, transformation(origin = {-60, 60}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  PowerGridsMC.Electrical.Branches.LineConstantImpedance L6to13(
    portVariablesPhases = true,
    R = 0.125976,
    X = 0.248086,
    G = 0,
    B = 0,
    SNom = 100e6,
    UNom = 13.8e3)
    annotation (
    Placement(visible = true, transformation(origin = {-30, 62}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
  PowerGridsMC.Electrical.Branches.LineConstantImpedance L7to8(
    portVariablesPhases = true,
    R = 0,
    X = 0.33546,
    G = 0,
    B = 0,
    SNom = 100e6,
    UNom = 13.8e3)
    annotation (
    Placement(visible = true, transformation(origin={124,20},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGridsMC.Electrical.Branches.LineConstantImpedance L7to9(
    portVariablesPhases = true,
    R = 0,
    X = 0.209503,
    G = 0,
    B = 0,
    SNom = 100e6,
    UNom = 13.8e3)
    annotation (
    Placement(visible = true, transformation(origin={98,20},     extent = {{10, -10}, {-10, 10}}, rotation = -90)));
  PowerGridsMC.Electrical.Branches.LineConstantImpedance L9to10(
    portVariablesPhases = true,
    R = 0.060579,
    X = 0.160922,
    G = 0,
    B = 0,
    SNom = 100e6,
    UNom = 13.8e3)
    annotation (
    Placement(visible = true, transformation(origin={62,30},    extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  PowerGridsMC.Electrical.Branches.LineConstantImpedance L9to14(
    portVariablesPhases = true,
    R = 0.242068,
    X = 0.514912,
    G = 0,
    B = 0,
    SNom = 100e6,
    UNom = 13.8e3)
    annotation (
    Placement(visible = true, transformation(origin={64,72},    extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  PowerGridsMC.Electrical.Branches.LineConstantImpedance L10to11(
    portVariablesPhases = true,
    R = 0.156256,
    X = 0.365778,
    G = 0,
    B = 0,
    SNom = 100e6,
    UNom = 13.8e3)
    annotation (
    Placement(visible = true, transformation(origin = {20, 30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  PowerGridsMC.Electrical.Branches.LineConstantImpedance L12to13(
    portVariablesPhases = true,
    R = 0.42072,
    X = 0.380651,
    G = 0,
    B = 0,
    SNom=100000000,
    UNom=13800,
    showPFdata=true)
    annotation (
    Placement(visible = true, transformation(origin = {-60, 72}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGridsMC.Electrical.Branches.LineConstantImpedance L13to14(
    portVariablesPhases = true,
    R = 0.325519,
    X = 0.662763,
    G = 0,
    B = 0,
    SNom = 100e6,
    UNom = 13.8e3)
    annotation (
    Placement(visible = true, transformation(origin = {0, 72}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

// LOADS
  PowerGridsMC.Electrical.PowerFlow.PQBus Load2(
    portVariablesPhases = true,
    P = 21.7e6,
    Q = 12.7e6,
    SNom = 100e6,
    UNom = 69e3)
    annotation (
    Placement(visible = true, transformation(origin = {-90, -94}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGridsMC.Electrical.PowerFlow.PQBus Load3(
    portVariablesPhases = true,
    P = 94.2e6,
    Q = 19.1e6,
    SNom = 100e6,
    UNom = 69e3)
    annotation (
    Placement(visible = true, transformation(origin={104,-94},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGridsMC.Electrical.PowerFlow.PQBus Load4(
    portVariablesPhases = true,
    P = 47.8e6,
    Q = -3.9e6,
    SNom = 100e6,
    UNom = 69e3)
    annotation (
    Placement(visible = true, transformation(origin={120,-50},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGridsMC.Electrical.PowerFlow.PQBus Load5(
    portVariablesPhases = true,
    P = 7.6e6,
    Q = 1.6e6,
    SNom = 100e6,
    UNom = 69e3)
    annotation (
    Placement(visible = true, transformation(origin = {-50, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PowerGridsMC.Electrical.PowerFlow.PQBus Load6(
    portVariablesPhases = true,
    P = 11.2e6,
    Q = 7.5e6,
    SNom = 100e6,
    UNom = 13.8e3)
    annotation (
    Placement(visible = true, transformation(origin = {-10, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGridsMC.Electrical.PowerFlow.PQBus Load9(
    portVariablesPhases = true,
    P = 29.5e6,
    Q = 16.6e6,
    SNom = 100e6,
    UNom = 13.8e3)
    annotation (
    Placement(visible = true, transformation(origin={114,54},    extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PowerGridsMC.Electrical.PowerFlow.PQBus Load10(
    portVariablesPhases = true,
    P = 9e6,
    Q = 5.8e6,
    SNom = 100e6,
    UNom = 13.8e3)
    annotation (
    Placement(visible = true, transformation(origin={40,46},    extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PowerGridsMC.Electrical.PowerFlow.PQBus Load11(
    portVariablesPhases = true,
    P = 3.5e6,
    Q = 1.8e6,
    SNom = 100e6,
    UNom = 13.8e3)
    annotation (
    Placement(visible = true, transformation(origin={-10,46},    extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PowerGridsMC.Electrical.PowerFlow.PQBus Load12(
    portVariablesPhases = true,
    P = 6.1e6,
    Q = 1.6e6,
    SNom = 100e6,
    UNom = 13.8e3)
    annotation (
    Placement(visible = true, transformation(origin={-90,90},    extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PowerGridsMC.Electrical.PowerFlow.PQBus Load13(
    portVariablesPhases = true,
    P = 13.8e6,
    Q = 5.8e6,
    SNom = 100e6,
    UNom = 13.8e3)
    annotation (
    Placement(visible = true, transformation(origin={-30,90},    extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PowerGridsMC.Electrical.PowerFlow.PQBus Load14(
    portVariablesPhases = true,
    P = 14.9e6,
    Q = 5e6,
    SNom = 100e6,
    UNom = 13.8e3)
    annotation (
    Placement(visible = true, transformation(origin={30,90},    extent = {{-10, -10}, {10, 10}}, rotation = 180)));

// Capacitor bank
  PowerGridsMC.Electrical.Banks.CapacitorBankFixed Cbank9(
    portVariablesPhases = true,
    B = 0.099769,
    SNom = 100e6,
    UNom = 13.8e3)
    annotation (
    Placement(visible = true, transformation(origin={94,54},     extent = {{-10, -10}, {10, 10}}, rotation = 180)));

// Transformers
  PowerGridsMC.Electrical.Branches.TransformerFixedRatio T4to7(
    portVariablesPhases=true,
    R=0,
    X=0.398248,
    B=0,
    G=0,
    rFixed=0.204082,
    SNom=100e6,
    UNomA=69e3,
    UNomB=13.8e3) annotation (Placement(visible=true, transformation(
        origin={104,-18},
        extent={{10,10},{-10,-10}},
        rotation=-90)));
  PowerGridsMC.Electrical.Branches.TransformerFixedRatio T4to9(
    portVariablesPhases=true,
    R=0,
    X=1.05919,
    B=0,
    G=0,
    rFixed=0.208333,
    SNom=100e6,
    UNomA=69.0e3,
    UNomB=13.8e3) annotation (Placement(visible=true, transformation(
        origin={92,-18},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  PowerGridsMC.Electrical.Branches.TransformerFixedRatio T5to6(
    portVariablesPhases=true,
    R=0,
    X=0.479948,
    B=0,
    G=0,
    rFixed=0.212766,
    SNom=100e6,
    UNomA=69e3,
    UNomB=13.8e3) annotation (Placement(visible=true, transformation(
        origin={-30,-20},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  PowerGridsMC.Electrical.Branches.TransformerFixedRatio Tgen1(
    portVariablesPhases=true,
    R=0,
    X=0.393146,
    B=0,
    G=0,
    rFixed=2.875,
    SNom=1211e6,
    UNomA=24e3,
    UNomB=69e3) annotation (Placement(visible=true, transformation(
        origin={-130,20},
        extent={{-10,-10},{10,10}},
        rotation=-90)));
  PowerGridsMC.Electrical.Branches.TransformerFixedRatioWithBreaker Tgen2(
    portVariablesPhases = true,
    R = 0,
    X = 0.425089,
    B = 0,
    G = 0,
    rFixed = 2.875,
    SNom = 1120e6,
    UNomA = 24e3,
    UNomB = 69e3)
    annotation (
    Placement(visible = true, transformation(origin={-118,-90},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGridsMC.Electrical.Branches.TransformerFixedRatio Tgen3(
    portVariablesPhases=true,
    R=0,
    X=0.288545,
    B=0,
    G=0,
    rFixed=3.45,
    SNom=1650e6,
    UNomA=20e3,
    UNomB=69e3) annotation (Placement(visible=true, transformation(
        origin={134,-90},
        extent={{10,-10},{-10,10}},
        rotation=0)));
  PowerGridsMC.Electrical.Branches.TransformerFixedRatio Tgen8(
    portVariablesPhases=true,
    R=0,
    X=0.076176,
    B=0,
    G=0,
    rFixed=0.766667,
    SNom=250e6,
    UNomA=18e3,
    UNomB=13.8e3) annotation (Placement(visible=true, transformation(
        origin={164,0},
        extent={{-10,-10},{10,10}},
        rotation=90)));

// Generators
  PowerGridsMC.Electrical.PowerFlow.PVBus GEN1(
    portVariablesPhases = true,
    SNom=1211000000,
    UNom=24000,
    P=-229290000,
    U=24000)
    annotation (
    Placement(visible = true, transformation(origin = {-130, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PowerGridsMC.Electrical.PowerFlow.PVBus GEN2(
    portVariablesPhases = true,
    SNom=1120000000,
    UNom=24000,
    U=24000,
    P=-40000000)
    annotation (
    Placement(visible = true, transformation(origin={-148,-90},    extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  PowerGridsMC.Electrical.PowerFlow.PVBus GEN3(
    portVariablesPhases = true,
    SNom=1650000000,
    UNom=20000,
    U=20000,
    P=0)
    annotation (
    Placement(visible = true, transformation(origin={158,-90},    extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  PowerGridsMC.Electrical.PowerFlow.PVBus GEN6(
    portVariablesPhases = true,
    SNom=80000000,
    UNom=13800,
    U=13800,
    P = 0)
    annotation (
    Placement(visible = true, transformation(origin = {-70, -10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  PowerGridsMC.Electrical.PowerFlow.PVBus GEN8(
    portVariablesPhases = true,
    SNom=250000000,
    UNom=18000,
    U=18000,
    P = 0)
    annotation (
    Placement(visible = true, transformation(origin={164,-26},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));

equation
  connect(bus12.terminal, L6to12.terminalB) annotation (
    Line(points = {{-90, 80}, {-90, 80}, {-90, 60}, {-70, 60}, {-70, 60}}));
  connect(L12to13.terminalA, bus12.terminal) annotation (
    Line(points={{-70,72},{-90,72},{-90,80}}));
  connect(L12to13.terminalB, bus13.terminal) annotation (
    Line(points = {{-50, 72}, {-36, 72}, {-36, 80}, {-30, 80}}));
  connect(L6to12.terminalA, bus6.terminal) annotation (
    Line(points = {{-50, 60}, {-36, 60}, {-36, 0}, {-30, 0}, {-30, 0}}));
  connect(L6to13.terminalA, bus6.terminal) annotation (
    Line(points = {{-30, 52}, {-30, 52}, {-30, 0}, {-30, 0}}));
  connect(L6to13.terminalB, bus13.terminal) annotation (
    Line(points = {{-30, 72}, {-30, 72}, {-30, 80}, {-30, 80}}));
  connect(bus13.terminal, L6to13.terminalB) annotation (
    Line(points = {{-30, 80}, {-30, 80}, {-30, 72}, {-30, 72}}));
  connect(L6to11.terminalA, bus6.terminal) annotation (
    Line(points = {{-10, 10}, {-10, 10}, {-10, 6}, {-24, 6}, {-24, 0}, {-30, 0}, {-30, 0}}));
  connect(L6to11.terminalB, bus11.terminal) annotation (
    Line(points = {{-10, 30}, {-10, 30}, {-10, 40}, {-10, 40}}));
  connect(L13to14.terminalA, bus13.terminal) annotation (
    Line(points = {{-10, 72}, {-24, 72}, {-24, 80}, {-30, 80}}));
  connect(L13to14.terminalB, bus14.terminal) annotation (
    Line(points = {{10, 72}, {24, 72}, {24, 80}, {30, 80}}));
  connect(L9to14.terminalB, bus14.terminal) annotation (
    Line(points={{54,72},{36,72},{36,80},{30,80}}));
  connect(L9to14.terminalA, bus9.terminal) annotation (
    Line(points={{74,72},{86,72},{86,40},{94,40}}));
  connect(L10to11.terminalB, bus11.terminal) annotation (
    Line(points = {{10, 30}, {-4, 30}, {-4, 40}, {-10, 40}, {-10, 40}}));
  connect(L10to11.terminalA, bus10.terminal) annotation (
    Line(points = {{30, 30}, {34, 30}, {34, 40}, {40, 40}, {40, 40}}));
  connect(L9to10.terminalB, bus10.terminal) annotation (
    Line(points={{52,30},{46,30},{46,40},{40,40}}));
  connect(L9to10.terminalA, bus9.terminal) annotation (
    Line(points={{72,30},{88,30},{88,40},{94,40}}));
  connect(L7to8.terminalA, bus7.terminal) annotation (
    Line(points={{114,20},{110,20},{110,0},{104,0}}));
  connect(L7to9.terminalA, bus7.terminal) annotation (
    Line(points={{98,10},{98,0},{104,0}}));
  connect(L7to9.terminalB, bus9.terminal) annotation (
    Line(points={{98,30},{98,40},{94,40}}));
  connect(L7to8.terminalB, bus8.terminal) annotation (
    Line(points={{134,20},{144,20}}));
  connect(T4to9.terminalA, bus4.terminal) annotation (
    Line(points={{92,-28},{92,-40},{98,-40}}));
  connect(T4to9.terminalB, bus9.terminal) annotation (
    Line(points={{92,-8},{92,40},{94,40}}));
  connect(T5to6.terminalB, bus6.terminal) annotation (
    Line(points = {{-30, -10}, {-30, -10}, {-30, 0}, {-30, 0}}));
  connect(T5to6.terminalA, bus5.terminal) annotation (
    Line(points = {{-30, -30}, {-30, -30}, {-30, -40}, {-30, -40}}));
  connect(L1to2.terminalA, bus1.terminal) annotation (
    Line(points={{-136,-20},{-136,0},{-130,0}}));
  connect(L1to2.terminalB, bus2.terminal) annotation (
    Line(points={{-136,-40},{-136,-70},{-96,-70},{-96,-80},{-90,-80}}));
  connect(L1to5.terminalA, bus1.terminal) annotation (
    Line(points = {{-100, -52}, {-124, -52}, {-124, 0}, {-130, 0}, {-130, 0}}));
  connect(L1to5.terminalB, bus5.terminal) annotation (
    Line(points = {{-80, -52}, {-36, -52}, {-36, -40}, {-30, -40}, {-30, -40}}));
  connect(L2to5.terminalB, bus5.terminal) annotation (
    Line(points = {{-50, -60}, {-30, -60}, {-30, -40}, {-30, -40}}));
  connect(L4to5.terminalB, bus5.terminal) annotation (
    Line(points = {{30, -52}, {-24, -52}, {-24, -40}, {-30, -40}, {-30, -40}}));
  connect(L2to5.terminalA, bus2.terminal) annotation (
    Line(points = {{-70, -60}, {-90, -60}, {-90, -80}, {-90, -80}}));
  connect(L2to4.terminalA, bus2.terminal) annotation (
    Line(points = {{30, -70}, {-82, -70}, {-82, -80}, {-90, -80}, {-90, -80}}));
  connect(L3to4.terminalB, bus4.terminal) annotation (
    Line(points={{104,-50},{104,-40},{98,-40}}));
  connect(L3to4.terminalA, bus3.terminal) annotation (
    Line(points={{104,-70},{104,-80}}));
  connect(L2to4.terminalB, bus4.terminal) annotation (
    Line(points={{50,-70},{98,-70},{98,-40}}));
  connect(L4to5.terminalA, bus4.terminal) annotation (
    Line(points={{50,-52},{92,-52},{92,-40},{98,-40}}));
  connect(L2to3.terminalB, bus3.terminal) annotation (
    Line(points={{10,-90},{98,-90},{98,-80},{104,-80}}));
  connect(Tgen8.terminalB, bus8.terminal) annotation (
    Line(points={{164,10},{164,20},{144,20}}));
  connect(Tgen3.terminalB, bus3.terminal) annotation (
    Line(points={{124,-90},{112,-90},{112,-80},{104,-80}}));
  connect(Tgen2.terminalB, bus2.terminal) annotation (
    Line(points={{-108,-90},{-96,-90},{-96,-80},{-90,-80}}));
  connect(Tgen1.terminalB, bus1.terminal) annotation (
    Line(points = {{-130, 10}, {-130, 0}}));
  connect(Load12.terminal, bus12.terminal) annotation (
    Line(points={{-90,90},{-90,80}}));
  connect(bus13.terminal, Load13.terminal) annotation (
    Line(points={{-30,80},{-30,90}}));
  connect(Load14.terminal, bus14.terminal) annotation (
    Line(points={{30,90},{30,80}}));
  connect(Load11.terminal, bus11.terminal) annotation (
    Line(points={{-10,46},{-10,40}}));
  connect(Load10.terminal, bus10.terminal) annotation (
    Line(points={{40,46},{40,40}}));
  connect(Cbank9.terminal, bus9.terminal) annotation (
    Line(points={{94,54},{94,40}}));
  connect(Load9.terminal, bus9.terminal) annotation (
    Line(points={{114,54},{114,46},{102,46},{102,40},{94,40}}));
  connect(Load6.terminal, bus6.terminal) annotation (
    Line(points = {{-10, -10}, {-10, -10}, {-10, -6}, {-24, -6}, {-24, 0}, {-30, 0}, {-30, 0}}));
  connect(Load5.terminal, bus5.terminal) annotation (
    Line(points = {{-50, -34}, {-50, -36}, {-36, -36}, {-36, -40}, {-30, -40}}));
  connect(Load3.terminal, bus3.terminal) annotation (
    Line(points={{104,-94},{104,-80}}));
  connect(Load2.terminal, bus2.terminal) annotation (
    Line(points = {{-90, -94}, {-90, -80}}));
  connect(L2to3.terminalA, bus2.terminal) annotation (
    Line(points = {{-10, -90}, {-82, -90}, {-82, -80}, {-90, -80}, {-90, -80}}));
  connect(Tgen1.terminalA, GEN1.terminal) annotation (
    Line(points = {{-130, 30}, {-130, 46}}));
  connect(GEN2.terminal, Tgen2.terminalA) annotation (
    Line(points={{-148,-90},{-128,-90}}));
  connect(Tgen3.terminalA, GEN3.terminal) annotation (
    Line(points={{144,-90},{158,-90}}));
  connect(GEN8.terminal, Tgen8.terminalA) annotation (
    Line(points={{164,-26},{164,-10}}));
  connect(Load4.terminal, bus4.terminal) annotation (
    Line(points={{120,-50},{120,-46},{106,-46},{106,-40},{98,-40}}));
  connect(GEN6.terminal, bus6.terminal) annotation (
    Line(points = {{-70, -10}, {-36, -10}, {-36, 0}, {-30, 0}, {-30, 0}}));
  connect(T4to7.terminalA, bus4.terminal) annotation (
    Line(points={{104,-28},{104,-40},{98,-40}}));
  connect(T4to7.terminalB, bus7.terminal) annotation (
    Line(points={{104,-8},{104,0}}));
  annotation (
    Diagram(coordinateSystem(extent={{-160,120},{180,-120}})),
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-6, Interval = 0.002),
    __OpenModelica_commandLineOptions = "--daeMode --tearingMethod=minimalTearing",
    __OpenModelica_simulationFlags(nls="kinsol", lv="LOG_INIT_HOMOTOPY"),
    Documentation(info="<html>
<p></span><i><span style=\"font-size: 12pt;\">Library PowerGridsMC is forked from https://github.com/PowerGrids/PowerGrids.</i></p>
<p></span><i><span style=\"font-size: 12pt;\">The following info is derived from the original version on that source, modified whenever changes introduced in this fork require this.</i></p>
**************************
</html>"));
end IEEE14busPowerFlow;
