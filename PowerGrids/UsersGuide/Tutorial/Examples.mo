within PowerGrids.UsersGuide.Tutorial;
package Examples
  extends Modelica.Icons.Information;
annotation(preferredView = "info",
    Documentation(info = "<html><head></head><body>
<p>This part of the tutorial will guide you through a series of example system models that demonstrate the features of the PowerGrids library.</p>
<p>More detailed information about each component in the example systems is available in the corresponding documentation layer. Components are tested individually or in small assemblies in test cases contained in the <a href=\"modelica://PowerGrids.Electrical.Test\">PowerGrids.Electrical.Test</a> package, which have known solutions; please refer to those cases if you are interested in assessing the correct behaviour of individual components. The purpose of the examples presented here is instead to give an overview of the library features.</p>

<h2>Grid-Connected Systems</h2>
<p>We will first consider systems which are connected to an infinite bus with a specified connection impedance. All the presented examples are variants of a simple model described in the ENTSO-E document <a href=\"https://www.entsoe.eu/fileadmin/user_upload/_library/publications/entsoe/RG_SOC_CE/131127_Controller_Test_Report.pdf\">Documentation on Controller Tests in Test Grid Configurations</a>, which provides all the model parameters and a reference power flow.</p>

<h3>Static grid models</h3>

<p>We first consider some models of the system operating in steady state.</p>
<p>The first step for the simulation of a power system model is to obtain a power flow corresponding to the initial steady state of the system; voltage magnitude and phase are computed at all component ports, as well as active and reactive power flows into the ports.</p>
<p>The model <a href=\"modelica://PowerGrids.Examples.Tutorial.GridOperation.Static.PowerFlow\">PowerGrids.Examples.Tutorial.GridOperation.Static.PowerFlow</a> demonstrates how you can use the PowerGrids library to set up a power flow problem using the PowerGrids library. The <a href=\"modelica://PowerGrids.Electrical.PowerFlow.SlackBus\">slack bus</a> represents the connection with an infinite grid, prescribing the voltage magnitude and phase and providing whatever active and reactive power is required by the system.</p>
<p>When simulating the power flow model, the Modelica tool will use its built-in algebraic equation solver to solve the power flow, starting from a trivial initial guess where all the voltages have their nominal magnitude and zero angle. Note that it is not necessary to explicitly set up the start values found under the Initialization tab to set up power flow models - the provided defaults are enough to ensure a reasonable initial guess for the nonlinear solver. This way of solving the power flow problem is not specifically designed or optimized to obtain the convergences of the solver, so it is not guaranteed to work in complex, large-scale examples, nor it provides additional features such as power flow optimization. However, it does work for moderate-sized example, such as the well-known <a href=\"modelica://PowerGrids.Examples.IEEE14bus.IEEE14busPowerFlow\">IEEE 14-bus case</a>. You may also use any other external power flow solver of your choice to carry out this task.</p>
<p>Once you have the results of the power flow problem, these must be used to set up the <code>Ustart</code>, <code>UPhaseStart</code>, <code>PStart</code>, <code>QStart</code> parameters of the components of the dynamic grid model that include nonlinear equations. If you use a GUI to set up the model, these parameters are located under the <code>Initialization</code> tab. The initial equations inside each component are then used to compute all the required initial guess values starting from these four fundamental parameters.</p>
<p>The first dynamic model we consider is <a href=\"modelica://PowerGrids.Examples.Tutorial.GridOperation.Static.StaticGrid\">PowerGrids.Examples.Tutorial.GridOperation.Static.StaticGrid</a>. Note that the slack bus of the power flow model must be replaced by a <a href=\"modelica://PowerGrids.Electrical.Buses.ReferenceBus\">reference bus</a>, which prescribes the same voltage magnitude and phase of the slack node in the power flow model at the initial time of the simulation, keeping whatever slack power is required at initialization constant for the remainder of the simulation.</p>
<p>This model has a constant PQ load and a synchronous machine with constant inputs. Since it is initialized in steady-state, it will actually operate in steady state throughout the simulation. The results coincide with the previously computed power flow, even though the synchronous machine model is a lot more complicated than the PV generator used in the power flow model. Note that start values from the power flow are provided only for the machine and PQ load, that have nonlinear equations, and in the case of the PQ load are only provided for the voltage magnitude and phase, since this model has fixed P and Q values, so P and Q are not part of the unknowns of the initialization problem.</p>
<p>In the second example, we consider <a href=\"modelica://PowerGrids.Examples.Tutorial.GridOperation.Static.StaticGridComputedParameters\">StaticGridComputedParameters</a>. In this case, the values for the mechanical power input and  excitation voltage of the synchronous generator are provided by <a href=\"modelica://Modelica.Blocks.Sources.RealExpression\">RealExpression</a> signal generators, which get the values from  parameters that are computed internally in the generator model, based on the start values coming from the power flow. This allows to avoid computing those values manually or by trial-and-error.</p>
<p>If you switch to the text view, you can note that this second model was not obtained by copying the first one and modifying it, but was rather obtained by inheritance as a variant of the first one. This pattern, which is extensively used in this tutorial, is very convenient because it explicitly shows what are the differences with the base model; it also guarantees that if the base model is updated, all the derived one are updated as well, thus maintaining the consistency of the test cases by construction.</p>

<p>The next example, <a href=\"modelica://PowerGrids.Examples.Tutorial.GridOperation.Static.StaticGridDifferentNominals\">StaticGridDifferentNominals</a>, demonstrates the role of nominal value parameters in different components. The example contains three variants of the same system. The first one is the same as in the previous example. In the second one, the <code>UNomB</code> parameter of the transformer is changed from 419 kV to 100 kV. The <a href=\"modelica://PowerGrids.Electrical.Branches.TransformerFixedRatio\">
transformer model</a> is a specialization of the <a href=\"modelica://PowerGrids.Electrical.Branches.BaseClasses.PiNetwork\">generalized pi-network model</a>, which is written in terms of physical quantities, not in terms of p.u. quantities. Hence, changing the nominal value of the voltage, which is a base quantity for p.u. variables, has an influence on the visualized p.u. voltage and current, but it doesn't change the physical behaviour of the component, in particular the actual voltage and power flow through it. Finally, in the third variant, the nominal voltage of the synchronous machine is changed from 21 kV to 10 kV. Since the <a href=\"modelica://PowerGrids.Electrical.Machines.SynchronousMachine4WindingsInternalParameters\">machine model</a> is written using p.u. variables, this has a consequence on the physical behaviour of the machine; for example, a different excitation voltage is required to obtain the same voltage output.</p>

<p>The last example, <a href=\"modelica://PowerGrids.Examples.Tutorial.GridOperation.Static.StaticGridDifferentGeneratorParam\">Static.StaticGridDifferentGeneratorParam</a>, demonstrates three different parametrizations of the synchronous generator, all leading to the same physical behaviour. The first one uses the <a href=\"modelica://PowerGrids.Electrical.Machines.SynchronousMachine4Windings\">SynchronousMachine4Windings</a> model, that accepts the external machine parameters, with the default choice of base excitation voltage, where 1 p.u. corresponds to the excitation voltage that produces the nominal stator voltage in no-load conditions. The second one has the same external machine parameters, but uses the stator base quantities to determine the rotor base voltage, as explained in the Kundur textbook. As a consequence, the p.u. excitation voltage has values much smaller than unity. The last example uses the <a href=\"modelica://PowerGrids.Electrical.Machines.SynchronousMachine4WindingsInternalParameters\">SynchronousMachine4WindingsInternalParameters</a> model, that directly accepts the physical parameters of the stator and rotor of the machine.</p>

<h3>Simulation of load change response</h3>

<p><a>The package </a><a href=\"modelica://PowerGrids.Examples.Tutorial.GridOperation.LoadChange\">PowerGrids.Examples.Tutorial.GridOperation.LoadChange</a> demonstrates three possible ways to model a system with a load change.</p>
<p> The first example, <a href=\"modelica://PowerGrids.Examples.Tutorial.GridOperation.LoadChange.LoadChangeByModifier\">LoadChangeByModifier</a>, was built by duplicating the <a href=\"modelica://PowerGrids.Examples.Tutorial.GridOperation.Static.StaticGridComputedParameters\">StaticGridComputedParameters</a> model and by adding two modifiers to the variables <code>PRef</code> and <code>QRef</code>, with expressions indicating the active and reactive power profiles, starting at certain values and increased at time = 2 by 5% and 4%, respectively. See the textual source code of the model where the <code>GRIDL</code> component is declared. This is a very convenient way to operate when the system code is generated automatically by scripts, starting from some netlist description (e.g., a CIM file).</p>
<p>The second example, <a href=\"modelica://PowerGrids.Examples.Tutorial.GridOperation.LoadChange.LoadChangeByModifierUsingExtends\">LoadChangeByModifierUsingExtends</a> obtains the same model in a more compact way as a variation of an existing static model, by inheriting from <a href=\"modelica://PowerGrids.Examples.Tutorial.GridOperation.Static.StaticGridComputedParameters\">StaticGridComputedParameters</a>, and by adding modifiers to the extends clause to change the binding equation for the load signals. Please check the textual view of the model, particularly the declaration of <code>GRIDL</code>.</p>
<p>The third example, <a href=\"modelica://PowerGrids.Examples.Tutorial.GridOperation.LoadChange.LoadChangeByInputSignals\">LoadChangeByInputSignals</a>, instead uses the <a href=\"modelica://PowerGrids.Electrical.Loads.LoadPQVoltageDependence\">LoadPQVoltageDependence</a> component for the load <code>GRIDL</code>; this component has two input signals for <code>PRef</code> and <code>QRef</code>, which can be supplied by any suitable signal source, in this case a step signal generator. This is very convenient if the power signals require non-trivial signal generator models, that are not easily written down in a single expression in a modifier, as in the two previous examples.</p>

<h3>Simulations including governors and voltage regulators</h3>
<p>Previous examples included synchronous generators operating in open loop. Examples in the <a href=\"modelica://PowerGrids.Examples.Tutorial.GridOperation.Controlled\">PowerGrids.Examples.Tutorial.GridOperation.Controlled</a> package also include governor, voltage regulators, and power system stabilizers.</p>

<p>The <a href=\"modelica://PowerGrids.Examples.Tutorial.GridOperation.Controlled.ControlledGridWithoutPSS\">ControlledGridWithoutPSS</a> model includes a simple governor and a simple automatic voltage controller. In this first case the set points of both controllers are known, so the <code>initOpt</code> parameter of the system object is set to the default value <code>globalSteadyStateFixedSetPoints</code>.</p>

<p>The <a href=\"modelica://PowerGrids.Examples.Tutorial.GridOperation.Controlled.ControlledGridWithPSS\">ControlledGridWithPSS</a> is similar to the previous one, except that a power system stabilizer is added to the system.</p>

<p>The <a href=\"modelica://PowerGrids.Examples.Tutorial.GridOperation.Controlled.ControlledGridParametersChange\">ControlledGridParametersChange</a> demonstrates how to derive a variant of the previous model by inheritance. Please check the textual version of the code, but also note that you can input the new parameter values using the GUI of your Modelica tool.</p>

<p>The <a href=\"modelica://PowerGrids.Examples.Tutorial.GridOperation.Controlled.ControlledGridWithReferenceCalculation\">ControlledGridWithReferenceCalculation</a> shows how to set up the system initialization by enforcing the voltage and power at the machine interface to the start values (obtained from the power flow calculation and set in the start parameters of the machine), and automatically back-computing the set point offset for the governor and for the automatic voltage regulator. To this aim, two <a href=\"modelica://PowerGrids.Controls.FreeOffset\">FreeOffset</a> blocks are employed, one for each controller. In the case of the governor, the <code>FreeOffset</code> block is set up to have no input, so its output is constant and automatically computed to obtain the required active power flow at the generator port. The other <code>FreeOffset</code> block instead has one input, which is added to the automatically computed offset; this configuration allows to simulate the response to time-varying set points, while automatically computing their initial offset to obtain the required power flow conditions. Note that in order to activate this back-computation of offsets, it is necessary to set the <code>initOpt</code> parameter of the system object to <code>globalSteadyStateFixedPowerFlow</code>; this setting activates additional initial equations in the governor and AVR, which are matched to the free offsets inside the <code>FreeOffset</code> blocks.</p>

<p>The <a href=\"modelica://PowerGrids.Examples.Tutorial.GridOperation.Controlled.ControlledGridWithReferenceCalculationSat\">ControlledGridWithReferenceCalculationSat</a> is similar to the previous model, except that the upper saturation limiter of the AVR is lower than the value which would be necessary to guarantee the voltage magnitude specified by <code>UStart</code>; hence, the voltage value of the power flow cannot be achieved, the AVR actuator will saturate, and a lower voltage will be obtained. In this case, the set point offset will be computed to a value slightly higher than the maximum achievable voltage, depending on the <code>oversaturationPu</code> parameter of the AVR.</p>

<p>The last example, <a href=\"modelica://PowerGrids.Examples.Tutorial.GridOperation.Controlled.ControlledGridWithControlledGen\"> ControlledGridWithControlledGen</a> demonstrates how one can define a controlled generator as a standalone object, and then use it to build a system model without showing the controllers explicitly at the top level. This is achieved by defining a <a href=\"modelica://PowerGrids.Examples.Tutorial.GridOperation.Controlled.ControlledGenerator\">ControlledGenerator</a> model that contains the synchronous machine model, the governor, the automatic voltage controller, and the power system stabilizer; default values are given for all the parameters. The instantiated controlled generators in the system model get the default parameter values, unless they are changed by means of nested modifiers: in this case, the parameter <code>Ka</code> of the AVR is changed from the default value of 200 to 150. The scenario simulated in this case is a short-circuit to ground of bus NTHV taking place at time 2 s.</p> 

<h2>Islanded Systems</h2>

<p>The package <a href=\"modelica://PowerGrids.Examples.Tutorial.IslandOperation\">PowerGrids.Examples.Tutorial.IslandOperation</a> contains examples based on an islanded system with two synchronous generators, that can operated permanently at a frequency different from the nominal value.</p>

<p>As in the previous case, the power flow can be computed by simulating the <a href=\"modelica://PowerGrids.Examples.Tutorial.IslandOperation.PowerFlow\">PowerFlow</a> model. Note that Bus components can be used for convenience as a means to connect different components, but they are not mandatory, as seen by comparing the left side and the right side of the circuit.</p>

<p>The first dynamic example is <a href=\"modelica://PowerGrids.Examples.Tutorial.IslandOperation.TwoGeneratorsOneReferenceGenerator\">TwoGeneratorsOneReferenceGenerator</a>. In this case, we choose  <code>referenceFrequency = fixedReferenceGenerator</code> in the system object, and connect the frequency output of <code>GEN2</code> to the system reference frequency input. The islanded system starts in steady state, then at time = 1 the active power consumed by <code>GRIDL1</code> is reduced by 100 MW. As a consequence, the system frequency increases and the two governors react by reducing the mechanical power input to the generators, until a new equilibrium is reached in about 15 s. Due to the absence of secondary frequency control, the system frequency is stabilized at 50.25 Hz. If the second generator frequency is chosen as a reference, both generator angles <code>theta</code> remain constant after time = 15, allowing the variable step integrator to take much longer steps if the simulation is run for a longer time span.</p>

<p>The model <a href=\"modelica://PowerGrids.Examples.Tutorial.IslandOperation.TwoGeneratorsFixedFrequencyReference\">TwoGeneratorsFixedFrequencyReference</a> demonstrates what happens if the <code>nominalFrequency</code> option is used instead: the two generator angles <code>theta</code> grow indefinitely, and the real and imaginary parts of all the voltages and currents in the system show permanent sinusoidal oscillations with a frequency of 0.25 Hz. This prevents the solver from substantially increasing the time step after time = 15, and potentially leads to numerical issues if the stop time of the simulation is increased significantly above that value. For islanded systems, it is therefore highly recommended to always use the <code>fixedReferenceGenerator</code> option in the system object, providing it with the frequency of a strong generator in the system.</p>

<p>In both previous cases, the system was initialized with the <code>initOpt = globalSteadyStateFixedPowerFlow</code> option, which leads to a formulation of a globally coupled system of 94 algebraic equations comprising the transformers, transmission line, loads, and generators. The <a href=\"modelica://PowerGrids.Examples.Tutorial.IslandOperation.TwoGeneratorsLocalInitialization\">TwoGeneratorsLocalInitialization</a> is the same as <a href=\"modelica://PowerGrids.Examples.Tutorial.IslandOperation.TwoGeneratorsOneReferenceGenerator\">TwoGeneratorsOneReferenceGenerator</a>, except that it uses the <code>localSteadyStateFixedPowerFlow</code> option. As a consequence, the largest system of nonlinear equations that is needed to solve the former model initialization problem is split into three smaller systems. On the other hand, since the power flow data that are used to independently initialize each generator model were input with a limited number of decimal digits, the corresponding initial conditions are not exactly at steady-state, though they are very close to it. A very small amplitude transient then ensues when the simulation is started at time = 0, as can be seen by zooming in the simulation results during the first second of the simulation, before the active power consumption of <code>GRIDL1</code> is changed.</p>

<h2>The IEEE 14-Bus Model</h2>
<p>The last example case covered by this tutorial is a model of the well-known IEEE 14-bus benchmark, which contains 14 buses, two controlled generators, three synchronous compensators (i.e. synchronous machines without any mechanical power source attached to the shaft), 17 transmission lines, 11 loads, one capacitor bank, and 7 transformers. This example is large enough to be definitely non-trivial, while still being manageable via the graphical user interface of a Modelica tool.</p>

<p>The <a href=\"modelica://PowerGrids.Examples.IEEE14bus.IEEE14busPowerFlow\">IEEE14busPowerFlow</a> model demonstrates the use of the PowerGrids library to set up the power flow model of such a benchmark.</p>

<p>The following model, <a href=\"modelica://PowerGrids.Examples.IEEE14bus.IEEE14busStaticNetwork\">IEEE14busStaticNetwork</a> sets up the dynamic model of the system, using the results of the previous power flow to set up the start values for initialization. The two generators are modelled by instances of the <a href=\"modelica://PowerGrids.Examples.IEEE14bus.ControlledGeneratorIEEE\">ControlledGeneratorIEEE</a> model, that includes a synchronous machine, a governor, an AVR, and a PSS. The three <a href=\"modelica://PowerGrids.Examples.IEEE14bus.SynchronousCondenser\">SynchronousCondenser</a> models only include the synchronous machine, the AVR, and the PSS.</p> 
<p>This model has constant inputs, so the result of the simulation is a steady state. The model is then extended by adding three different inputs to simulate three transient scenarios.</p>

<p><a href=\"modelica://PowerGrids.Examples.IEEE14bus.IEEE14busGen2Disconnection\">IEEE14busGen2Disconnection</a> simulates the system response to the opening of the breaker built in the transformer of Generator 2; this causes the loss of generation power, which is then taken over by Generator 1. <a href=\"modelica://PowerGrids.Examples.IEEE14bus.IEEE14busLine1to5Opening\">IEEE14busLine1to5Opening</a> simulates the opening of the breaker built in Line 1 to 5. Finally, <a href=\"modelica://PowerGrids.Examples.IEEE14bus.IEEE14busLoad2Variation\">IEEE14busLoad2Variation</a> simulates the response of the system to a load change of Load 2.</p>

</body></html>"));
end Examples;
