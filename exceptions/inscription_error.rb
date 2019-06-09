class InscriptionError < AstaporError
  DEFAULT_MSG = 'CURSO_INEXISTENTE'.freeze
  def initialize(msg = DEFAULT_MSG)
    @msg = msg
  end
end
