require File.expand_path(File.join(File.dirname(__FILE__), "node.rb"))

class IfNode
  def initialize(lineno, condition, body, else_body=nil)
    @lineno = lineno
    @condition = condition
    @body = body
    @else_body = else_body
  end
  
  def eval(context)
    if @condition.eval(context).ruby_value
      @body.eval(context)
    elsif @else_body
      @else_body.eval(context)      
    end
    Runtime["nil"]
  end
end