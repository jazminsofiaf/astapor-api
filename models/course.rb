require 'active_model'
class Course
  include ActiveModel::Validations

  attr_accessor :id, :code, :subject, :teacher,
                :quota, :modality, :updated_on, :created_on

  def initialize(data = {})
    @id = data[:id]
    @code = data[:code]
    @subject = data[:subject]
    @teacher = data[:teacher]
    @quota = data[:quota]
    @modality = data[:modality]
    @updated_on = data[:updated_on]
    @created_on = data[:created_on]
  end

  def reduce_quota
    @quota -= 1
  end

  def to_json(*_args)
    { 'id' => @id,
      'code' => @code,
      'subject' => @subject,
      'teacher' => @teacher,
      'quota' => @quota,
      'modality' => @modality }.to_json
  end
end
