require 'rspec'
require 'json'
require_relative '../../../app/helpers/calification_helper'

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
    expect(calification_dto.grades).to eq 8
  end
end
