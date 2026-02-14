within PowerGridsMC.Functions;
function asmaValuesFunOfSpeed
  "Computes induction machine values as a function of RMS phase voltage and rotational speed"
  extends Modelica.Icons.Function;

  //Input variable
  input Real V "Phase RMS voltage";
  input Real W "Rotational velocity";

  //constants ad inputs
  input Real eps = 1e-5;

  //parameters as input
  input Integer pp "Pole pairs";
  input Real R1,R2 "Stator and rotor resistances";
  input Real L1l,L2l "Stator and rotor leakage inductances";
  input Real Lm    "Magnetising inductance";
  input Real T1, T2 "Load torque constants";
  input Real Wsyn "synchronous (mechanical) rotational velocity";

  protected
    Real s "slip";
    Modelica.Units.SI.ComplexImpedance Z1, Z2, Zm, Zeq, i1, vm;
  Modelica.Units.SI.ComplexCurrent i2;

public
    output Real Req
      "Resistance of the equivalent impedance";
    output Real Xeq
      "Reactance of the equivalent impedance";
    output Real tauElectrical "Electrical generated torque";
    output Modelica.Units.SI.ComplexPower S1;

algorithm
  Z1 := Complex(R1, pp*Wsyn*L1l);
  Zm := Complex(0, pp*Wsyn*Lm);

  s  := (Wsyn - W)/Wsyn;

  Z2 := Complex(R2/(s+eps), pp*Wsyn*L2l);
  Zeq := Z2*Zm/(Z2 + Zm) + Z1;
  Req := Modelica.ComplexMath.real(Zeq);
  Xeq := Modelica.ComplexMath.imag(Zeq);

  i1:=Complex(V)/Zeq;
  vm:=Complex(V)-Z1*i1;
  i2:=vm/Z2;

  tauElectrical := 3*Z2.re*(i2.re^2 + i2.im^2)/Wsyn;
  S1:=3*Complex(V)*CM.conj(i1);

  annotation (Documentation(info="<html>
<p>This function computes several parameters as a function of the rotational speed, for an induction machine supposed to operate in steady-state.</p>
<p>This can be used to find the initial steady-state operation point at simulation start.</p>
</html>"));
end asmaValuesFunOfSpeed;
