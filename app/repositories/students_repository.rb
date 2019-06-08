class StudentsRepository < BaseRepository
  self.table_name = :student
  self.model_class = 'Student'

  def find_by_user_name(user_name)
    load_collection dataset.where(user_name: user_name)
  end

  protected

  def load_object(a_record)
    student = super
    student
  end

  def changeset(student)
    {
      name: student.name,
      user_name: student.user_name
    }
  end
end
