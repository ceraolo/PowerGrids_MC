within PowerGridsMC.UsersGuide;
package Overview
  extends Modelica.Icons.Information;
   annotation (
    preferredView = "info",
    Documentation(info="<html>
<p><i><span style=\"font-size: 12pt;\">Library PowerGridsMC was  forked from https://github.com/PowerGrids/PowerGrids on 22 November 2024.</span></i></p>
<p><i><span style=\"font-size: 12pt;\">The following info is derived from the original version on that source, modified whenever changes introduced in this fork require this.</span></i> </p>
<p>**************************</p>
<p>The PowerGrids library is a Modelica library for the modelling of AC power generation and transmission grids, possibly including DC links. </p>
<p>The library is meant to be used to model small-scale systems, e.g. for teaching, as well as medium to large-scale systems. Small system models can be built and managed with the graphical user interface of Modelica tools, while larger models can be built automatically by suitable scripts, starting from information contained in, e.g., CIM files. </p>
<p>The library has been specifically designed to exploit advanced features of Modelica, while at the same time keeping a low entry barrier for power engineers who want to develop their own models. The design principles and rationale of the library are discussed in the <a href=\"modelica://PowerGridsMC.UsersGuide.Tutorial\">PowerGridsMC.UsersGuide.Tutorial</a>. </p>
<p>Three-phase AC voltage and current systems are balanced and represented by complex phasors. Quasi-static relationships between currents and voltages are assumed, described by complex equations involving the phasors. Dynamic phenomena are confined to the inertia of rotating machinery and to controllers.</p>
<p>Phasors represent the rotation of the corresponding three-phase system with respect to a rotating reference frame. The models of electrically interconnected AC systems are valid as long as the reference frame is the same for all of them. The library is designed to also accommodate DC links and eventually allow to model the splitting and merging of synchronous islands in grid models, triggered by the opening and closing of circuit breakers, although these features are still not implemented. Since the topology of connected islands is not static but can change during the simulation, the reference frame information cannot be carried by variables on overconstrained connectors, as in other Modelica libraries such as <a href=\"modelica://Modelica.Electrical.Polyphase\">Modelica.Electrical.MultiPhase</a> or <a href=\"modelica://PowerSystems\">PowerSystems</a>; it is instead managed by a System object.</p>
<p>Physical quantities in SI units are used on the connectors and, where appropriate, in the physical equations of the component models. The nominal attribute of Real variables is used in order to guarantee the proper scaling of the problem for the numerical solvers.</p>
<p>The library has been developed with the open source <a href=\"https://openmodelica.org\">OpenModelica</a> tool and is meant to be compatible with any Modelica tool that fully supports the standard. The efficient simulation of model with more than a handful of nodes requires the use of direct sparse DAE solvers, since the system model is sparse in the DAE representation, but becomes dense and unnecessary cumbersome if reduced to an ODE system, as Modelica tools normally do to simulate models.</p>
</html>"));
end Overview;
