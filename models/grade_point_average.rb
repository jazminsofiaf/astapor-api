require_relative '../app/repositories/students_repository'
require_relative '../app/repositories/courses_repository'
class GradePointAverage
  def initialize(user_name)
    @student = StudentsRepository.new.find_by_user_name(user_name)
  end

  def average(final_grades)
    return nil if final_grades.empty?

    average = final_grades.inject { |sum, grade| sum + grade }.to_f / final_grades.size
    average.round(1)
  end

  def passed_courses_final_grades
    passed = []
    final_grades = []

    @student&.grades&.map do |code, grades|
      course = CoursesRepository.new.find_by_code(code)
      final_grade = course.final_grade(grades)
      final_grades << final_grade
      passed << course.code if course.success(final_grade)
    end
    [passed, final_grades]
  end

  def calculate
    passed, final_grades = passed_courses_final_grades
    { materias_aprobadas: passed.size, nota_promedio: average(final_grades) }
  end
end
