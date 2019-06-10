require_relative 'astapor_error'
class DuplicatedInscription < AstaporError
  def initialize(msg = 'duplicated inscription')
    super(msg)
  end
end
