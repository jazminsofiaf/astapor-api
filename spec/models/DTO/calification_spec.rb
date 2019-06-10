require 'rspec'
require 'json'
require_relative '../../../app/helpers/calification_helper'
require_relative '../../../exceptions/invalid_grade_error'

describe 'calification dto' do
  context 'created from json string'

  let(:body) do
    '{"codigo_materia":"1001",'\
      '"notas":"8","username_alumno":"juanperez"}'
  end
  let(:calification_dto) { CalificationHelper.new(JSON.parse(body)) }

  it 'should have course code' do
    expect(calification_dto.code).to eq 1001
  end

  it 'should have grade' do
    expect(calification_dto.grades).to eq [8]
  end

  it 'should have the username asociated' do
    expect(calification_dto.username).to eq 'juanperez'
  end

  it 'should accept many notes' do
    body2 = '{"codigo_materia":"1001",'\
      '"notas":"[8, 2]","username_alumno":"juanperez"}'
    calification_dto2 = CalificationHelper.new(JSON.parse(body2))
    expect(calification_dto2.grades).to eq [8, 2]
  end

  it 'should raise InvalidGradeError if a grade is greater than 10' do
    body3 = '{"codigo_materia":"1001",'\
      '"notas":"[8, 11]","username_alumno":"juanperez"}'
    expect { CalificationHelper.new(JSON.parse(body3)) }.to raise_error(InvalidGradeError)
  end

  it 'should raise InvalidGradeError if a grade is negative' do
    body5 = '{"codigo_materia":"1001",'\
      '"notas":"[8, -5]","username_alumno":"juanperez"}'
    expect { CalificationHelper.new(JSON.parse(body5)) }.to raise_error(InvalidGradeError)
  end
end
