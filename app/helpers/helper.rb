# Helper methods defined here can be accessed
# in any controller or view in the application
require_relative '../../app/helpers/error/incompatible_request'
require_relative 'error/duplicate_subject_error'
require_relative 'error/duplicated_inscription_error'
require_relative 'error/quote_complete_error'
require_relative 'error/parse_inscription_error'
require_relative 'error/course_not_found_error'
require_relative 'error/invalid_grade_error'
require_relative 'error/student_not_inscribed_error'
require_relative '../../app/helpers/error/quota_error'

AstaporGuarani::App.helpers do
  SPANISH_DEFAULT_ERROR_MSG = 'Astapor Internal Error'.freeze
  SPANISH_ERROR_MSG = { IncompatibleRequest => 'pedidos_incompatibles',
                        DuplicateSubjectError => 'materia_duplicada',
                        DuplicatedInscriptionError => 'inscripcion_duplicada',
                        QuoteCompleteError => 'cupo_completo',
                        ParseInscriptionError => 'error_de_inscripcion',
                        CourseNotFoundError => 'materia_no_existente',
                        InvalidGradeError => 'nota_invalida',
                        StudentNotInscribedError => 'alumno_incorrecto',
                        QuotaError => 'cupo_erroneo' }.freeze

  def handle_error(error)
    message = SPANISH_ERROR_MSG[error.class] || error.msg
    status 400
    { 'error': message.upcase }.to_json
  end
end
