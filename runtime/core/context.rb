# Represents the evaluation context, that tracks values that change depending on where 
# the code is evaluated.
# - "locals" holds local variables.
# - "current_self" is the object on which methods with no receivers are called,
#   eg.: print is like current_self.print
# - "current_class" is the class on which methods are defined with the "def" keyword.
class Context
  attr_reader :locals, :current_self, :current_class
  
  # We store constants as class variable 
  # since they are globally accessible. If you want to
  # implement namespacing of constants, you could store it in the instance of this 
  # class.
  @@constants = {}
  
  def initialize(current_self, current_class=current_self.sandbox_class)
    @locals = {}
    @current_self = current_self
    @current_class = current_class
  end
  
  # Shortcuts to access constants, Runtime[...] instead of Runtime.constants[...]
  def [](name)
    @@constants[name]
  end
  def []=(name, value)
    @@constants[name] = value
  end
  
  def self.bootstrap!
    sandbox_class = SandboxClass.new            # Class is a class
    sandbox_class.sandbox_class = sandbox_class # Class.class == Class
    sandbox_object_class = SandboxClass.new     # Object = Class.new
    
    runtime = Context.new(sandbox_object_class.new)
    sandbox_class.register(runtime)    
    sandbox_object_class.register(runtime)

    SandboxString.new.register(runtime)

    
    # Register the core classes
    runtime["Class"] = sandbox_class
    runtime["Number"] = SandboxClass.new
    runtime["TrueClass"] = SandboxClass.new
    runtime["FalseClass"] = SandboxClass.new
    runtime["NilClass"] = SandboxClass.new
    
    # Register primitives that map to Ruby values
    runtime["true"] = runtime["TrueClass"].new_value(true)
    runtime["false"] = runtime["FalseClass"].new_value(false)
    runtime["nil"] = runtime["NilClass"].new_value(nil)
    
    # Define some Sandbox methods in Ruby. We can use a proc since they respond to "call".
    runtime["Class"].sandbox_methods["new"] = proc do |receiver, arguments|
      # Creates a new instance of the class
      receiver.new
    end
        
    runtime
  end
end