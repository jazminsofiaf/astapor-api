require_relative 'course'
class MidTermExamsCourse < Course
  MODALITY = 'parciales'.freeze
  attr_reader :modality

  def initialize(data)
    @modality = MODALITY
    super(data)
  end
end
