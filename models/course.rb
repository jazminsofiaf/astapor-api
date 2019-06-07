require 'active_model'
require_relative '../app/exceptions/incompatible_request_exception'
require_relative '../app/exceptions/duplicate_subject_exception'

class Course
  include ActiveModel::Validations

  attr_accessor :id, :code, :subject, :teacher,
                :quota, :modality, :updated_on, :created_on,
                :projector, :laboratory

  validates :code, presence: true, numericality: { only_integer: true,
                                                   # only four digits
                                                   greater_than: 999,
                                                   less_than: 10_000 }
  validates :quota, presence: true, numericality: { only_integer: true,
                                                    greater_than: 0,
                                                    less_than: 301 }
  validates :subject, presence: true, length: { maximum: 50 }

  def initialize(data = {})
    populate(data)
    validate!
  end

  def populate(data)
    @id = data[:code]
    @code = data[:code]
    @teacher = data[:teacher]
    @subject = data[:subject]
    @quota = data[:quota]
    @modality = data[:modality]
    @updated_on = data[:updated_on]
    @created_on = data[:created_on]
    @projector = data[:projector]
    @laboratory = data[:laboratory]
  end

  def to_json(*_args)
    {
      'code' => @code,
      'subject' => @subject,
      'teacher' => @teacher,
      'quota' => @quota,
      'modality' => @modality,
      'projector' => @projector,
      'laboratory' => @laboratory
    }.to_json
  end

  def validate!
    puts errors.messages if invalid?
    raise IncompatibleRequestException if @projector && @laboratory
  end
end
