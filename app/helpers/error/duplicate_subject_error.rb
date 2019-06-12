require_relative 'astapor_error'
class DuplicateSubjectError < AstaporError
  def initialize(msg = 'duplicated subject')
    super(msg)
  end
end
