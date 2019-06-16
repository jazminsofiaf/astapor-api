require_relative 'course'
class ExamCourse < Course
  attr_reader :modality
  MINIMUM_REQUIRED = 4

  def initialize(data)
    @modality = self.class.to_s
    super(data)
  end

  def final_grade(grades)
    grades.first
  end

  def success(final_grade)
    final_grade >= MINIMUM_REQUIRED
  end
end
