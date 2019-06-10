require_relative 'astapor_error'
class DuplicateSubjectException < AstaporError
  def initialize(msg = 'duplicated subject')
    super(msg)
  end
end
