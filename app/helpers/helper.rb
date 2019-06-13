# Helper methods defined here can be accessed
# in any controller or view in the application
require_relative 'error/exception/incompatible_request'
require_relative 'error/duplicate_subject_error'
require_relative 'error/duplicated_inscription_error'
require_relative 'error/quote_error'
require_relative 'error/parse_inscription_error'
require_relative 'error/course_not_found_error'
require_relative 'error/invalid_grade_error'
require_relative 'error/student_not_inscripted_error'

AstaporGuarani::App.helpers do
  SPANISH_DEFAULT_ERROR_MSG = 'Astapor Internal Error'.freeze
  SPANISH_ERROR_MSG = { IncompatibleRequest => 'pedidos_incompatibles',
                        DuplicateSubjectError => 'Materia_Duplicada',
                        DuplicatedInscriptionError => 'Inscripcion_duplicada',
                        QuoteError => 'Cupo_completo',
                        ParseInscriptionError => 'Error de inscripcion',
                        CourseNotFoundError => 'Materia Inexistente',
                        InvalidGradeError => 'nota_invalida',
                        StudentNotInscriptedError => 'alumno_incorrecto' }.freeze
  def handle_exception(exception)
    message = SPANISH_ERROR_MSG[exception.class] || exception.msg
    status 400
    { 'resultado': message }.to_json
  end

  def handle_error(error)
    message = SPANISH_ERROR_MSG[error.class] || error.msg
    status 400
    { 'error': message.upcase }.to_json
  end
end
