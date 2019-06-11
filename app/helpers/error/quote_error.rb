require_relative 'astapor_error'
class QuoteError < AstaporError
  def initialize(msg = 'limit quote')
    super(msg)
  end
end
