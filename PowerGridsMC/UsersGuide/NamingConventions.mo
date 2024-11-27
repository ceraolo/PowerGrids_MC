within PowerGridsMC.UsersGuide;
package NamingConventions
  extends Modelica.Icons.Information;
annotation (
    preferredView = "info",
    Documentation(info="<html>
<p><i><span style=\"font-family: Arial; font-size: 12pt;\">Library PowerGridsMC was forked from https://github.com/PowerGrids/PowerGrids on 22 November 2024.</span></i></p>
<p><i><span style=\"font-size: 12pt;\">The following info is derived from the original version on that source, modified whenever changes introduced in this fork require this.</span></i></p>
<p>************************** </p>
<p>This section contains the naming and style guidelines for the PowerGridsMC library development. If you want to contribute to the library, please make sure you follow them strictly, to ensure a consistent style throughout the whole library.</p>
<p>When writing a Modelica model, please respect the general <a href=\"modelica://Modelica.UsersGuide.Conventions\">Modelica conventions</a> and follow the recommendations below.</p>
<p>Please always use the English language for the code and comments.</p>
<p></span><b><span style=\"font-size: 13.5pt;\">Electrical conventions</b></p>
<p>For currents and powers, the <b>receptor convention</b> is normally followed, i.e. the value is positive when entering the device. Variables following the opposite generator conventions are available on the component ports; they are marked explicitly with <span style=\"font-family: Courier New;\">Gen</span> in their name.</p>
<p></span><b><span style=\"font-size: 13.5pt;\">Naming conventions</b> </p>
<p></span><b><span style=\"font-size: 10.8pt;\">Generalities</b> </p>
<p>Use package namespaces as much as possible to avoid naming conflicts. Do not duplicate parent namespaces in the children model names. </p>
<p>Please follow the <a href=\"modelica://Modelica.UsersGuide.Conventions.ModelicaCode.Naming\">Modelica naming conventions</a>. </p>
<ul>
<li><b>Package/Class/Model</b> : start with upper case letter and use camel-case convention, e.g &quot;ElectricCurrent&quot; </li>
<li><b>Parameters/Constants</b>: start with an upper case letter</li>
<li><b>Variables/Connectors/Component</b> instance : start with lower case letter and use camel-case convention</li>
<li><b>Functions</b>: start with lower case letter </li>
</ul>
<p>In addition to this, please follow the additional naming conventions bellow: </p>
<ul>
<li><b>Start</b> parameters/variables: end with <span style=\"font-family: Courier New;\">Start</span></li>
<li><b>Per-unit</b> parameters/variables: end with <span style=\"font-family: Courier New;\">Pu</span></li>
<li><b>Min/Max</b> parameters/variables: end with <span style=\"font-family: Courier New;\">Min/Max</span> </li>
</ul>
<p></span><b><span style=\"font-size: 10.8pt;\">Exceptions for physical variables</b> </p>
<p>There are some exceptions for the physical variables. Please refer to the list below: </p>
<ul>
<li><b>Frequencies</b> should be named f. A parameter related to a frequency should start with a lower case letter, e.g fACNetwork.</li>
<li><b>Currents</b> should be named <span style=\"font-family: Courier New;\">i</span> (for complex variable) or <span style=\"font-family: Courier New;\">I</span> (for absolute value)</li>
<li><b>Voltages (phase-to-phase)</b> should be named <span style=\"font-family: Courier New;\">u</span> (for complex variable) or <span style=\"font-family: Courier New;\">U</span> (for absolute value)</li>
<li><b>Voltages (phase-to-ground)</b> should be named <span style=\"font-family: Courier New;\">v</span> (for complex variable) or <span style=\"font-family: Courier New;\">V</span> (for absolute value)</li>
<li><b>Apparent power</b> should be named s (for complex variable) or S (for absolute value)</li>
<li><b>Active power</b> should be named P, <b>reactive power</b> should be named Q</li>
<li><b>Impedance</b> should be named <span style=\"font-family: Courier New;\">Z</span>, <b>resistance</b> should be named <span style=\"font-family: Courier New;\">R</span>, <b>reactance</b> should be named <span style=\"font-family: Courier New;\">X</span>, </li>
<p><b>Admittance</b> should be named <span style=\"font-family: Courier New;\">Y</span>, <b>conductance</b> should be named <span style=\"font-family: Courier New;\">G</span>, <b>susceptance</b> should be named <span style=\"font-family: Courier New;\">B</span> </p>
<li><b>Angles</b> should be named according to their name in textbooks (ex: theta)</li>
<li><b>Time</b> should be named t (T is used for the temperature). A parameter related to a time should start with a lower case letter, e.g tInteger, t0... </li>
</ul>
<p></span><b><span style=\"font-size: 10.8pt;\">Types conventions</b> </p>
<p>Preferably use the types defined in the <a href=\"modelica://PowerGridsMC.Types\">PowerGridsMC.Types</a> package, or possibly locally redefined types with ad-hoc nominal attributes. For other units, please use <a href=\"modelica://Modelica.Units.SI\">Modelica.SIunits</a> types. Use the appropriate unit for <span style=\"font-family: Courier New;\">PerUnit</span> variables. Avoid using plain <span style=\"font-family: Courier New;\">Real</span> variables that lack dimensional information and prevent automatic dimension checking on physical equations. </p>
<p></span><b><span style=\"font-size: 13.5pt;\">Model structure conventions</b> </p>
<p></span><b><span style=\"font-size: 10.8pt;\">Generalities</b> </p>
<p>Respect the following order while writing or updating a model: </p>
<ul>
<li>Modelica library imports (alphabetical order)</li>
<li>other libraries imports (alphabetical order)</li>
<li>internal PowerGridsMC imports (alphabetical order)</li>
<li>extends statements</li>
<li>public items: parameters, connectors (group them based on functional aspects)</li>
<li>protected items: parameters, variables, blocks (group them based on functional aspects)</li>
<li>initial equations</li>
<li>equations </li>
</ul>
<p></span><b><span style=\"font-size: 13.5pt;\">Comments conventions</b> </p>
<p>Comments should start with a capital letter. </p>
<ul>
<li>Always comment <b>all</b> models, function, parameters and variables, using the Modelica <span style=\"font-family: Courier New;\">&quot;comments&quot;</span>, explaining concisely but clearly what is their meaning/use. These comments are meant for the library users and automatically show up at various places in the graphical user interface (e.g. in the variables browser to inspect simulation results).</li>
<li>Use <span style=\"font-family: Courier New;\">//</span> comments for equations and implementation description (base transformation, model conventions). These comments meant for library developers. </li>
</ul>
<p></span><b><span style=\"font-size: 13.5pt;\">Model implementation</b> </p>
<ul>
<li>Use complex numbers (and native associated functions) whenever possible</li>
<li>Only use per-unit for models which are natively described in per-unit variables, otherwise use SI physical quantities.</li>
<li>Never introduce explicit scaling factors in physical models, rely on the <span style=\"font-family: Courier New;\">nominal</span> attribute of variables and on the automatic scaling performed by the Modelica tool instead</li>
<li>Use discrete Real for non-continuous variables</li>
<li>Use inner/outer variables for shared general variables</li>
<li>Use input/output keywords or conectors for the inputs/ouputs seen from the model (at least for control models)</li>
<li>Component state </li>
<li><ul>
<li><b>running</b> describes a state when something is flowing through the device</li>
<li><b>on</b> describes a state when the device is turned on (but no flow may be flowing through)</li>
<li><b>off</b> describes a state when the device is shut down (no flow is expected)</li>
</ul></li>
</ul>
</html>"));
end NamingConventions;
