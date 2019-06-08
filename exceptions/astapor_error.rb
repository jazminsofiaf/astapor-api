class AstaporError < RuntimeError
  attr_reader :msg
  def initialize(msg = 'internal error')
    @msg = msg
  end
end
