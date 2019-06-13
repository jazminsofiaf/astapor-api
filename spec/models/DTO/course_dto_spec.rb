require 'rspec'
require_relative '../../../app/helpers/course_helper'
require_relative '../../../app/helpers/error/quota_error'
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
    '{"codigo": "4444",
      "modalidad": "tareas",
      "docente": "Linus Torvalds",
      "nombreMateria": "Sistemas Operativos",
      "cupo": 0
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

  it 'should raise exception when quota is 0' do
    expect { CourseHelper.parse(invalid) }.to raise_error(QuotaError)
  end
end
