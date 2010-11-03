class Node
  attr_reader :lineno
  
  def eval(context); raise "You should subclass the Node class"; end
end