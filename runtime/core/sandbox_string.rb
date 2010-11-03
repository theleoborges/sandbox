require File.expand_path(File.join(File.dirname(__FILE__), "sandbox_class.rb"))

class SandboxString < SandboxClass
  def register(runtime)
    runtime["String"] = self
    runtime["String"].sandbox_methods["length"] = method(:sb_length)
  end
  
  def sb_length(receiver, arguments)
    Runtime["Number"].new_value(receiver.ruby_value.length)
  end
end