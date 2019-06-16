require 'json'
require_relative '../../models/course'
require_relative '../../app/helpers/error/quota_error'
require_relative '../../app/helpers/error/modality_error'
require_relative '../../models/mid_term_exams_course'
require_relative '../../models/exam_course'
require_relative '../../models/home_work_course'

class CourseHelper
  CODE_KEY = 'codigo'.freeze
  SUBJECT_NAME_KEY = 'nombreMateria'.freeze
  TEACHER_KEY = 'docente'.freeze
  QUOTA_KEY = 'cupo'.freeze
  MODALITY_KEY = 'modalidad'.freeze
  PROJECTOR_KEY = 'proyector'.freeze
  LAB_KEY = 'laboratorio'.freeze
  LIMIT = 0

  COURSES_TYPES = {
    'parciales' => MidTermExamsCourse,
    'tareas' => HomeWorkCourse,
    'coloquio' => ExamCourse
  }.freeze

  def self.parse(json)
    input = JSON.parse(json)
    args = { code: input[CODE_KEY],
             subject: input[SUBJECT_NAME_KEY],
             teacher: input[TEACHER_KEY],
             quota: input[QUOTA_KEY],
             projector: input[PROJECTOR_KEY],
             laboratory: input[LAB_KEY] }

    raise QuotaError if args[:quota] == LIMIT

    modality = input[MODALITY_KEY]
    raise ModalityError unless COURSES_TYPES.keys.include? modality

    COURSES_TYPES[modality].new(args)
  end
end
