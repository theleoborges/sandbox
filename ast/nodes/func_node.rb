require File.expand_path(File.join(File.dirname(__FILE__), "node.rb"))
# Method definition.
class FuncNode < Node
  def initialize(lineno, name, params, body)
    @lineno = lineno
    @name = name
    @params = params
    @body = body
  end
  
  def eval(context)
    context.current_class.sandbox_methods[@name] = SandboxMethod.new(@params, @body)
  end
end