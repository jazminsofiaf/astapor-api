require_relative 'astapor_error'
class ParseInscriptionError < AstaporError
  def initialize(msg = 'invalid json')
    super msg
  end
end
