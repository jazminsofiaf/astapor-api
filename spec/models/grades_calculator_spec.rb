require 'rspec'

require_relative '../../models/grades_calculator'
require_relative '../../models/course'
require_relative '../../models/student'
require_relative '../../app/helpers/grade_helper'

describe 'GradesCalculator' do
  describe 'Calculation with exams modality - Pass' do
    params = { name: 'Mariano Martin', user_name: 'mar2' }
    student = Student.new(params)
    course_param = { id: 1, code: 9532, subject: 'Memo',
                     teacher: 'villagra', quota: 1, modality: 'parciales' }
    subject = Course.new(course_param)
    student.inscribe_to(subject)
    grade = GradeHelper.new('codigo_materia' => '9532', 'notas' => '[10,6]',
                            'username_alumno' => 'mar2')
    student.add_grade(grade)
    grades_calculator = GradesCalculator.new(student, subject)

    it 'final grade should be equal to the average grade' do
      result = grades_calculator.calculate_final_grade

      expect(result['status']).to eq 'APROBADO'
      expect(result['final_grade']).to eq 8
    end
  end

  describe 'Calculation with exams modality - Does not pass' do
    params = { name: 'AA', user_name: 'AA' }
    student = Student.new(params)
    course_param = { id: 1, code: 9532, subject: 'Memo',
                     teacher: 'villagra', quota: 1, modality: 'parciales' }
    subject = Course.new(course_param)
    student.inscribe_to(subject)
    grade = GradeHelper.new('codigo_materia' => '9532', 'notas' => '[5,5]',
                            'username_alumno' => 'AA')
    student.add_grade(grade)
    grades_calculator = GradesCalculator.new(student, subject)

    it 'mean must be greater or equal than 6 in order to pass' do
      result = grades_calculator.calculate_final_grade

      expect(result['status']).to eq 'DESAPROBADO'
      expect(result['final_grade']).to eq 5
    end
  end

  describe 'Calculation with colloquium - Passes' do
    params = { name: 'AB', user_name: 'AB' }
    student = Student.new(params)
    course_param = { id: 2, code: 9533, subject: 'Memo2',
                     teacher: 'villagra', quota: 1, modality: 'coloquio' }
    subject = Course.new(course_param)
    student.inscribe_to(subject)
    grade = GradeHelper.new('codigo_materia' => '9533', 'notas' => '5',
                            'username_alumno' => 'AB')
    student.add_grade(grade)
    grades_calculator = GradesCalculator.new(student, subject)

    it 'colloquium grade must be greater or equal than 4' do
      result = grades_calculator.calculate_final_grade

      expect(result['status']).to eq 'APROBADO'
      expect(result['final_grade']).to eq 5
    end
  end

  describe 'Minimum grade' do
    params = { name: 'A A A', user_name: 'AAA' }
    student = Student.new(params)
    course_param = { id: 1, code: 9532, subject: 'Memo',
                     teacher: 'villagra', quota: 1, modality: 'parciales' }
    subject = Course.new(course_param)
    student.inscribe_to(subject)
    grade = GradeHelper.new('codigo_materia' => '9532', 'notas' => '[0,0]',
                            'username_alumno' => 'mar2')
    student.add_grade(grade)
    grades_calculator = GradesCalculator.new(student, subject)

    it 'minimum grade is 1' do
      result = grades_calculator.calculate_final_grade

      expect(result['status']).to eq 'DESAPROBADO'
      expect(result['final_grade']).to eq 1
    end
  end
end
