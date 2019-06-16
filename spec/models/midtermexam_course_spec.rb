require 'rspec'
require_relative '../../models/mid_term_exams_course'

describe 'Mid Term exams course' do
  context 'when create' do
    params = { code: 7557, subject: 'Analisis',
               teacher: 'Sirne', quota: 50, modality: 'tp',
               projector: false, laboratory: false }
    exam_course = MidTermExamsCourse.new(params)
    it 'it should have exam modality' do
      expect(exam_course.modality).to eq('parciales')
    end
  end
end
