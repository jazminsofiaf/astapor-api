require_relative 'astapor_error'
class StudentNotInscriptedError < AstaporError
  def initialize(msg = 'invalid student')
    super msg
  end
end
