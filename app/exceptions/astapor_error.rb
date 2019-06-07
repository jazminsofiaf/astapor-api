class AstaporError < StandardError
  def initialize(msg = 'Internal exception')
    super(msg)
  end
end
