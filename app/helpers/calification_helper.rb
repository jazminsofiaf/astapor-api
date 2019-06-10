require 'active_model'
require_relative '../../exceptions/invalid_grade_error'

class CalificationHelper
  include ActiveModel::Validations
  attr_reader :code, :grades, :username

  CODE = 'codigo_materia'.freeze
  NOTAS = 'notas'.freeze
  USERNAME = 'username_alumno'.freeze

  ERROR_INVALID_GRADE = 'NOTA_INVALIDA'.freeze

  CORCHETE = '['.freeze

  validates :grade_validation, presence: { message: ERROR_INVALID_GRADE }

  def initialize(data)
    @code = data[CODE].to_i
    @grades = parsear_notas(data[NOTAS])
    @username = data[USERNAME]
    validation
  end

  def parsear_notas(str_notas)
    if str_notas.include? CORCHETE
      array_str_notas = str_notas[1, str_notas.length - 1].split(',')
      array_int_notas = array_str_notas.collect(&:to_i)
      return array_int_notas
    end
    [str_notas.to_i]
  end

  private

  def grade_validation
    grades.each do |grade|
      errors.add(:grades, 'The grade must be lesser than 10 ') if grade > 10 || grade < 1
    end
  end

  def validation
    valid?
    raise InvalidGradeError if invalid?
  end
end
