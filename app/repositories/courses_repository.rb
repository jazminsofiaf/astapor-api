require_relative 'base_repository'

class CoursesRepository < BaseRepository
  self.table_name = :course
  self.model_class = 'Course'

  def save(a_record)
    if find_dataset_by_code(a_record.code).first
      update(a_record).positive?
    else
      !insert(a_record).id.nil?
    end
  end

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

  def find_dataset_by_code(code)
    dataset.where(code: code)
  end

  def load_object(a_record)
    Object.const_get(a_record[:modality]).new(a_record)
  end

  def changeset(course)
    {
      code: course.code,
      subject: course.subject,
      teacher: course.teacher,
      quota: course.quota,
      students: course.students,
      modality: course.modality,
      projector: course.projector,
      laboratory: course.laboratory
    }
  end
end
