require_relative 'astapor_error'
class QuotaError < AstaporError
  def initialize(msg = 'quote must be positive')
    super(msg)
  end
end
