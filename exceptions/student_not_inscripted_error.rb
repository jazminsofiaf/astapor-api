require_relative 'astapor_error'
class StudentNotInscriptedError < AstaporError
  attr_reader :message
  def initialize(msg = 'ALUMNO_INCORRECTO')
    @message = msg
  end
end
