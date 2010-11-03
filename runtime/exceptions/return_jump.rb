class ReturnJump < Exception
  attr_reader :return_value
  def initialize(return_value)
    @return_value = return_value
  end
end