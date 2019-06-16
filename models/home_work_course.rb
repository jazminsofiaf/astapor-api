require_relative 'course'
class HomeWorkCourse < Course
  MODALITY = 'tareas'.freeze
  attr_reader :modality

  def initialize(data)
    @modality = MODALITY
    super(data)
  end
end
