require 'rspec'

require_relative '../../models/grades_calculator'
require_relative '../../models/exam_course'
require_relative '../../models/mid_term_exams_course'
require_relative '../../models/home_work_course'
require_relative '../../models/student'
require_relative '../../app/helpers/grade_helper'

describe 'GradesCalculator' do
  student_params = { name: 'Mariano Martin', user_name: 'mar2' }

  course_param = { id: 1, code: 9532, subject: 'Memo',
                   teacher: 'villagra', quota: 1 }

  context 'with  mid term exams modality - Pass' do
    student = Student.new(student_params)
    subject = MidTermExamsCourse.new(course_param)
    student.inscribe_to(subject)
    grade = GradeHelper.new('codigo_materia' => '9532', 'notas' => '[10,6]',
                            'username_alumno' => 'mar2')
    student.add_grade(grade)
    grades_calculator = GradesCalculator.new(student, subject)
    result = grades_calculator.calculate_final_grade

    it 'final grade should be equal to the average grade' do
      expect(result[:final_grade]).to eq 8
      expect(result[:status]).to eq 'APROBADO'
    end
  end

  context 'with mid term exams modality - Does not pass' do
    student = Student.new(student_params)
    subject = MidTermExamsCourse.new(course_param)
    student.inscribe_to(subject)

    grade = GradeHelper.new('codigo_materia' => '9532', 'notas' => '[5,5]',
                            'username_alumno' => 'mar2')
    student.add_grade(grade)
    grades_calculator = GradesCalculator.new(student, subject)

    it 'mean must be greater or equal than 6 in order to pass' do
      result = grades_calculator.calculate_final_grade
      expect(result[:final_grade]).to eq 5
      expect(result[:status]).to eq 'DESAPROBADO'
    end
  end

  context 'with colloquium exam - Passes' do
    student = Student.new(student_params)
    subject = ExamCourse.new(course_param)
    student.inscribe_to(subject)

    grade = GradeHelper.new('codigo_materia' => '9532', 'notas' => '5',
                            'username_alumno' => 'mar2')
    student.add_grade(grade)
    grades_calculator = GradesCalculator.new(student, subject)

    it 'colloquium grade must be greater or equal than 4' do
      result = grades_calculator.calculate_final_grade
      expect(result[:final_grade]).to eq 5
      expect(result[:status]).to eq 'APROBADO'
    end
  end

  context 'with colloquium - Does not pass' do
    student = Student.new(student_params)
    subject = ExamCourse.new(course_param)
    student.inscribe_to(subject)
    grade = GradeHelper.new('codigo_materia' => '9532', 'notas' => '3',
                            'username_alumno' => 'mar2')
    student.add_grade(grade)
    grades_calculator = GradesCalculator.new(student, subject)

    it 'colloquium grade must be greater or equal than 4' do
      result = grades_calculator.calculate_final_grade

      expect(result[:status]).to eq 'DESAPROBADO'
      expect(result[:final_grade]).to eq 3
    end
  end
end
