require 'integration_spec_helper'
require 'byebug'

describe CoursesRepository do
  let(:repository) { described_class.new }

  let(:course) do
    Course.new(id: 7, code: 7517, subject: 'Analisis',
               teacher: 'Sirne', quota: 31, modality: 'tp',
               projector: false, laboratory: true)
  end

  describe 'saving' do
    it 'saving the same object two times should not throw an error' do
      described_class.new.save(course)
      described_class.new.save(course)
    end

    described_class.new.delete_all
    it 'saving the course and then get it with the same amount of students' do
      course.reduce_quota
      course.reduce_quota
      described_class.new.save(course)
      founded = described_class.new.find_by_code(course.code)
      expect(founded.quota).to eq(29)
    end
  end
end
