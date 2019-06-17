class ParamsHelper
  USER_NAME = 'usernameAlumno'.freeze
  CODE = 'codigoMateria'.freeze

  def self.code(params)
    params[CODE]
  end

  def self.user_name(params)
    params[USER_NAME]
  end

  def self.status_parse(params)
    [user_name(params), code(params)]
  end
end
