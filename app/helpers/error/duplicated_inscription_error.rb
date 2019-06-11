require_relative 'astapor_error'
class DuplicatedInscriptionError < AstaporError
  def initialize(msg = 'duplicated inscription')
    super(msg)
  end
end
