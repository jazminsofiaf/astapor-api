require_relative 'course'
class ExamCourse < Course
  MODALITY = 'coloquio'.freeze
  attr_reader :modality

  def initialize(data)
    @modality = MODALITY
    super(data)
  end
end
