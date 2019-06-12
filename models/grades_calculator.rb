require 'byebug'

class GradesCalculator
  def calculate_final_grade(student, subject)
    grades = student.grades[subject.code.to_i]
    sum = 0
    grades.each do |grade|
      sum += grade
    end
    # Refactor out magic numbers
    mean = if sum > 2
             sum / 2
           else
             1
           end
    estado = mean > 6 ? 'APROBADO' : 'DESAPROBADO'

    { 'status' => estado, 'final_grade' => mean }
  end
end
