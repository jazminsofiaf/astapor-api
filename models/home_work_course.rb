require_relative 'course'
class HomeWorkCourse < Course
  attr_reader :modality
  MINIMUM_REQUIRED = 6
  MINIMUM_GRADE_HOMEWORK = 4
  FAIL_ALLOWED = 1
  ONE = 1

  def initialize(data)
    @modality = self.class.to_s
    super(data)
  end

  def final_grade(student_grades)
    failed = student_grades.select do |grade|
      grade < MINIMUM_GRADE_HOMEWORK
    end
    return ONE if failed.size > FAIL_ALLOWED

    average(student_grades)
  end
end
