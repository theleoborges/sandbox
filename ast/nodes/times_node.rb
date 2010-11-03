require File.expand_path(File.join(File.dirname(__FILE__), "node.rb"))

class TimesNode
  def initialize(lineno, left, right)
    @lineno = lineno
    @left = left
    @right = right
  end
  
  def eval(context)
    left = @left.eval(context).ruby_value
    right = @right.eval(context).ruby_value
    Runtime["Number"].new_value(left * right)
  end
end