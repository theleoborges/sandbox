require File.expand_path(File.join(File.dirname(__FILE__), "node.rb"))
# Literals are static values that have a Ruby representation, eg.: a string, a number, 
# true, false, nil, etc.
class LiteralNode < Node
  def initialize(lineno, value)
    @lineno = lineno
    @value = value
  end
  
  def eval(context)
    # Here we access the Runtime, which we'll see in the next section.
    case @value
    when Numeric
      Runtime["Number"].new_value(@value)
    when String
      Runtime["String"].new_value(@value)
    when TrueClass
      Runtime["true"]
    when FalseClass
      Runtime["false"]
    when NilClass
      Runtime["nil"]
    else
      raise "Unknown literal type: " + @value.class.name
    end
  end
end