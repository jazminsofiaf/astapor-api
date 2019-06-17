require_relative 'course'
class MidTermExamsCourse < Course
  attr_reader :modality
  MINIMUM_REQUIRED = 6

  def initialize(data)
    @modality = self.class.to_s
    super(data)
  end

  def final_grade(student_grades)
    average(student_grades)
  end
end
