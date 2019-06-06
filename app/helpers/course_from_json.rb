# rubocop:disable Style/Documentation

# frozen_string_literal: true

require 'json'
require_relative '../../models/course'
require 'byebug'

class CourseFromJson
  CODE_KEY = 'codigo'
  SUBJECT_NAME_KEY = 'nombreMateria'
  TEACHER_KEY = 'docente'
  QUOTA_KEY = 'cupo'
  MODALITY_KEY = 'modalidad'
  PROJECTOR_KEY = 'proyector'
  LAB_KEY = 'laboratiorio'
  KEYS = [CODE_KEY, SUBJECT_NAME_KEY, TEACHER_KEY, QUOTA_KEY,
          MODALITY_KEY, PROJECTOR_KEY, LAB_KEY].freeze

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
# rubocop:enable Style/Documentation
