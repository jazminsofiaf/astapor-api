require 'rspec'
require_relative '../../app/helpers/course_from_json'
describe 'Course dto' do
  let(:body) do
    '{"codigo": "4444",
      "modalidad": "tareas",
	    "docente": "Linus Torvalds",
	    "materia": "Sistemas Operativos",
	    "cupo": 30
    }'
  end

  it 'should create a valid course' do
    course = CourseFromJson.parse(body)
    course.id = 4444
  end
end
