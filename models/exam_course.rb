require_relative 'course'
class ExamCourse < Course
  attr_reader :modality

  def initialize(data)
    @modality = self.class.to_s
    super(data)
  end

  def final_grade(grades)
    grades.first
  end
end
