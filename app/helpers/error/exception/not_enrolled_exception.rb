require_relative 'astapor_exception'
class NotEnrolledException < AstaporException
  def initialize(msg = 'not_enrolled')
    super(msg)
  end
end
