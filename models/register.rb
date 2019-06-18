require 'active_model'
class Register
  include ActiveModel::Validations

  attr_accessor :id, :student_username, :code, :grade, :updated_on, :created_on
  def initialize(data = {})
    @id = data[:id]
    @code = data[:code]
    @student_username = data[:student_username]
    @grade = data[:grade]
    @updated_on = data[:updated_on]
    @created_on = data[:created_on]
  end

  def ==(other)
    (other.class == self.class) &&
      (other.code == code) &&
      (other.student_username == student_username) &&
      (other.grade == grade)
  end
end
