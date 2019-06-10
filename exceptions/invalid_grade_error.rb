require_relative 'astapor_error'
class InvalidGradeError < AstaporError
  attr_reader :message
  def initialize(msg = 'NOTA_INVALIDA')
    @message = msg
  end
end
