require_relative '../app/repositories/students_repository'
require_relative '../app/repositories/courses_repository'
class GradePointAvarage
  def initialize(user_name)
    @student = StudentsRepository.new.find_by_user_name(user_name)
  end

  def average(final_grades)
    return nil if final_grades.empty?

    average = final_grades.inject { |sum, grade| sum + grade }.to_f / final_grades.size
    average.round(2)
  end

  def calculate
    final_grades = []
    passed = 0
    @student&.grades&.map do |code, grades|
      course = CoursesRepository.new.find_by_code(code)
      final_grade = course.final_grade(grades)
      final_grades << final_grade
      passed += 1 if course.success(final_grade)
    end
    { materiasAprobadas: passed, notaPromedio: average(final_grades) }
  end
end
