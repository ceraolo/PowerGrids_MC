within PowerGridsMC.Functions;
function giveShortName
  input String name;
  output String nameShort;
protected
         Integer index;
algorithm
    index :=Modelica.Utilities.Strings.findLast(name, ".");
    nameShort :=Modelica.Utilities.Strings.substring(
      name,
      index+1,
      Modelica.Utilities.Strings.length(name));
end giveShortName;
