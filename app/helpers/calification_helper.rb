require 'active_model'
class CalificationHelper
  include ActiveModel::Validations
  attr_reader :code, :grades, :username

  CODE = 'codigo_materia'.freeze

  def initialize(data)
    @code = data[CODE].to_i
  end
end
