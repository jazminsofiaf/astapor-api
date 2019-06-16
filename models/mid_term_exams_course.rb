require_relative 'course'
class MidTermExamsCourse < Course
  attr_reader :modality

  def initialize(data)
    @modality = self.class.to_s
    super(data)
  end

  def final_grade(student_grades)
    student_grades.inject { |sum, grade| sum + grade }.to_f / student_grades.size
  end
end
