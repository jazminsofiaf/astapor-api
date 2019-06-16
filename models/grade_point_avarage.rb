class GradePointAvarage
  def initialize(user_name)
    @student = StudentsRepository.new.find_by_user_name(user_name)
  end

  def calculate
    average = 10
    success = 1
    { materiasAprobadas: success, notaPromedio: average }
  end
end
