require File.expand_path(File.join(File.dirname(__FILE__), "node.rb"))

class GtNode
  def initialize(lineno, left, right)
    @lineno = lineno
    @left = left
    @right = right
  end
  
  def eval(context)
    left = @left.eval(context).ruby_value
    right = @right.eval(context).ruby_value
    if left > right
      return Runtime["true"]
    else
      return Runtime["false"]      
    end
  end
end