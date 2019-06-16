require_relative '../app/repositories/students_repository'
require_relative '../app/repositories/courses_repository'
class GradePointAverage
  def initialize(user_name)
    @student = StudentsRepository.new.find_by_user_name(user_name)
  end

  def average(final_grades)
    return nil if final_grades.empty?

    average = final_grades.inject { |sum, grade| sum + grade }.to_f / final_grades.size
    average.round(2)
  end

  def passed_courses
    passed = []
    final_grades = []

    @student&.grades&.map do |code, grades|
      course = CoursesRepository.new.find_by_code(code)
      final_grade = course.final_grade(grades)
      final_grades << final_grade
      passed << course if course.success(final_grade)
    end
    [passed, final_grades]
  end

  def calculate
    passed, final_grades = passed_courses
    { materiasAprobadas: passed.size, notaPromedio: average(final_grades) }
  end
end
