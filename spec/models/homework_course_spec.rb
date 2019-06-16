require 'rspec'
require_relative '../../models/home_work_course'
describe 'Home Work course' do
  context 'when create' do
    params = { code: 7557, subject: 'Analisis',
               teacher: 'Sirne', quota: 50, modality: 'tp',
               projector: false, laboratory: false }
    exam_course = ExamCourse.new(params)
    it 'it should have exam modality' do
      expect(exam_course.modality).to eq('coloquio')
    end
  end
end
