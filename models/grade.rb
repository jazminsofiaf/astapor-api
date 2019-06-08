require 'active_model'
class Grade
  include ActiveModel::Validations

  attr_accessor :id, :student_id, :code, :grade

  def initialize(data = {})
    @id = data[:id]
    @code = data[:code]
    @student_id = data[:student_id]
    @grade = data[:grade]
  end
end
