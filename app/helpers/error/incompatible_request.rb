require_relative 'astapor_error'
class IncompatibleRequest < AstaporError
  def initialize(msg = 'incompatible request exception')
    super(msg)
  end
end
