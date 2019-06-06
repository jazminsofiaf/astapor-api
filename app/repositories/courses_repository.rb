# frozen_string_literal: true

require_relative 'base_repository'
# comment
class CoursesRepository < BaseRepository
  self.table_name = :course
  self.model_class = 'Course'

  def find_by_code(code)
    load_collection dataset.where(code: code)
  end

  def search_by_subject(subject)
    load_collection dataset.where(Sequel.like(:subject, "%#{subject}%"))
  end

  protected

  def load_object(a_record)
    curse = super
    curse
  end

  def changeset(course)
    {
      code: course.code,
      subject: course.subject,
      teacher: course.teacher,
      quota: course.quota,
      modality: course.modality,
      projector: course.projector,
      laboratory: course.laboratory
    }
  end
end
