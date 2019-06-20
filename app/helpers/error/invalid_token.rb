require_relative 'astapor_error'
class InvalidToken < AstaporError
  def initialize(msg = 'invalid header token')
    super msg
  end
end
