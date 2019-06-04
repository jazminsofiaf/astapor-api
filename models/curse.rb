# frozen_string_literal: true

# comment
class Curse
  include ActiveModel::Validations

  attr_accessor :code, :subject, :teacher,
                :quota, :modality

  def initialize(data = {})
    @code = data[:code]
    @subject = data[:subject]
    @teacher = data[:teacher]
    @quota = data[:quota]
    @modality = data[:modality]
  end

  def to_json(*_args)
    { 'code' => @code,
      'subject' => @subject,
      'teacher' => @teacher,
      'quota' => @quota,
      'modality' => @modality }.to_json
  end
end
