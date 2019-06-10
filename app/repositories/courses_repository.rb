require_relative 'base_repository'

require_relative '../../exceptions/duplicate_subject_exception'

class CoursesRepository < BaseRepository
  self.table_name = :course
  self.model_class = 'Course'

  def find_by_code(code)
    row = dataset.first(code: code)
    load_object(row) unless row.nil?
  end

  def search_by_subject(subject)
    load_collection dataset.where(Sequel.ilike(:subject, "%#{subject}%"))
  end

  def load_dataset
    load_collection dataset
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
