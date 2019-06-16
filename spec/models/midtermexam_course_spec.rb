require 'rspec'
require_relative '../../models/mid_term_exams_course'

describe 'Mid Term exams course' do
  params = { code: 7557, subject: 'Analisis',
             teacher: 'Sirne', quota: 50, modality: 'tp',
             projector: false, laboratory: false }
  course = MidTermExamsCourse.new(params)
  context 'when create' do
    it 'it should have exam modality' do
      expect(course.modality).to eq('MidTermExamsCourse')
    end
  end

  context 'when calculate final grade' do
    it 'final grade should be equal to avarage' do
      expect(course.final_grade([5, 6, 7, 8])).to eq(6.5)
    end

    it 'pass with more than 4' do
      expect(course.success(7)).to eq(true)
    end

    it 'pass with a 4' do
      expect(course.success(6)).to eq(true)
    end

    it 'fail with a less than 4' do
      expect(course.success(5.9)).to eq(false)
    end
  end
end
