require 'integration_spec_helper'

describe CoursesRepository do
  let(:repository) { described_class.new }

  let(:course) do
    Course.new(code: 7517, subject: 'Analisis',
               teacher: 'Sirne', quota: 31, modality: 'tp',
               projector: false, laboratory: true)
  end

  describe 'saving' do
    it 'saving the same object two times should not throw an error' do
      described_class.new.save(course)

      described_class.new.save(course)
    end
  end
end
