require 'byebug'

class GradesCalculator
  MODALITIES = { 'parciales' => 'calculate_with_exams',
                 'coloquio' => 'calculate_with_colloquium',
                 'tareas' => 'calculate_with_homework' }.freeze
  MINIMUM_GRADE = 1
  MINIMUM_PASS_WITH_EXAMS = 6
  MINIMUM_PASS_WITH_COLLOQUIUMS = 4
  MINIMUM_PASS_WITH_HOMEWORK = 6
  MAXIMUM_FAILS_ALLOWED = 2
  IN_COURSE = 'EN_CURSO'.freeze
  NOT_ENROLLED = 'NO_INSCRIPTO'.freeze
  FAIL = 'DESAPROBADO'.freeze
  PASS = 'APROBADO'.freeze

  def initialize(student, subject)
    @student = student
    @course = subject
    @grades = []
  end

  def calculate_final_grade
    @grades = @student.grades[@course.code.to_i] || []
    if @grades.empty?
      return { estado: IN_COURSE, nota_final: nil } if @student.is_inscribed_in(@course)

      return { estado: NOT_ENROLLED, nota_final: nil }
    end

    final_grade = @course.final_grade(@grades)
    pass = @course.success(final_grade)
    status = pass ? PASS : FAIL
    { estado: status, nota_final: final_grade }
  end
end
