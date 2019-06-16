require 'rspec'
require_relative '../../models/home_work_course'
describe 'Home Work course' do
  params = { code: 7557, subject: 'Analisis',
             teacher: 'Sirne', quota: 50, modality: 'tp',
             projector: false, laboratory: false }
  course = HomeWorkCourse.new(params)

  context 'when create' do
    it 'it should have exam modality' do
      expect(course.modality).to eq('HomeWorkCourse')
    end
  end

  context 'when calculate final grade' do
    it 'final grade should be equal to avarage' do
      expect(course.final_grade([5, 6, 7, 8])).to eq(6.5)
    end
  end
end
