# frozen_string_literal: true

require 'rspec'
require 'json'
require_relative '../../../models/inscription_dto'
describe 'inscription dto' do
  context 'created from json string'

  let(:body) do
    '{"nombre_completo":"Matias Firpo",'\
      '"codigo_materia":"9521","username_alumno":"matiasfirpo"}'
  end
  let(:inscription_dto) { InscriptionDto.new(JSON.parse(body)) }

  it 'should have name' do
    expect(inscription_dto.nombre_completo).to eq 'Matias Firpo'
  end

  it 'should have course id' do
    expect(inscription_dto.codigo_materia).to eq 9521
  end

  it 'should have userid' do
    expect(inscription_dto.username_alumno).to eq 'matiasfirpo'
  end

  it 'empty username is invalid' do
    body = '{"nombre_completo":"Matias Firpo",'\
      '"codigo_materia":"Algebra"}'
    expect(InscriptionDto.new(JSON.parse(body))).not_to be_valid
  end

  it 'invalid format course' do
    body = '{"nombre_completo":"Matias Firpo",'\
      '"codigo_materia":"Algebra","username_alumno":"matiasfirpo"}'
    expect(InscriptionDto.new(JSON.parse(body))).not_to be_valid
  end
end
