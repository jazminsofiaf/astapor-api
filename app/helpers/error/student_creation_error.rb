require_relative 'astapor_error'
class StudentCreationError < AstaporError
  def initialize(msg = 'internal error at creating student')
    super(msg)
  end
end
