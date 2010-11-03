require File.expand_path(File.join(File.dirname(__FILE__), "node.rb"))

class ReturnNode < Node
  def initialize(lineno, expression)
    @lineno = lineno
    @expression = expression
  end
  
  def eval(context)
    raise ReturnJump.new(@expression.eval(context))
  end
end