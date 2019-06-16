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

  context 'when success final grade' do
    it 'final grade should be equal to avarage' do
      expect(course.final_grade([5, 6, 7, 8])).to eq(6.5)
    end

    it 'pass with more than 6' do
      expect(course.success(7)).to eq(true)
    end

    it 'pass with a 6' do
      expect(course.success(6)).to eq(true)
    end
  end

  context 'when fail with a 5,.. final grade' do
    it 'final grade should be equal to avarage' do
      expect(course.final_grade([5, 6, 6])).to eq(5.67)
    end

    it 'fail with less than 6' do
      expect(course.success(5.67)).to eq(false)
    end
  end

  context 'when fail with more than two homeworks with less than 4' do
    it 'final grade should be equal to avarage' do
      expect(course.final_grade([3, 3, 10, 9, 10])).to eq(1)
    end

    it 'fail with less than 6' do
      expect(course.success(1)).to eq(false)
    end
  end
end
