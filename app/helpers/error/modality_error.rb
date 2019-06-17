require_relative 'astapor_error'
class ModalityError < AstaporError
  def initialize(msg = 'modality not exist')
    super(msg)
  end
end
