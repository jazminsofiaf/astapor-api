require_relative 'astapor_error'
class CourseNotFoundError < AstaporError
  def initialize(msg = 'course code inexistent')
    super(msg)
  end
end
