require 'rspec'
require_relative '../../../app/helpers/courses_offers_parser'
require_relative '../../../models/course'

describe 'Course Offers Parser' do
  let(:course1) do
    Course.new(code: 7515, subject: 'Analisis',
               teacher: 'Sirne', quota: 300, students: 100, modality: 'tp',
               projector: false, laboratory: false)
  end
  let(:parser) { CoursesOffersParser.new }

  it 'should create an empty array when there are no courses to parse' do
    expect(parser.parse([]).size).to eq 0
  end
  describe 'when one course is parsed' do
    it 'it should create nombre from the name of the course' do
      result = parser.parse([course1])
      expect(result.size).to eq 1
      expect(result[0][:nombre]).to eq course1.subject
    end

    it 'it should create codigo from  code of the course' do
      result = parser.parse([course1])
      expect(result.size).to eq 1
      expect(result[0][:codigo]).to eq course1.code
    end

    it 'it should create docente from the name of the teacher of the course' do
      result = parser.parse([course1])
      expect(result.size).to eq 1
      expect(result[0][:docente]).to eq course1.teacher
    end

    it 'it should create cupo from quota' do
      result = parser.parse([course1])
      expect(result.size).to eq 1
      expect(result[0][:cupo]).to eq course1.quota
    end

    it 'it should create cupos_disponibles from quota available of the course' do
      result = parser.parse([course1])
      expect(result.size).to eq 1
      expect(result[0][:cupo_disponible]).to eq 200
    end

    it 'it should create modalidad from the modality of the course' do
      result = parser.parse([course1])
      expect(result.size).to eq 1
      expect(result[0][:modalidad]).to eq course1.modality
    end
  end
end
