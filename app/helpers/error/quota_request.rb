require_relative 'astapor_error'
class QuotaRequest < AstaporError
  def initialize(msg = 'quote over limit exception')
    super(msg)
  end
end
