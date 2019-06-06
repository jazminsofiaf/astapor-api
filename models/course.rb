# frozen_string_literal: true

require 'active_model'

# comment
class Course
  include ActiveModel::Validations

  attr_accessor :id, :code, :subject, :teacher,
                :quota, :modality, :updated_on, :created_on

  validates :code, presence: true, length: { maximum: 4 }

  def initialize(data = {})
    @id = data[:id]
    @code = data[:code]
    @modality = data[:modality]
    @teacher = data[:teacher]
    @subject = data[:subject]
    @quota = data[:quota]
    @updated_on = data[:updated_on]
    @created_on = data[:created_on]
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
