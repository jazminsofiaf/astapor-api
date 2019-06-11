# Helper methods defined here can be accessed
# in any controller or view in the application
require_relative '../../exceptions/astapor_error'
require_relative '../../exceptions/incompatible_request_exception'
require_relative '../../exceptions/duplicated_inscription'
require_relative '../../exceptions/duplicate_subject_exception'
require_relative '../../exceptions/quote_error'
require_relative '../../exceptions/parse_inscription_error'
require_relative '../../exceptions/course_not_found_error'
require_relative '../../exceptions/invalid_grade_error'
require_relative '../../exceptions/student_not_inscripted_error'

AstaporGuarani::App.helpers do
  SPANISH_DEFAULT_ERROR_MSG = 'Astapor Internal Error'.freeze
  SPANISH_ERROR_MSG = { IncompatibleRequestException => 'pedidos_incompatibles',
                        DuplicateSubjectException => 'Materia_Duplicada',
                        DuplicatedInscription => 'Inscripcion_duplicada',
                        QuoteError => 'Cupo_completo',
                        ParseInscriptionError => 'Error de inscripcion',
                        CourseNotFoundError => 'Materia Inexistente',
                        InvalidGradeError => 'nota_invalida', 
                        StudentNotInscriptedError => 'alumno_incorrecto'}.freeze
  def spanish_error_msg(error)
    SPANISH_ERROR_MSG[error.class] || SPANISH_ERROR_MSG
  end
end
