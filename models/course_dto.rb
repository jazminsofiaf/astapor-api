require 'active_model'
require_relative 'course'

# parsear la clase de curso que viene en el json del POST
class CourseDto
  def initialize(data)
    @codigo = data['codigo']
    @modalidad = data['modalidad']
    @docente = data['docente']
    @materia = data['materia']
    @cupo = data['cupo']
  end

  def to_course
    Course.new(id: @codigo, code: @codigo, modalidad: @modalidad,
               teacher: @docente, subject: @materia, quota:  @cupo)
  end
end
