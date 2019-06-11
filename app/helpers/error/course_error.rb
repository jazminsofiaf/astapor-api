require_relative 'astapor_error'
class CourseError < AstaporError
  def initialize(msg = 'error in course')
    super(msg)
  end
end
