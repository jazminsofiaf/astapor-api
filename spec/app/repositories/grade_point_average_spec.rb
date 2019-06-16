require 'integration_spec_helper'

require_relative '../../../models/grade_point_average'
require_relative '../../../app/helpers/grade_helper'
require_relative '../../../models/exam_course'
require_relative '../../../app/repositories/students_repository'
require_relative '../../../app/repositories/courses_repository'
require_relative '../../../app/helpers/grade_helper'

describe 'Grade Avarage point ' do
  context 'when no grades where set' do
    it 'should have a no grade avarage if student has no grades' do
      response = GradePointAverage.new('m').calculate
      expect(response[:notaPromedio]).to be_nil
      expect(response[:materiasAprobadas]).to eq(0)
    end
  end

  student_params = { name: 'Jazmin Ferreiro ', user_name: 'jaz' }

  course_param = { id: 1, code: 9532, subject: 'Memo',
                   teacher: 'villagra', quota: 1 }

  context 'when student has a 10 ' do
    student = Student.new(student_params)
    subject = ExamCourse.new(course_param)

    student.inscribe_to(subject)

    grade = GradeHelper.new('codigo_materia' => '9532', 'notas' => '10',
                            'username_alumno' => 'jaz')

    it 'should have a 10 and 1 course success' do
      student.add_grade(grade)
      StudentsRepository.new.save(student)
      CoursesRepository.new.save(subject)
      response = GradePointAverage.new('jaz').calculate
      expect(response[:notaPromedio]).to eq(10)
      expect(response[:materiasAprobadas]).to eq(1)
    end
  end

  context 'when ask passed courses' do
    memo_params = { id: 3, code: 9532, subject: 'Memo',
                    teacher: 'villagra', quota: 20 }
    memo = ExamCourse.new(memo_params)
    memo2_param = { id: 4, code: 9502, subject: 'Memo2',
                    teacher: 'paez', quota: 20 }
    memo2 = ExamCourse.new(memo2_param)

    student = Student.new(student_params)

    grade_memo =
      '{"codigo_materia":"9502",'\
  '"notas":"8","username_alumno":"jaz2"}'

    grade_memo2 =
      '{"codigo_materia":"9532",'\
  '"notas":"10","username_alumno":"jaz2"}'

    it 'should return empty array when all the courses to offer have been calificated' do
      student.inscribe_to(memo)
      student.inscribe_to(memo2)
      student.add_grade(GradeHelper.new(JSON.parse(grade_memo)))
      student.add_grade(GradeHelper.new(JSON.parse(grade_memo2)))

      expect(student.passed_courses).to include(9502)
      expect(student.passed_courses).to include(9532)
    end
  end
end
