require_relative 'astapor_error'
class StudentNotEnrolledError < AstaporError
  def initialize(msg = 'invalid student')
    super msg
  end
end
