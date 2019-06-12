require_relative 'astapor_error'
class QuoteCompleteError < AstaporError
  def initialize(msg = 'limit quote')
    super(msg)
  end
end
