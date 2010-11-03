require File.expand_path(File.join(File.dirname(__FILE__), "sandbox_object.rb"))

# Represents a Sandbox class in the Ruby world. Classes are objects in Sandbox so they
# inherit from SandboxObject.
class SandboxClass < SandboxObject
  attr_reader :sandbox_methods
  
  # Creates a new class. Number is an instance of Class for example.
  def initialize()
    @sandbox_methods = {}
    
    # Check if we're bootstrapping (launching the runtime). During this process the 
    # runtime is not fully initialized and core classes do not yet exists, so we defer 
    # using those once the language is bootstrapped.
    # This solves the chicken-or-the-egg problem with the Class class. We can 
    # initialize Class then set Class.class = Class.
    if defined?(Runtime)
      sandbox_class = Runtime["Class"]
    else
      sandbox_class = nil
    end
    
    super(sandbox_class)
  end
  
  # Lookup a method
  def lookup(method_name)
    method = @sandbox_methods[method_name]
    unless method
      raise "Method not found: #{method_name}"
    end
    method
  end
  
  # Create a new instance of this Sandbox class
  def new
    SandboxObject.new(self)
  end
  
  # Create an instance of this Sandbox class that holds a Ruby value. Like a String, 
  # Number or true.
  def new_value(value)
    SandboxObject.new(self, value)
  end
  
  def register(runtime)
    runtime["Object"] = self
    runtime["Object"].sandbox_methods["print"] = method(:sb_print)
  end
  
  
  def sb_print(receiver, arguments)
    puts arguments.first.ruby_value
    Runtime["nil"] # Return value for Sandbox
  end  
end