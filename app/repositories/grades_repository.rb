require_relative 'base_repository'
class GradesRepository < BaseRepository
  self.table_name = :grade
  self.model_class = 'Grade'

  def find_by_student_id(student_id)
    load_collection dataset.where(student_id: student_id)
  end

  protected

  def load_object(a_record)
    grade = super
    grade
  end

  def changeset(grade)
    {
      code: grade.code,
      sutudent_id: grade.student_id,
      grade: grade.grade
    }
  end
end
