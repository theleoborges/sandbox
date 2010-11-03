Dir[File.dirname(__FILE__) + '/nodes/*.rb'].each {|file| require file }

# Collection of nodes each one representing an expression.
class Nodes
  def initialize(nodes)
    @nodes = nodes
  end
  
  def <<(node)
    @nodes << node
    self
  end
  
  # This method is the "interpreter" part of our language. All nodes know how to eval 
  # itself and returns the result of its evaluation by implementing the "eval" method.
  # The "context" variable is the environment in which the node is evaluated (local
  # variables, current class, etc.).
  def eval(context)
    # The last value evaluated in a method is the return value.
    @nodes.map { |node| node.eval(context) }.last
  end
end