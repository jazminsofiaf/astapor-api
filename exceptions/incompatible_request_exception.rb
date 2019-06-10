require_relative 'astapor_error'
class IncompatibleRequestException < AstaporError
  def initialize(msg = 'incompatible request exception')
    super(msg)
  end
end
