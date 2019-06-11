require 'active_model'

# comment
class Course
  include ActiveModel::Validations

  LIMIT = 0
  MSG = 1

  attr_accessor :id, :code, :subject, :teacher,
                :quota, :modality, :updated_on, :created_on,
                :projector, :laboratory

  validates :code, length: { minimum: 4,
                             maximum: 4,
                             message: 'codigo_erroneo' }
  validates_presence_of :code, message: 'codigo_erroneo'

  validates :quota, presence: true, numericality: { only_integer: true,
                                                    greater_than_or_equal_to: 0 }
  validates_numericality_of :quota, less_than: 301, message: 'cupo_excedido'

  validates :subject, length: { maximum: 50,
                                message: 'nombre_erroneo' }
  validates_presence_of :subject, message: 'nombre_erroneo'

  def initialize(data = {})
    populate(data)
    validation
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

  def validation
    begin
      validate!
    rescue ActiveModel::ValidationError
      msg = errors.messages.first[MSG].first
      raise QuotaRequest, msg if errors.details.keys.first.equal?(:quota)

      raise CourseError, msg
    end
    raise IncompatibleRequest if @laboratory && @projector
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
end
