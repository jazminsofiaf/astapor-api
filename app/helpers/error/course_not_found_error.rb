require_relative 'astapor_error'
class CourseNotFoundError < AstaporError
  def initialize(msg = 'course code not existent')
    super(msg)
  end
end
