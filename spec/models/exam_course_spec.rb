require 'rspec'
require_relative '../../models/exam_course'
describe 'Exam course' do
  params = { code: 7557, subject: 'Analisis',
             teacher: 'Sirne', quota: 50, modality: 'tp',
             projector: false, laboratory: false }
  exam_course = ExamCourse.new(params)

  context 'when create' do
    it 'it should have exam modality' do
      expect(exam_course.modality).to eq('ExamCourse')
    end
  end
end
