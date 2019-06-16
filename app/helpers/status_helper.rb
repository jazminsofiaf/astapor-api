class StatusHelper
  USER_NAME = 'usernameAlumno'.freeze
  CODE = 'codigoMateria'.freeze

  def parse(params)
    [params[USER_NAME], params[CODE]]
  end
end
