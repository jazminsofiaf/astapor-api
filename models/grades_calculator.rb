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

  def initialize(student, subject)
    @student = student
    @subject = subject
    @grades = []
  end

  def calculate_final_grade
    @grades = @student.grades[@subject.code.to_i] || []
    return { 'status' => 'EN_CURSO', 'final_grade' => nil } if @grades.empty?

    send(MODALITIES[@subject.modality])
  end

  private

  # TODO: - Refactor to avoid repeating code

  def calculate_with_exams
    mean = get_mean(MINIMUM_GRADE)
    status = mean >= MINIMUM_PASS_WITH_EXAMS ? 'APROBADO' : 'DESAPROBADO'

    { 'status' => status, 'final_grade' => mean }
  end

  def calculate_with_colloquium
    status = @grades.first >= MINIMUM_PASS_WITH_COLLOQUIUMS ? 'APROBADO' : 'DESAPROBADO'

    { 'status' => status, 'final_grade' => @grades.first }
  end

  def calculate_with_homework
    failed_homeworks = @grades.select { |item| item < 4 }.length
    if failed_homeworks < MAXIMUM_FAILS_ALLOWED
      mean = get_mean(MINIMUM_GRADE)
      status = mean >= MINIMUM_PASS_WITH_HOMEWORK ? 'APROBADO' : 'DESAPROBADO'
    else
      mean = MINIMUM_GRADE
      status = 'DESAPROBADO'
    end

    { 'status' => status, 'final_grade' => mean }
  end

  def get_mean(_minimum_grade)
    sum = 0
    @grades.each do |grade|
      sum += grade
    end
    mean = if sum >= @grades.length
             sum / @grades.length
           else
             MINIMUM_GRADE
           end
    mean
  end
end
