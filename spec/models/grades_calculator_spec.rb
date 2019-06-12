require 'rspec'

require_relative '../../models/grades_calculator'
require_relative '../../models/course'
require_relative '../../models/student'
require_relative '../../app/helpers/grade_helper'

describe 'GradesCalculator' do
  grades_calculator = GradesCalculator.new

  describe 'Calculation with exams modality' do
    params = { name: 'Mariano Martin', user_name: 'mar2' }
    student = Student.new(params)
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

  describe 'Calculation with exams modality' do
    params = { name: 'A A', user_name: 'AA' }
    student = Student.new(params)
    course_param = { id: 1, code: 9532, subject: 'Memo',
                     teacher: 'villagra', quota: 1, modality: 'parciales' }
    subject = Course.new(course_param)
    student.inscribe_to(subject)
    grade = GradeHelper.new('codigo_materia' => '9532', 'notas' => '[5,5]',
                            'username_alumno' => 'mar2')
    student.add_grade(grade)

    it 'mean must be greater than 6 in order to pass' do
      result = grades_calculator.calculate_final_grade(student, subject)

      expect(result['status']).to eq 'DESAPROBADO'
      expect(result['final_grade']).to eq 5
    end
  end
end
