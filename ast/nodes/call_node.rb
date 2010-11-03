require File.expand_path(File.join(File.dirname(__FILE__), "node.rb"))
class CallNode < Node
  def initialize(lineno, receiver, method, arguments=[])
    @lineno = lineno
    @receiver = receiver
    @method = method
    @arguments = arguments
  end
  
  def eval(context)
    # Local variable access
    if @receiver.nil? && context.locals[@method] && @arguments.empty?
      context.locals[@method]
    # Method call
    else
      if @receiver
        receiver = @receiver.eval(context)
      else
        receiver = context.current_self
      end
      arguments = @arguments.map { |arg| arg.eval(context) }
      receiver.call(@method, arguments)
    end
  end
end