require_relative 'course'
class HomeWorkCourse < Course
  attr_reader :modality

  def initialize(data)
    @modality = self.class.to_s
    super(data)
  end

  def final_grade(student_grades)
    average(student_grades)
  end
end
