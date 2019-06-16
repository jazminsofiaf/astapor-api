require_relative 'course'
class HomeWorkCourse < Course
  attr_reader :modality

  def initialize(data)
    @modality = self.class.to_s
    super(data)
  end
end
