within PowerGridsMC.UsersGuide;
package ToolSupport
  extends Modelica.Icons.Information;
annotation(preferredView = "info",
    Documentation(info="<html>
<p><i><span style=\"font-size: 12pt;\">Library PowerGridsMC is forked from https://github.com/PowerGrids/PowerGrids.</span></i></p>
<p><i><span style=\"font-size: 12pt;\">The following info is derived from the original version on that source, modified whenever changes introduced in this fork require this.</span></i></p>
**************************

<p><br></span><b><span style=\"font-size: 16.5pt;\">Modelica Tool Support</b></p>
<p></span><b><span style=\"font-size: 13.2pt;\">General Information</b></p>
<p><br><br>The PowerGrid library has been developed using the <a href=\"https://www.openmodelica.org\">OpenModelica</a> tool and has been tested extensively using that tool. The library was written in standard Modelica language, so it is expected to work with any Modelica tool that fully supports the standard, in particular Complex numbers and the homotopy() operator.</p>
<p>The power system models that can be built with this library have a different structure compared to the models that are normally simulated by Modelica tools, due to the large number of coupled implicit algebraic equations stemming from the phasor-based representation of most grid elements, such as transmission lines, transformers, and loads. This may require some special set-up of the tool to generate efficient and numerically robust code to simulate the models. These aspects are now briefly discussed.</p>
<p>The first aspect concerns the structure of the system mathematical models. The original formulation of the system model is a system of differential-algebraic equations (DAE), which has a sparse structure, since every physical component is connected to a limited number of neighbouring components. The conventional approach used by Modelica tools to solve these DAEs is to first transform them into ordinary differential equations (ODE), in a process known as causalization that requires to solve the DAEs for the state derivatives, and then to use an ODE solver to perform time integration. Note that this approach is followed even if the solver which is eventually used is DASSL. The reason why DASSL is often used in Modelica tools is that it is very robust and efficient and has a very good event detection capabilities, but normally it is employed to solve the causalized ODEs, not the original DAEs.</p>
<p>Unfortunately, this approach is highly inefficient in the case of PowerGridsMC system models: it is well known from the swing equation theory that if a quasi-static phasor approximation of the grid elements is used, then the derivative of the shaft angular velocity of each synchronous generator instantaneously depends on all the rotor angles of all other synchronous generators which are connected through the grid. Hence, although the DAEs are sparse, the causalized ODE representation is not. This makes the causalization process highly inefficient, because the computation of the right-hand side of the ODE formulation requires the computation of a large number of Jacobian matrix elements, as well as the solution of a large dense nonlinear system.&nbsp;</p>
<p>This means that, except for very simple systems with a few synchronous generators, the so called DAE-mode solution method should be selected, which avoids the standard ODE causalization and uses a native numerical DAE solver to simulate the system. The use of a sparse DAE solver is recommended. In case causalization is employed, the use of sparse solvers for the implicit nonlinear equations (a.k.a. algebraic loops) is mandatory for reasons of efficiency, since the size of those systems can be quite large, while the number of variables involved in each equation is normally limited to a few units.</p>
<p>The second aspect regards the initial guess for the solver of the initialization problems. As discussed further in the Tutorial, the PowerSystems library was designed to make sure that proper start values are computed, starting from the power flow results, for all the nonlinear variables that influence the Jacobian of the initialization problem, while there is no need to care about the initial values of variables appearing linearly in the models. Following this approach guarantees the convergence of the Newton algorithm to solve the initialization problem, as long as the problem is kept in its original formulation.</p>
<p>However, Modelica tools often employ a method, known as <i>tearing</i>, to reduce the size of the actual nonlinear implicit system to be solved, thus making the solution process more efficient. Unfortunately, the choice of nonlinear variables as torn variables leads to the loss of their initial guess values, potentially hampering the convergence.</p>
<p>A brute-force method to avoid this problem is to disable the tearing algorithm and enable sparse solvers for the nonlinear systems of equations, using suitable tool flags. More advanced tools may automatically avoid selecting nonlinear unknowns as torn variables, thus preserving the start value information, and also automatically select sparse solvers based on the observed large size and low density of the equation system; in this case, there is no need to set special flags to achieve robust and fast simulation.</p>
<p>The library uses SI units for physical quantities on connectors, to enhance clarity and avoid ambiguity regaring the base quantities for per-unit variables. In order to achieve good numerical scaling in the solution process, the Modelica tool should use the nominal attributes of variables for automatic scaling.</p>
<p>Finally, the homotopy operator is used in several places of the library, in particular for the robust solution of the nonlinear implicit equations relating internal and external parameters of the synchronous machine models. It is also used to initially remove the nonlinear elements due to actuator saturations in the control system models, making the corresponding equations linear and thus avoiding the need to provide start values for all their variables, which could be quite inconvenient. </p>
<p>Hence, it is essential that the homotopy operator is indeed used in the solution process of the initialization problem, in order to avoid solver convergence problems.</p>
<p></span><b><span style=\"font-size: 13.2pt;\">Using PowerGridsMC with OpenModelica</b></p>
<p>In the case of the OpenModelica compiler, version 1.18.0, these requirements can be met by selecting the following flags: </p>
<ul>
<li>Simulation flag <span style=\"font-family: Courier New;\">-nls=kinsol</span>: forces the tool to use the sparse KINSOL solver for all algebraic loops and nonlinear implicit systems during initialization. In OMEdit, this flag can be selected in Simulation Setup | Simulation Flags | Non Linear Solver.</li>
<li>Translation flag <span style=\"font-family: Courier New;\">--tearingMethod=minimalTearing</span>: avoids tearing except for dealing with mixed real-integer problems. In OMEdit, this flag can be specified by typing it in Simulation Setup | Translation Flags | Additional Translation Flags.</li>
<li>Translation flag <span style=\"font-family: Courier New;\">--daeMode</span>: instructs the tool to use DAE mode for the simulation of the system and automatically selects the IDA solver with sparse linear algebra, regardless of the solver settings in the Simulation Flags tab. This is recommened for systems having more than a handful of synchronous generators, while the default ODE mode can be used if there are only a few synchronous generators. In OMEdit, this flag can be specified by typing it in Simulation Setup | Translation Flags | Additional Translation Flags.</li>
</ul>
<p>When creating new models, these settings can be saved into custom annotations of the model by checking the &quot;Save translation flags&quot; and &quot;Save simulation flags&quot; options in Simulation Setup, so that they are automatically set when the model is re-opened and re-simulated later on. The existing example models and test models in the PowerSystems library already have <span style=\"font-family: Courier New;\">__OpenModelica</span> custom annotations to set those flags when compiling and running the model.</p>
<p>All other requirements are automatically fulfilled by OpenModelica. Please note that future versions of OpenModelica may no longer require these flags to be set at all.</p>
<p>If you are interested at running PowerGridsMC in other Modelica tools and are having trouble, please contact the authors for assistance.</p>
</html>"));
end ToolSupport;
