require 'rspec'
require_relative '../../../app/helpers/course_helper'
describe 'Course dto' do
  let(:body) do
    '{"codigo": "4444",
      "modalidad": "tareas",
	    "docente": "Linus Torvalds",
	    "nombreMateria": "Sistemas Operativos",
	    "cupo": 30
    }'
  end

  let(:invalid) do
    '{"codigo": "a",
      "modalidad": "tareas",
	    "docente": "Linus Torvalds",
	    "cupo": 3000
    }'
  end

  it 'should create a valid course' do
    course = CourseHelper.parse(body)
    course.code = 4444
    course.quota = 30
    course.teacher = 'Linus Torvalds'
    course.modality = 'tareas'
    course.subject = 'Sistemas Operativos'
  end
end
