class AstaporException < RuntimeError
  attr_reader :msg
  def initialize(msg)
    @msg = msg
  end
end
