# Setting the value of a local variable.
class SetLocalNode
  def initialize(lineno, name, value)
    @lineno = lineno
    @name = name
    @value = value
  end
  
  def eval(context)
    context.locals[@name] = @value.eval(context)
  end
end