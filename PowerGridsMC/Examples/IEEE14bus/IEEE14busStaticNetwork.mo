within PowerGridsMC.Examples.IEEE14bus;
model IEEE14busStaticNetwork "Dynamic model of the IEEE 14-bus system, operating in steady-state"
  extends Modelica.Icons.Example;
  inner PowerGridsMC.Electrical.System systemPowerGrids(initOpt = PowerGridsMC.Types.Choices.InitializationOption.globalSteadyStateFixedPowerFlow, referenceFrequency = PowerGridsMC.Types.Choices.ReferenceFrequency.fixedReferenceGenerator) annotation (
    Placement(transformation(origin={-146,78},    extent = {{-10, -10}, {10, 10}})));
  // Buses
  PowerGridsMC.Electrical.Buses.ReferenceBus bus1(SNom = 100e6, UNom = 69e3, UStart = 69e3*1.0598) annotation (
    Placement(transformation(origin={-138,0},    extent = {{-10, -10}, {10, 10}})));
  PowerGridsMC.Electrical.Buses.Bus bus2(SNom = 100e6, UNom = 69e3) annotation (
    Placement(visible = true, transformation(origin={-104,-80},   extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGridsMC.Electrical.Buses.Bus bus3(SNom = 100e6, UNom = 69e3) annotation (
    Placement(visible = true, transformation(origin={106,-80},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGridsMC.Electrical.Buses.Bus bus4(SNom = 100e6, UNom = 69e3) annotation (
    Placement(visible = true, transformation(origin={100,-40},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGridsMC.Electrical.Buses.Bus bus5(SNom = 100e6, UNom = 69e3) annotation (
    Placement(visible = true, transformation(origin={-44,-40},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGridsMC.Electrical.Buses.Bus bus6(SNom = 100e6, UNom = 13.8e3) annotation (
    Placement(visible = true, transformation(origin={-44,0},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGridsMC.Electrical.Buses.Bus bus7(SNom = 100e6, UNom = 13.8e3) annotation (
    Placement(visible = true, transformation(origin={106,0},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGridsMC.Electrical.Buses.Bus bus8(SNom = 100e6, UNom = 13.8e3) annotation (
    Placement(visible = true, transformation(origin={146,20},    extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  PowerGridsMC.Electrical.Buses.Bus bus9(SNom = 100e6, UNom = 13.8e3) annotation (
    Placement(visible = true, transformation(origin={96,40},     extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGridsMC.Electrical.Buses.Bus bus10(SNom = 100e6, UNom = 13.8e3) annotation (
    Placement(visible = true, transformation(origin={26,40},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGridsMC.Electrical.Buses.Bus bus11(SNom = 100e6, UNom = 13.8e3) annotation (
    Placement(visible = true, transformation(origin={-24,40},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGridsMC.Electrical.Buses.Bus bus12(SNom = 100e6, UNom = 13.8e3) annotation (
    Placement(visible = true, transformation(origin={-104,80},   extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGridsMC.Electrical.Buses.Bus bus13(SNom = 100e6, UNom = 13.8e3) annotation (
    Placement(visible = true, transformation(origin={-44,80},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGridsMC.Electrical.Buses.Bus bus14(SNom = 100e6, UNom = 13.8e3) annotation (
    Placement(visible = true, transformation(origin={16,80},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  // Lines
  PowerGridsMC.Electrical.Branches.LineConstantImpedance L1to2(portVariablesPhases = true, R = 0.922682, X = 2.81708, G = 0, B = 0.00110901, SNom = 100e6, UNom = 69e3) annotation (
    Placement(transformation(origin={-144,-30},    extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  PowerGridsMC.Electrical.Branches.LineConstantImpedanceWithBreakers L1to5(portVariablesPhases = true, R = 2.57237, X = 10.6189, G = 0, B = 0.0010334, SNom = 100e6, UNom = 69e3) annotation (
    Placement(visible = true, transformation(origin={-104,-52},   extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGridsMC.Electrical.Branches.LineConstantImpedance L2to3(portVariablesPhases = true, R = 2.23719, X = 9.42535, G = 0, B = 0.000919975, SNom = 100e6, UNom = 69e3) annotation (
    Placement(visible = true, transformation(origin={-14,-90},  extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGridsMC.Electrical.Branches.LineConstantImpedance L2to4(portVariablesPhases = true, R = 2.76662, X = 8.3946, G = 0, B = 0.000714136, SNom = 100e6, UNom = 69e3) annotation (
    Placement(visible = true, transformation(origin={26,-70},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGridsMC.Electrical.Branches.LineConstantImpedance L2to5(portVariablesPhases = true, R = 2.71139, X = 8.27843, G = 0, B = 0.000726738, SNom = 100e6, UNom = 69e3) annotation (
    Placement(visible = true, transformation(origin={-74,-60},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGridsMC.Electrical.Branches.LineConstantImpedance L3to4(portVariablesPhases = true, R = 3.19035, X = 8.14274, G = 0, B = 0.000268851, SNom = 100e6, UNom = 69e3) annotation (
    Placement(visible = true, transformation(origin={106,-60},    extent = {{10, -10}, {-10, 10}}, rotation = -90)));
  PowerGridsMC.Electrical.Branches.LineConstantImpedance L4to5(portVariablesPhases = true, R = 0.635593, X = 2.00486, G = 0, B = 0, SNom = 100e6, UNom = 69e3) annotation (
    Placement(visible = true, transformation(origin={26,-52},    extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  PowerGridsMC.Electrical.Branches.LineConstantImpedance L6to11(portVariablesPhases = true, R = 0.18088, X = 0.378785, G = 0, B = 0, SNom = 100e6, UNom = 13.8e3) annotation (
    Placement(visible = true, transformation(origin={-24,20},    extent = {{10, -10}, {-10, 10}}, rotation = -90)));
  PowerGridsMC.Electrical.Branches.LineConstantImpedance L6to12(R = 0.23407, portVariablesPhases = true, X = 0.487165, G = 0, B = 0, SNom = 100e6, UNom = 13.8e3) annotation (
    Placement(visible = true, transformation(origin={-74,60},    extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  PowerGridsMC.Electrical.Branches.LineConstantImpedance L6to13(portVariablesPhases = true, R = 0.125976, X = 0.248086, G = 0, B = 0, SNom = 100e6, UNom = 13.8e3) annotation (
    Placement(visible = true, transformation(origin={-44,62},    extent = {{10, -10}, {-10, 10}}, rotation = -90)));
  PowerGridsMC.Electrical.Branches.LineConstantImpedance L7to8(portVariablesPhases = true, R = 0, X = 0.33546, G = 0, B = 0, SNom = 100e6, UNom = 13.8e3) annotation (
    Placement(visible = true, transformation(origin={126,20},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGridsMC.Electrical.Branches.LineConstantImpedance L7to9(portVariablesPhases = true, R = 0, X = 0.209503, G = 0, B = 0, SNom = 100e6, UNom = 13.8e3) annotation (
    Placement(visible = true, transformation(origin={100,20},    extent = {{10, -10}, {-10, 10}}, rotation = -90)));
  PowerGridsMC.Electrical.Branches.LineConstantImpedance L9to10(portVariablesPhases = true, R = 0.060579, X = 0.160922, G = 0, B = 0, SNom = 100e6, UNom = 13.8e3) annotation (
    Placement(visible = true, transformation(origin={46,30},    extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  PowerGridsMC.Electrical.Branches.LineConstantImpedance L9to14(portVariablesPhases = true, R = 0.242068, X = 0.514912, G = 0, B = 0, SNom = 100e6, UNom = 13.8e3) annotation (
    Placement(visible = true, transformation(origin={56,72},    extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  PowerGridsMC.Electrical.Branches.LineConstantImpedance L10to11(portVariablesPhases = true, R = 0.156256, X = 0.365778, G = 0, B = 0, SNom = 100e6, UNom = 13.8e3) annotation (
    Placement(visible = true, transformation(origin={6,30},     extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  PowerGridsMC.Electrical.Branches.LineConstantImpedance L12to13(portVariablesPhases = true, R = 0.42072, X = 0.380651, G = 0, B = 0, SNom = 100e6, UNom = 13.8e3) annotation (
    Placement(visible = true, transformation(origin={-74,72},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGridsMC.Electrical.Branches.LineConstantImpedance L13to14(portVariablesPhases = true, R = 0.325519, X = 0.662763, G = 0, B = 0, SNom = 100e6, UNom = 13.8e3) annotation (
    Placement(visible = true, transformation(origin={-14,72},  extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  // Loads
  PowerGridsMC.Electrical.Loads.LoadAlphaBeta Load2(
    alpha=1.5,
    beta=2.5,
    PRefConst=21.7e6,
    QRefConst=12.7e6,
    SNom=100e6,
    UNom=69e3,
    URef=72.105e3,
    UStart=72.0866e3,
    UPhaseStart=-0.087) annotation (Placement(visible=true, transformation(
        origin={-104,-94},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  PowerGridsMC.Electrical.Loads.LoadAlphaBeta Load3(
    alpha=1.5,
    beta=2.5,
    PRefConst=94.2e6,
    QRefConst=19.1e6,
    SNom=100e6,
    UNom=69e3,
    URef=69.69e3,
    UStart=69.685e3,
    UPhaseStart=-0.22231) annotation (Placement(visible=true, transformation(
        origin={106,-94},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  PowerGridsMC.Electrical.Loads.LoadAlphaBeta Load4(
    alpha=1.5,
    beta=2.5,
    PRefConst=47.8e6,
    QRefConst=-3.9e6,
    SNom=100e6,
    UNom=69e3,
    URef=70.2756e3,
    UStart=70.2049e3,
    UPhaseStart=-0.180223) annotation (Placement(visible=true, transformation(
        origin={122,-50},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  PowerGridsMC.Electrical.Loads.LoadAlphaBeta Load5(
    alpha=1.5,
    beta=2.5,
    PRefConst=7.6e6,
    QRefConst=1.6e6,
    SNom=100e6,
    UNom=69e3,
    URef=70.4552e3,
    UStart=70.3898e3,
    UPhaseStart=-0.153511) annotation (Placement(visible=true, transformation(
        origin={-64,-34},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  PowerGridsMC.Electrical.Loads.LoadAlphaBeta Load6(
    alpha=1.5,
    beta=2.5,
    PRefConst=11.2e6,
    QRefConst=7.5e6,
    SNom=100e6,
    UNom=13.8e3,
    URef=14.766e3,
    UStart=14.7347e3,
    UPhaseStart=-0.249364) annotation (Placement(visible=true, transformation(
        origin={-24,-10},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  PowerGridsMC.Electrical.Loads.LoadAlphaBeta Load9(
    alpha=1.5,
    beta=2.5,
    PRefConst=29.5e6,
    QRefConst=16.6e6,
    SNom=100e6,
    UNom=13.8e3,
    URef=14.5966e3,
    UStart=14.5624e3,
    UPhaseStart=-0.261599) annotation (Placement(visible=true, transformation(
        origin={116,54},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  PowerGridsMC.Electrical.Loads.LoadAlphaBeta Load10(
    alpha=1.5,
    beta=2.5,
    PRefConst=9e6,
    QRefConst=5.8e6,
    SNom=100e6,
    UNom=13.8e3,
    URef=14.5241e3,
    UStart=14.4903e3,
    UPhaseStart=-0.264445) annotation (Placement(visible=true, transformation(
        origin={26,54},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  PowerGridsMC.Electrical.Loads.LoadAlphaBeta Load11(
    alpha=1.5,
    beta=2.5,
    PRefConst=3.5e6,
    QRefConst=1.8e6,
    SNom=100e6,
    UNom=13.8e3,
    URef=14.5959e3,
    UStart=14.5633e3,
    UPhaseStart=-0.259223) annotation (Placement(visible=true, transformation(
        origin={-24,54},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  PowerGridsMC.Electrical.Loads.LoadAlphaBeta Load12(
    alpha=1.5,
    beta=2.5,
    PRefConst=6.1e6,
    QRefConst=1.6e6,
    SNom=100e6,
    UNom=13.8e3,
    URef=14.499e3,
    UStart=14.5308e3,
    UPhaseStart=-0.264428) annotation (Placement(visible=true, transformation(
        origin={-104,94},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  PowerGridsMC.Electrical.Loads.LoadAlphaBeta Load13(
    alpha=1.5,
    beta=2.5,
    PRefConst=13.8e6,
    QRefConst=5.8e6,
    SNom=100e6,
    UNom=13.8e3,
    URef=14.5634e3,
    UStart=14.4648e3,
    UPhaseStart=-0.265952) annotation (Placement(visible=true, transformation(
        origin={-44,94},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  PowerGridsMC.Electrical.Loads.LoadAlphaBeta Load14(
    alpha=1.5,
    beta=2.5,
    PRefConst=14.9e6,
    QRefConst=5e6,
    SNom=100e6,
    UNom=13.8e3,
    URef=14.3062e3,
    UStart=14.2714e3,
    UPhaseStart=-0.281002) annotation (Placement(visible=true, transformation(
        origin={16,94},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  // Capacitor Bank
  PowerGridsMC.Electrical.Banks.CapacitorBankFixed Cbank9(B = 0.099769, SNom = 100e6, UNom = 13.8e3) annotation (
    Placement(visible = true, transformation(origin={96,54},     extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  // Transformers
  PowerGridsMC.Electrical.Branches.TransformerFixedRatio T4to7(R = 0, X = 0.398248, B = 0, G = 0, rFixed = 0.204082, SNom = 100e6, UNomA = 69e3, UNomB = 13.8e3) annotation (
    Placement(visible = true, transformation(origin={106,-18},    extent = {{10, 10}, {-10, -10}}, rotation = -90)));
  PowerGridsMC.Electrical.Branches.TransformerFixedRatio T4to9(R = 0, X = 1.05919, B = 0, G = 0, rFixed = 0.208333, SNom = 100e6, UNomA = 69.0e3, UNomB = 13.8e3) annotation (
    Placement(visible = true, transformation(origin={94,-18},     extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  PowerGridsMC.Electrical.Branches.TransformerFixedRatio T5to6(R = 0, X = 0.479948, B = 0, G = 0, rFixed = 0.212766, SNom = 100e6, UNomA = 69e3, UNomB = 13.8e3) annotation (
    Placement(visible = true, transformation(origin={-44,-20},    extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  PowerGridsMC.Electrical.Branches.TransformerFixedRatio Tgen1(portVariablesPhases = true, R = 0, X = 0.393146, B = 0, G = 0, rFixed = 2.875, SNom = 1211e6, UNomA = 24e3, UNomB = 69e3) annotation (
    Placement(transformation(origin={-138,20},    extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  PowerGridsMC.Electrical.Branches.TransformerFixedRatioWithBreaker Tgen2(portVariablesPhases = true, R = 0, X = 0.425089, B = 0, G = 0, rFixed = 2.875, SNom = 1120e6, UNomA = 24e3, UNomB = 69e3) annotation (
    Placement(transformation(origin={-134,-90},    extent = {{-10, -10}, {10, 10}})));
  PowerGridsMC.Electrical.Branches.TransformerFixedRatio Tgen3(portVariablesPhases = true, R = 0, X = 0.288545, B = 0, G = 0, rFixed = 3.45, SNom = 1650e6, UNomA = 20e3, UNomB = 69e3) annotation (
    Placement(visible = true, transformation(origin={136,-90},    extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  PowerGridsMC.Electrical.Branches.TransformerFixedRatio Tgen8(portVariablesPhases = true, R = 0, X = 0.076176, B = 0, G = 0, rFixed = 0.766667, SNom = 250e6, UNomA = 18e3, UNomB = 13.8e3) annotation (
    Placement(visible = true, transformation(origin={166,0},    extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  // Generators
  PowerGridsMC.Examples.IEEE14bus.ControlledGenNoPSS GEN1(GEN(
      DPu=0.0,
      H=5.4,
      Tppd0=0.08,
      xpdPu=0.384,
      Tpd0=8.094,
      raPu=0.002796,
      xpqPu=0.393,
      Tppq0=0.084,
      Tpq0=1.572,
      xppdPu=0.264,
      xdPu=2.22,
      xlPu=0.202,
      xppqPu=0.262,
      xqPu=2.22,
      PNom=1090e6,
      SNom=1211e6,
      UNom=24e3,
      PStart=-232.37e6,
      QStart=15.7473e6,
      UStart=25.4068e3,
      UPhaseStart=0.0171006)) annotation (Placement(transformation(
        origin={-138,46},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  PowerGridsMC.Examples.IEEE14bus.ControlledGenNoPSS GEN2(GEN(
      DPu=0.0,
      H=5.4,
      Tppd0=0.058,
      xpdPu=0.407,
      Tpd0=9.651,
      raPu=0.00357,
      xpqPu=0.454,
      Tppq0=0.06,
      Tpq0=1.009,
      xppdPu=0.3,
      xdPu=2.57,
      xlPu=0.219,
      xppqPu=0.301,
      xqPu=2.57,
      PNom=1008e6,
      SNom=1120e6,
      UNom=24e3,
      PStart=-40e6,
      QStart=-42.7306e6,
      UStart=25.1608e3,
      UPhaseStart=-0.0837392)) annotation (Placement(transformation(
        origin={-158,-90},
        extent={{-10,-10},{10,10}},
        rotation=-90)));
  PowerGridsMC.Examples.IEEE14bus.SynchronousCondenser GEN3(GEN(DPu = 0.0,
     H = 5.625, Tppd0 = 0.065, xpdPu = 0.509, Tpd0 = 10.041, raPu = 0.00316,
     xpqPu = 0.601, Tppq0 = 0.094, Tpq0 = 1.22, xppdPu = 0.354, xdPu = 2.81,
     xlPu = 0.256, xppqPu = 0.377, xqPu = 2.62, PNom = 1485e6, SNom = 1650e6,
     UNom = 20e3, PStart = 0.0, QStart = -25.3998e6, UStart = 20.229e3,
     UPhaseStart = -0.22231)) annotation (
    Placement(visible = true, transformation(origin={160,-90},    extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  PowerGridsMC.Examples.IEEE14bus.SynchronousCondenser GEN6(GEN(xpqPu = 0.225,
     Tpq0 = 3.0, DPu = 0.0, H = 4.975, Tppd0 = 0.04, xpdPu = 0.225, Tpd0 = 3.0,
     raPu = 0.004, Tppq0 = 0.06, xppdPu = 0.154, xdPu = 0.75, xlPu = 0.102,
     xppqPu = 0.154, xqPu = 0.45, PNom = 71.8e6, SNom = 80.0e6, UNom = 13.8e3,
     PStart = 0, QStart = -15.0186e6, UStart = 14.7347e3,
     UPhaseStart = -0.249364)) annotation (
    Placement(visible = true, transformation(origin={-84,-10},    extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  PowerGridsMC.Examples.IEEE14bus.SynchronousCondenser GEN8(GEN(xpqPu = 0.31,
     Tpq0 = 8.4, DPu = 0.0, H = 2.748, Tppd0 = 0.096, xpdPu = 0.31, Tpd0 = 8.4,
     raPu = 0.004, Tppq0 = 0.1, xppdPu = 0.275, xdPu = 1.53, xlPu = 0.11,
     xppqPu = 0.346, xqPu = 0.99, PNom = 242e6, SNom = 250e6, UNom = 18e3,
     PStart = 0, QStart = -16.2253e6, UStart = 19.6461e3,
     UPhaseStart = -0.233851)) annotation (
    Placement(visible = true, transformation(origin={166,-26},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(bus12.terminal, L6to12.terminalB) annotation (
    Line(points={{-104,80},{-104,60},{-84,60}}));
  connect(L12to13.terminalA, bus12.terminal) annotation (
    Line(points={{-84,72},{-100,72},{-100,80},{-104,80}}));
  connect(L12to13.terminalB, bus13.terminal) annotation (
    Line(points={{-64,72},{-50,72},{-50,80},{-44,80}}));
  connect(L6to12.terminalA, bus6.terminal) annotation (
    Line(points={{-64,60},{-50,60},{-50,0},{-44,0}}));
  connect(L6to13.terminalA, bus6.terminal) annotation (
    Line(points={{-44,52},{-44,0}}));
  connect(L6to13.terminalB, bus13.terminal) annotation (
    Line(points={{-44,72},{-44,80}}));
  connect(bus13.terminal, L6to13.terminalB) annotation (
    Line(points={{-44,80},{-44,72}}));
  connect(L6to11.terminalA, bus6.terminal) annotation (
    Line(points={{-24,10},{-24,6},{-38,6},{-38,0},{-44,0}}));
  connect(L6to11.terminalB, bus11.terminal) annotation (
    Line(points={{-24,30},{-24,40}}));
  connect(L13to14.terminalA, bus13.terminal) annotation (
    Line(points={{-24,72},{-38,72},{-38,80},{-44,80}}));
  connect(L13to14.terminalB, bus14.terminal) annotation (
    Line(points={{-4,72},{10,72},{10,80},{16,80}}));
  connect(L9to14.terminalB, bus14.terminal) annotation (
    Line(points={{46,72},{22,72},{22,80},{16,80}}));
  connect(L9to14.terminalA, bus9.terminal) annotation (
    Line(points={{66,72},{88,72},{88,40},{96,40}}));
  connect(L10to11.terminalB, bus11.terminal) annotation (
    Line(points={{-4,30},{-18,30},{-18,40},{-24,40}}));
  connect(L10to11.terminalA, bus10.terminal) annotation (
    Line(points={{16,30},{20,30},{20,40},{26,40}}));
  connect(L9to10.terminalB, bus10.terminal) annotation (
    Line(points={{36,30},{32,30},{32,40},{26,40}}));
  connect(L9to10.terminalA, bus9.terminal) annotation (
    Line(points={{56,30},{90,30},{90,40},{96,40}}));
  connect(L7to8.terminalA, bus7.terminal) annotation (
    Line(points={{116,20},{112,20},{112,0},{106,0}}));
  connect(L7to9.terminalA, bus7.terminal) annotation (
    Line(points={{100,10},{100,0},{106,0}}));
  connect(L7to9.terminalB, bus9.terminal) annotation (
    Line(points={{100,30},{100,40},{96,40}}));
  connect(L7to8.terminalB, bus8.terminal) annotation (
    Line(points={{136,20},{146,20}}));
  connect(T4to9.terminalA, bus4.terminal) annotation (
    Line(points={{94,-28},{94,-40},{100,-40}}));
  connect(T4to9.terminalB, bus9.terminal) annotation (
    Line(points={{94,-8},{94,40},{96,40}}));
  connect(T5to6.terminalB, bus6.terminal) annotation (
    Line(points={{-44,-10},{-44,0}}));
  connect(T5to6.terminalA, bus5.terminal) annotation (
    Line(points={{-44,-30},{-44,-40}}));
  connect(L1to2.terminalA, bus1.terminal) annotation (
    Line(points={{-144,-20},{-144,0},{-138,0}}));
  connect(L1to2.terminalB, bus2.terminal) annotation (
    Line(points={{-144,-40},{-144,-70},{-110,-70},{-110,-80},{-104,-80}}));
  connect(L1to5.terminalA, bus1.terminal) annotation (
    Line(points={{-114,-52},{-130,-52},{-130,0},{-138,0}}));
  connect(L1to5.terminalB, bus5.terminal) annotation (
    Line(points={{-94,-52},{-50,-52},{-50,-40},{-44,-40}}));
  connect(L2to5.terminalB, bus5.terminal) annotation (
    Line(points={{-64,-60},{-44,-60},{-44,-40}}));
  connect(L4to5.terminalB, bus5.terminal) annotation (
    Line(points={{16,-52},{-38,-52},{-38,-40},{-44,-40}}));
  connect(L2to5.terminalA, bus2.terminal) annotation (
    Line(points={{-84,-60},{-104,-60},{-104,-80}}));
  connect(L2to4.terminalA, bus2.terminal) annotation (
    Line(points={{16,-70},{-96,-70},{-96,-80},{-104,-80}}));
  connect(L3to4.terminalB, bus4.terminal) annotation (
    Line(points={{106,-50},{106,-40},{100,-40}}));
  connect(L3to4.terminalA, bus3.terminal) annotation (
    Line(points={{106,-70},{106,-80}}));
  connect(L2to4.terminalB, bus4.terminal) annotation (
    Line(points={{36,-70},{100,-70},{100,-40}}));
  connect(L4to5.terminalA, bus4.terminal) annotation (
    Line(points={{36,-52},{94,-52},{94,-40},{100,-40}}));
  connect(L2to3.terminalB, bus3.terminal) annotation (
    Line(points={{-4,-90},{100,-90},{100,-80},{106,-80}}));
  connect(Tgen8.terminalB, bus8.terminal) annotation (
    Line(points={{166,10},{166,20},{146,20}}));
  connect(Tgen3.terminalB, bus3.terminal) annotation (
    Line(points={{126,-90},{114,-90},{114,-80},{106,-80}}));
  connect(Tgen2.terminalB, bus2.terminal) annotation (
    Line(points={{-124,-90},{-110,-90},{-110,-80},{-104,-80}}));
  connect(Tgen1.terminalB, bus1.terminal) annotation (
    Line(points={{-138,10},{-138,0}}));
  connect(Load12.terminal, bus12.terminal) annotation (
    Line(points={{-104,94},{-104,80}}));
  connect(bus13.terminal, Load13.terminal) annotation (
    Line(points={{-44,80},{-44,94}}));
  connect(Load14.terminal, bus14.terminal) annotation (
    Line(points={{16,94},{16,80}}));
  connect(Load11.terminal, bus11.terminal) annotation (
    Line(points={{-24,54},{-24,40}}));
  connect(Load10.terminal, bus10.terminal) annotation (
    Line(points={{26,54},{26,40}}));
  connect(Cbank9.terminal, bus9.terminal) annotation (
    Line(points={{96,54},{96,40}}));
  connect(Load9.terminal, bus9.terminal) annotation (
    Line(points={{116,54},{116,46},{104,46},{104,40},{96,40}}));
  connect(Load6.terminal, bus6.terminal) annotation (
    Line(points={{-24,-10},{-24,-6},{-38,-6},{-38,0},{-44,0}}));
  connect(Load5.terminal, bus5.terminal) annotation (
    Line(points={{-64,-34},{-64,-36},{-50,-36},{-50,-40},{-44,-40}}));
  connect(Load3.terminal, bus3.terminal) annotation (
    Line(points={{106,-94},{106,-80}}));
  connect(Load2.terminal, bus2.terminal) annotation (
    Line(points={{-104,-94},{-104,-80}}));
  connect(L2to3.terminalA, bus2.terminal) annotation (
    Line(points={{-24,-90},{-96,-90},{-96,-80},{-104,-80}}));
  connect(Tgen1.terminalA, GEN1.terminal) annotation (
    Line(points={{-138,30},{-138,46}}));
  connect(GEN2.terminal, Tgen2.terminalA) annotation (
    Line(points={{-158,-90},{-144,-90}}));
  connect(Tgen3.terminalA, GEN3.terminal) annotation (
    Line(points={{146,-90},{160,-90}}));
  connect(GEN8.terminal, Tgen8.terminalA) annotation (
    Line(points={{166,-26},{166,-10}}));
  connect(Load4.terminal, bus4.terminal) annotation (
    Line(points={{122,-50},{122,-46},{108,-46},{108,-40},{100,-40}}));
  connect(GEN6.terminal, bus6.terminal) annotation (
    Line(points={{-84,-10},{-50,-10},{-50,0},{-44,0}}));
  connect(T4to7.terminalA, bus4.terminal) annotation (
    Line(points={{106,-28},{106,-40},{100,-40}}));
  connect(T4to7.terminalB, bus7.terminal) annotation (
    Line(points={{106,-8},{106,0}}));
  connect(GEN1.omega, systemPowerGrids.omegaRefIn) annotation (
    Line(points={{-145,46},{-163,46},{-163,78.2},{-155.8,78.2}},    color = {0, 0, 127}));
  annotation (
    Diagram(coordinateSystem(extent={{-180,120},{180,-120}})),
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-6, Interval = 0.002),
    Documentation(info="<html>
<p><i><span style=\"font-family: Arial; font-size: 12pt;\">Library PowerGridsMC was forked from https://github.com/PowerGrids/PowerGrids on 22 November 2024.</span></i></p>
<p><i><span style=\"font-size: 12pt;\">The following info is derived from the original version on that source, modified whenever changes introduced in this fork require this.</span></i></p>
<p>************************** </p>
</html>"));
end IEEE14busStaticNetwork;
