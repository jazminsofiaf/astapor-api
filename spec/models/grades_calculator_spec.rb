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
      expect(result[:nota_final]).to eq 8
      expect(result[:estado]).to eq 'APROBADO'
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
      expect(result[:nota_final]).to eq 5
      expect(result[:estado]).to eq 'DESAPROBADO'
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
      expect(result[:nota_final]).to eq 5
      expect(result[:estado]).to eq 'APROBADO'
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

      expect(result[:estado]).to eq 'DESAPROBADO'
      expect(result[:nota_final]).to eq 3
    end
  end

  describe 'Calculation with colloquium - Has no grades' do
    student = Student.new(student_params)
    subject = ExamCourse.new(course_param)
    student.inscribe_to(subject)
    grades_calculator = GradesCalculator.new(student, subject)

    it 'cant get final grade of a non-completed course' do
      result = grades_calculator.calculate_final_grade

      expect(result[:estado]).to eq 'EN_CURSO'
    end
  end

  describe 'Calculation with homework - passes' do
    student = Student.new(student_params)

    subject = HomeWorkCourse.new(course_param)
    student.inscribe_to(subject)
    grade = GradeHelper.new('codigo_materia' => '9532', 'notas' => '[10, 7, 1]',
                            'username_alumno' => 'AB')
    student.add_grade(grade)
    grades_calculator = GradesCalculator.new(student, subject)

    it 'mean must be greater or equal than 6 in order to pass' do
      result = grades_calculator.calculate_final_grade

      expect(result[:estado]).to eq 'APROBADO'
      expect(result[:nota_final]).to eq 6
    end
  end

  describe 'Calculation with homework - does not pass' do
    student = Student.new(student_params)

    subject = HomeWorkCourse.new(course_param)
    student.inscribe_to(subject)
    grade = GradeHelper.new('codigo_materia' => '9532', 'notas' => '[10, 1, 1]',
                            'username_alumno' => 'AB')
    student.add_grade(grade)
    grades_calculator = GradesCalculator.new(student, subject)

    it 'failed homeworks must be less than two in order to pass' do
      result = grades_calculator.calculate_final_grade

      expect(result[:estado]).to eq 'DESAPROBADO'
      expect(result[:nota_final]).to eq 1
    end
  end

  describe 'Minimum grade' do
    student = Student.new(student_params)

    subject = HomeWorkCourse.new(course_param)
    student.inscribe_to(subject)

    grade = GradeHelper.new('codigo_materia' => '9532', 'notas' => '[0,0]',
                            'username_alumno' => 'mar2')
    student.add_grade(grade)
    grades_calculator = GradesCalculator.new(student, subject)

    it 'minimum grade is 1' do
      result = grades_calculator.calculate_final_grade

      expect(result[:estado]).to eq 'DESAPROBADO'
      expect(result[:nota_final]).to eq 1
    end
  end
end
