require_relative 'astapor_error'
class InvalidCourseError < AstaporError
  def initialize(msg = 'invalid course')
    super(msg)
  end
end
