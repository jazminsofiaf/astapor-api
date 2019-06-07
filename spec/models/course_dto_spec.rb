require 'rspec'
require_relative '../../app/helpers/course_from_json'
describe 'Course dto' do
  let(:body) do
    '{"codigo": "4444",
      "modalidad": "tareas",
	    "docente": "Linus Torvalds",
	    "nombreMateria": "Sistemas Operativos",
	    "cupo": 30
    }'
  end

  it 'should create a valid course' do
    course = CourseFromJson.parse(body)
    course.code = 4444
    course.quota = 30
    course.teacher = 'Linus Torvalds'
    course.modality = 'tareas'
    course.subject = 'Sistemas Operativos'
  end

  it 'should raise expection forn invalid json' do
    invalid = '{"codigo": "4444",
      "modalidad": "tareas",
	    "docente": "Linus Torvalds",
	    "nombreMateria": "4444",
	    "cupo": 300000
    }'
    expect do
      CourseFromJson.parse(invalid)
    end.to raise_error(IncompatibleRequestException)
  end

  it 'should raise erroneous code if json has less than 4 digits' do
    invalid = '{"codigo": "123",
      "modalidad": "tareas",
	    "docente": "Linus Torvalds",
	    "nombreMateria": "Sistemas Operativos",
	    "cupo": 30
    }'
    expect do
      CourseFromJson.parse(invalid)
    end.to raise_error(ErroneousCode)
  end

  it 'should raise erroneous code if json has more than 4 digits' do
    invalid = '{"codigo": "Sistemas Operativos",
      "modalidad": "tareas",
	    "docente": "Linus Torvalds",
	    "nombreMateria": "12345",
	    "cupo": 30
    }'
    expect do
      CourseFromJson.parse(invalid)
    end.to raise_error(ErroneousCode)
  end
end
