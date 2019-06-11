require_relative 'astapor_exception'
class IncompatibleRequest < AstaporException
  def initialize(msg = 'incompatible request exception')
    super(msg)
  end
end
