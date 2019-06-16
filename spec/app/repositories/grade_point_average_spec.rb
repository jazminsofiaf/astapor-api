require 'integration_spec_helper'

require_relative '../../../models/grade_point_average'
require_relative '../../../app/helpers/grade_helper'
require_relative '../../../models/exam_course'
require_relative '../../../app/repositories/students_repository'
require_relative '../../../app/repositories/courses_repository'

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
end
