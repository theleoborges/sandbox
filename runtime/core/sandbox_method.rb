require File.expand_path(File.join(File.dirname(__FILE__), "../exceptions", "return_jump"))

class SandboxMethod
  def initialize(params, body)
    @params = params
    @body = body
  end
  
  def call(receiver, arguments)
    context = Context.new(receiver)
    @params.each_with_index do |param, index|
      context.locals[param] = arguments[index]
    end
    begin
      @body.eval(context)
    rescue ReturnJump => e
      e.return_value
    end
  end
end