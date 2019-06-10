require_relative 'astapor_error'
class InvalidGradeError < AstaporError
  def initialize(msg = 'invalid grade')
    super(msg)
  end
end
