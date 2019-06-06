# frozen_string_literal: true

require 'active_model'

# Class for represent the inscription post request
class InscriptionDto
  include ActiveModel::Validations
  attr_reader :nombre_completo, :codigo_materia, :username_alumno

  validates :username_alumno, presence: true
  validates :codigo_materia, presence: true, numericality: { only_integer: true,
                                                             greater_than: 0,
                                                             less_than: 10_000 }

  def initialize(data)
    @nombre_completo = data['nombre_completo']
    @codigo_materia = data['codigo_materia'].to_i
    @username_alumno = data['username_alumno']
  end
end
