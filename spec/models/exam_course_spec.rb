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

    it 'pass with more than 4' do
      expect(course.success(5)).to eq(true)
    end

    it 'pass with a 4' do
      expect(course.success(4)).to eq(true)
    end

    it 'fail with a less than 4' do
      expect(course.success(2)).to eq(false)
    end
  end
end
