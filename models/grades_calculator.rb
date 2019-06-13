require 'byebug'

class GradesCalculator
  MODALITIES = { 'parciales' => 'calculate_with_exams',
                 'coloquio' => 'calculate_with_colloquium' }.freeze
  MINIMUM_GRADE = 1
  MINIMUM_PASS_WITH_EXAMS = 6
  MINIMUM_PASS_WITH_COLLOQUIUMS = 4

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
    sum = 0
    @grades.each do |grade|
      sum += grade
    end
    mean = if sum >= @grades.length
             sum / @grades.length
           else
             MINIMUM_GRADE
           end
    status = mean >= MINIMUM_PASS_WITH_EXAMS ? 'APROBADO' : 'DESAPROBADO'

    { 'status' => status, 'final_grade' => mean }
  end

  def calculate_with_colloquium
    status = @grades.first >= MINIMUM_PASS_WITH_COLLOQUIUMS ? 'APROBADO' : 'DESAPROBADO'

    { 'status' => status, 'final_grade' => @grades.first }
  end
end
