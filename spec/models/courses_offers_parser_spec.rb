require 'rspec'
require_relative '../../models/courses_offers_parser'
require_relative '../../models/course'

describe 'Course Offers Parser' do
  let(:course1) do
    Course.new(code: 7515, subject: 'Analisis',
               teacher: 'Sirne', quota: 301, modality: 'tp',
               projector: false, laboratory: false)
  end
  let(:parser) { CoursesOffersParser.new }

  it 'should create an empty array when thera are no courses to parse' do
    expect(parser.parse([]).size).to eq 0
  end
end
