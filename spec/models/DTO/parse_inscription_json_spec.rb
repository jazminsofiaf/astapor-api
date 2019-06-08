require 'rspec'
require 'json'
require_relative '../../../models/parse_inscription_json'
require_relative '../../../exceptions/parse_inscription_error'
describe 'inscription dto' do
  context 'created from json string'

  let(:body) do
    '{"nombre_completo":"Matias Firpo",'\
      '"codigo_materia":"9521","username_alumno":"matiasfirpo"}'
  end
  let(:inscription_dto) { ParseInscriptionJson.new(JSON.parse(body)) }

  it 'should have name' do
    expect(inscription_dto.complete_name).to eq 'Matias Firpo'
  end

  it 'should have course id' do
    expect(inscription_dto.code).to eq 9521
  end

  it 'should have userid' do
    expect(inscription_dto.username).to eq 'matiasfirpo'
  end

  it 'valid json' do
    expect { ParseInscriptionJson.new(JSON.parse(body)) }
      .not_to raise_error(ParseInscriptionError)
  end

  it 'empty username is invalid' do
    body = '{"nombre_completo":"Matias Firpo",'\
      '"codigo_materia":"Algebra"}'
    expect { ParseInscriptionJson.new(JSON.parse(body)) }
      .to raise_error(ParseInscriptionError)
  end

  it 'invalid format course' do
    body = '{"nombre_completo":"Matias Firpo",'\
      '"codigo_materia":"Algebra","username_alumno":"matiasfirpo"}'
    expect { ParseInscriptionJson.new(JSON.parse(body)) }
      .to raise_error(ParseInscriptionError)
  end
end
