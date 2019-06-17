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

  let(:invalid_quota) do
    '{"codigo": "4444",
      "modalidad": "tareas",
      "docente": "Linus Torvalds",
      "nombreMateria": "Sistemas Operativos",
      "cupo": 0
    }'
  end

  let(:invalid_modality) do
    '{"codigo": "4444",
      "modalidad": "tp",
      "docente": "Linus Torvalds",
      "nombreMateria": "Sistemas Operativos",
      "cupo": 30
    }'
  end

  it 'should create a valid course' do
    course = CourseHelper.parse(body)
    expect(course.code).to eq 4444
    expect(course.quota).to eq 30
    expect(course.teacher).to eq 'Linus Torvalds'
    expect(course.modality).to eq 'HomeWorkCourse'
    expect(course.subject).to eq 'Sistemas Operativos'
  end

  it 'should raise exception when quota is 0' do
    expect { CourseHelper.parse(invalid_quota) }.to raise_error(QuotaError)
  end

  it 'should raise exception when modality not exist' do
    expect { CourseHelper.parse(invalid_modality) }.to raise_error(ModalityError)
  end
end
