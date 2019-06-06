# frozen_string_literal: true

require_relative '../../models/course'
# rubocop:disable Metrics/BlockLength
describe Course do
  describe 'course' do
    it { is_expected.to respond_to(:id) }
    it { is_expected.to respond_to(:code) }
    it { is_expected.to respond_to(:subject) }
    it { is_expected.to respond_to(:teacher) }
    it { is_expected.to respond_to(:quota) }
    it { is_expected.to respond_to(:modality) }
    it { is_expected.to respond_to(:con_proyector) }
    it { is_expected.to respond_to(:con_laboratorio) }
  end

  describe 'valid?' do
    it 'should be invalid when code has more than four digits' do
      algebra = Course.new(id: 2, code: 751_57, subject: 'Analisis',
                           teacher: 'Sirne', quota: 50, modality: 'tp')
      expect(algebra).not_to be_valid
      expect(algebra.errors).to have_key(:code)
    end

    it 'should be invalid when code has less than four digits' do
      algebra = Course.new(id: 2, code: 751, subject: 'Analisis',
                           teacher: 'Sirne', quota: 50, modality: 'tp')
      expect(algebra).not_to be_valid
      expect(algebra.errors).to have_key(:code)
    end

    it 'should be invalid when code has a quota greater than 300' do
      algebra = Course.new(id: 2, code: 751, subject: 'Analisis',
                           teacher: 'Sirne', quota: 301, modality: 'tp')
      expect(algebra).not_to be_valid
      expect(algebra.errors).to have_key(:quota)
    end
  end
end
# rubocop:enable Metrics/BlockLength
