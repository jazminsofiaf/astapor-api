require 'rspec'

require_relative '../../models/grade_point_avarage'
require_relative '../../models/exam_course'
require_relative '../../models/mid_term_exams_course'
require_relative '../../models/home_work_course'
require_relative '../../models/student'
require_relative '../../app/helpers/grade_helper'

describe 'Grade Avarage point ' do
  student_params = { name: 'Jazmin Ferreiro ', user_name: 'jaz' }

  course_param = { id: 1, code: 9532, subject: 'Memo',
                   teacher: 'villagra', quota: 1 }

  context 'when student has a 10 ' do
    student = Student.new(student_params)
    subject = ExamCourse.new(course_param)
    student.inscribe_to(subject)

    grade = GradeHelper.new('codigo_materia' => '9532', 'notas' => '10',
                            'username_alumno' => 'jaz')

    student.add_grade(grade)
    response = GradePointAvarage.new('jaz').calculate
    it 'should have a 10 and 1 course success' do
      expect(response[:notaPromedio]).to eq(10)
      expect(response[:materiasAprobadas]).to eq(1)
    end
  end
end
