require 'active_model'
require_relative '../exceptions/incompatible_request_exception'
require_relative '../exceptions/duplicate_subject_exception'

# comment
class Course
  include ActiveModel::Validations

  LIMIT = 0

  attr_accessor :id, :code, :subject, :teacher,
                :quota, :modality, :updated_on, :created_on,
                :projector, :laboratory

  validates :code, length: { minimum: 4,
                             maximum: 4,
                             message: 'CODIGO_ERRONEO' }
  validates_presence_of :code, message: 'CODIGO_ERRONEO'

  validates :quota, presence: true, numericality: { only_integer: true,
                                                    greater_than: 0 }
  validates_numericality_of :quota, less_than: 301, message: 'cupo_excedido'

  validates :subject, length: { maximum: 50,
                                message: 'NOMBRE_ERRONEO' }
  validates_presence_of :subject, message: 'NOMBRE_ERRONEO'

  def initialize(data = {})
    populate(data)
    validate!
  end

  def populate(data)
    @id = data[:id]
    @code = data[:code]
    @subject = data[:subject]
    @teacher = data[:teacher]
    @quota = data[:quota]
    @modality = data[:modality]
    @updated_on = data[:updated_on]
    @created_on = data[:created_on]
    @projector = data[:projector]
    @laboratory = data[:laboratory]
  end

  def reduce_quota
    @quota -= 1
    raise QuoteError if @quota < LIMIT
  end

  def to_json(*_args)
    { 'id' => @id,
      'code' => @code,
      'subject' => @subject,
      'teacher' => @teacher,
      'quota' => @quota,
      'modality' => @modality,
      'projector' => @projector,
      'laboratory' => @laboratory }.to_json
  end

  def validate!
    raise IncompatibleRequestException if @projector && @laboratory
  end
end
