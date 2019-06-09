# Helper methods defined here can be accessed
# in any controller or view in the application
require_relative '../../exceptions/duplicated_inscription'
require_relative '../../exceptions/parse_inscription_error'
require_relative '../../exceptions/inscription_error'
AstaporGuarani::App.helpers do
  SPANISH_DEFAULT_ERROR_MSG = 'Astapor Internal Errir'.freeze
  SPANISH_ERROR_MSG = { DuplicatedInscription => 'Materia duplicada',
                        ParseInscriptionError => 'Error de inscripcion',
                        InscriptionError => 'Materia Inexistente' }.freeze
  def spanish_error_msg(error)
    SPANISH_ERROR_MSG[error.class] || SPANISH_ERROR_MSG
  end
end
