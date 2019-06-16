require 'rspec'
require_relative '../../models/exam_course'
describe 'Exam course' do
  params = { code: 7557, subject: 'Analisis',
             teacher: 'Sirne', quota: 50, modality: 'tp',
             projector: false, laboratory: false }
  course = ExamCourse.new(params)

  context 'when create' do
    it 'it should have exam modality' do
      expect(course.modality).to eq('ExamCourse')
    end
  end

  context 'when calculate final grade' do
    it 'final grade should be equal to unique grade' do
      expect(course.final_grade([5])).to eq(5)
    end
  end
end
