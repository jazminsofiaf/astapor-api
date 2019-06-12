require_relative 'astapor_error'
class StudentNotInscribedError < AstaporError
  def initialize(msg = 'invalid student')
    super msg
  end
end
