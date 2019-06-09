require 'active_model'
require_relative '../../exceptions/parse_inscription_error'
class InscriptionHelper
  include ActiveModel::Validations
  attr_reader :complete_name, :code, :username

  NAME = 'nombre_completo'.freeze
  ERROR = '_error'.freeze
  CODE = 'codigo_materia'.freeze
  USER_NAME = 'username_alumno'.freeze

  validates :username, presence: { message: NAME + ERROR }
  validates :code, presence: { message: CODE + ERROR },
                   numericality: { only_integer: true, greater_than: 999,
                                   less_than: 10_000, message: CODE + ERROR }

  def initialize(data)
    @complete_name = data[NAME]
    @code = data[CODE].to_i
    @username = data[USER_NAME]
    validation
  end

  def validation
    valid?
    raise ParseInscriptionError, errors.messages.values.first if invalid?
  end
end
