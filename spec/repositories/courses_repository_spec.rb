require 'byebug'

require_relative '../../app/repositories/courses_repository'

describe CoursesRepository do
  let(:repository) { described_class.new }

  let(:course) do
    Course.new(id: 2, code: 7517, subject: 'Analisis',
               teacher: 'Sirne', quota: 31, modality: 'tp',
               projector: false, laboratory: true)
  end

  describe 'saving' do
    it 'saving the same object two times should throw an error' do
      expect do
        described_class.new.save(course)
        described_class.new.save(course)
      end.to raise_exception DuplicateSubjectException
    end
  end
end
