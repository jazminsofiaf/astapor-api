require_relative 'astapor_error'
class CourseApprovedError < AstaporError
  def initialize(msg = 'the course is already approved')
    super(msg)
  end
end
