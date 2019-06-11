require 'active_model'
require_relative 'error/invalid_grade_error'
require_relative '../repositories/register_repository'
require_relative '../../models/register'

class CalificationHelper
  include ActiveModel::Validations
  attr_reader :code, :grades, :username, :grades_string

  CODE = 'codigo_materia'.freeze
  NOTAS = 'notas'.freeze
  USERNAME = 'username_alumno'.freeze

  ERROR_INVALID_GRADE = 'NOTA_INVALIDA'.freeze

  BRACE = '['.freeze

  validates :grade_validation, presence: { message: ERROR_INVALID_GRADE }

  def initialize(data)
    @grades_string = data[NOTAS]
    @code = data[CODE].to_i
    @grades = parse_grades(data[NOTAS])
    @username = data[USERNAME]
    validation
  end

  def save_registers
    grades.each do |grade|
      reg = Register.new(code: @code, grade: grade, student_username: @username)
      RegisterRepository.new.save(reg)
    end
  end

  private

  def grade_validation
    errors.add(:grades, 'invalid grade') if grades.include?(0) && !grades_string.include?('0')
    grades.each do |grade|
      errors.add(:grades, 'invalid grade') if grade > 10 || grade.negative?
    end
  end

  def validation
    valid?
    raise InvalidGradeError, errors.messages.values.first if invalid?
  end

  def parse_grades(str_grades)
    if str_grades.include? BRACE
      array_str_grades = str_grades[1, str_grades.length - 1].split(',')
      array_int_grades = array_str_grades.collect(&:to_i)
      return array_int_grades
    end
    [str_grades.to_i]
  end
end
