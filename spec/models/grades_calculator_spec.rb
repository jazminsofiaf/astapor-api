require 'rspec'

require_relative '../../models/grades_calculator'
require_relative '../../models/course'
require_relative '../../models/student'
require_relative '../../app/helpers/grade_helper'

describe 'GradesCalculator' do
  grades_calculator = GradesCalculator.new
  params = { name: 'Mariano Martin', user_name: 'mar2' }
  student = Student.new(params)

  describe 'Calculation with exams modality' do
    course_param = { id: 1, code: 9532, subject: 'Memo',
                     teacher: 'villagra', quota: 1, modality: 'parciales' }
    subject = Course.new(course_param)
    student.inscribe_to(subject)
    grade = GradeHelper.new('codigo_materia' => '9532', 'notas' => '[10,6]',
                            'username_alumno' => 'mar2')
    student.add_grade(grade)

    it 'final grade should be equal to the average grade' do
      result = grades_calculator.calculate_final_grade(student, subject)

      expect(result['status']).to eq 'APROBADO'
      expect(result['final_grade']).to eq 8
    end
  end
end
