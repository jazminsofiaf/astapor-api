require 'json'
require_relative '../../models/course'
require_relative '../../exceptions/invalid_course_error'

class CourseHelper
  CODE_KEY = 'codigo'.freeze
  SUBJECT_NAME_KEY = 'nombreMateria'.freeze
  TEACHER_KEY = 'docente'.freeze
  QUOTA_KEY = 'cupo'.freeze
  MODALITY_KEY = 'modalidad'.freeze
  PROJECTOR_KEY = 'proyector'.freeze
  LAB_KEY = 'laboratorio'.freeze

  def self.parse(json)
    input = JSON.parse(json)

    args = { code: input[CODE_KEY],
             subject: input[SUBJECT_NAME_KEY],
             teacher: input[TEACHER_KEY],
             quota: input[QUOTA_KEY],
             modality: input[MODALITY_KEY],
             projector: input[PROJECTOR_KEY],
             laboratory: input[LAB_KEY] }

    Course.new(args)
  end
end
