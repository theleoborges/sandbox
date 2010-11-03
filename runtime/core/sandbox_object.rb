# Represents an Sandbox object instance in the Ruby world.
class SandboxObject
  attr_accessor :sandbox_class, :ruby_value
  
  # Each object have a class (named sandbox_class to prevent errors with Ruby's class
  # method). Optionaly an object can hold a Ruby value (eg.: numbers and strings).
  def initialize(sandbox_class, ruby_value=self)
    @sandbox_class = sandbox_class
    @ruby_value = ruby_value
  end
  
  # Call a method on the object.
  def call(method, arguments)
    # Like a typical Class-based runtime model, we store methods in the class of the
    # object.
    @sandbox_class.lookup(method).call(self, arguments)
  end
end