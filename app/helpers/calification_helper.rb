require 'active_model'
class CalificationHelper
  include ActiveModel::Validations
  attr_reader :code, :grades, :username

  CODE = 'codigo_materia'.freeze
  NOTAS = 'notas'.freeze
  USERNAME = 'username_alumno'.freeze

  CORCHETE = '['.freeze

  def initialize(data)
    @code = data[CODE].to_i
    @grades = parsear_notas(data[NOTAS])
    @username = data[USERNAME]
  end

  def parsear_notas(str_notas)
    if str_notas.include? CORCHETE
      array_str_notas = str_notas[1, str_notas.length - 1].split(',')
      array_int_notas = array_str_notas.collect(&:to_i)
      return array_int_notas
    end
    [str_notas.to_i]
  end
end
