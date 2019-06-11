require_relative 'astapor_exception'
class QuotaRequest < AstaporException
  def initialize(msg = 'quote over limit exception')
    super(msg)
  end
end
