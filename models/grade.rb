require 'active_model'
class Grade
  include ActiveModel::Validations

  attr_accessor :id, :student_id, :code, :grade, :updated_on, :created_on
  def initialize(data = {})
    @id = data[:id]
    @code = data[:code]
    @student_id = data[:student_id]
    @grade = data[:grade]
    @updated_on = data[:updated_on]
    @created_on = data[:created_on]
  end
end
