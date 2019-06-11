# Helper methods defined here can be accessed
# in any controller or view in the application
require_relative 'error/exception/incompatible_request'
require_relative 'error/duplicate_subject_error'
require_relative 'error/duplicated_inscription_error'
require_relative 'error/quote_error'
require_relative 'error/parse_inscription_error'
require_relative 'error/course_not_found_error'
AstaporGuarani::App.helpers do
  SPANISH_ERROR_MSG = { IncompatibleRequest => 'pedidos_incompatibles',
                        DuplicateSubjectError => 'materia_Duplicada',
                        DuplicatedInscriptionError => 'inscripcion_duplicada',
                        QuoteError => 'cupo_completo',
                        ParseInscriptionError => 'inscripcion_erronea',
                        CourseNotFoundError => 'materia_inexistente' }.freeze
  RESULT = 'resultado'.freeze
  ERROR = 'error'.freeze
  def handle_exception(exception)
    message = SPANISH_ERROR_MSG[exception.class] || exception.msg
    status 400
    { RESULT: message.upcase }.to_json
  end

  def spanish_error(error)
    message = SPANISH_ERROR_MSG[error.class].upcase || error.msg
    status 400
    { ERROR: message.upcase }.to_json
  end
end
