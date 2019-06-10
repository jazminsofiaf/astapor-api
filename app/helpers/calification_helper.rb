require 'active_model'
class CalificationHelper
  include ActiveModel::Validations
  attr_reader :code, :grades, :username

  CODE = 'codigo_materia'.freeze
  NOTAS = 'notas'.freeze

  def initialize(data)
    @code = data[CODE].to_i
    @grades = data[NOTAS].to_i
  end
end
