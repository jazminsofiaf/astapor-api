# frozen_string_literal: true

require 'active_model'
require_relative '../app/exceptions/incompatible_request_exception'

# comment
class Course
  include ActiveModel::Validations

  attr_accessor :id, :code, :subject, :teacher,
                :quota, :modality, :updated_on, :created_on,
                :con_proyector, :con_laboratorio

  validates :code, presence: true, length: { minimum: 4, maximum: 4 }
  validates :quota, presence: true, numericality: { only_integer: true,
                                                    greater_than: 0,
                                                    less_than: 301 }

  def initialize(data = {})
    @id = data[:id], @code = data[:code]
    @modality = data[:modality], @teacher = data[:teacher]
    @subject = data[:subject], @quota = data[:quota]
    @updated_on = data[:updated_on], @created_on = data[:created_on]
    @con_proyector = data[:con_proyector]
    @con_laboratorio = data[:con_laboratorio]
    raise IncompatibleRequestException if @con_proyector && @con_laboratorio
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
