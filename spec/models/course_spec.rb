# frozen_string_literal: true

require_relative '../../models/course'
# rubocop:disable Metrics/BlockLength
describe Course do
  describe 'model' do
    it { is_expected.to respond_to(:id) }
    it { is_expected.to respond_to(:code) }
    it { is_expected.to respond_to(:subject) }
    it { is_expected.to respond_to(:teacher) }
    it { is_expected.to respond_to(:quota) }
    it { is_expected.to respond_to(:modality) }
    it { is_expected.to respond_to(:projector) }
    it { is_expected.to respond_to(:laboratory) }
  end

  describe 'valid?' do
    it 'should be invalid when code has more than four digits' do
      algebra = Course.new(id: 2, code: 751_57, subject: 'Analisis',
                           teacher: 'Sirne', quota: 50, modality: 'tp',
                           projector: false, laboratory: false)
      expect(algebra).not_to be_valid
      expect(algebra.errors).to have_key(:code)
    end

    it 'should be invalid when code has less than four digits' do
      algebra = Course.new(id: 2, code: 751, subject: 'Analisis',
                           teacher: 'Sirne', quota: 50, modality: 'tp',
                           projector: false, laboratory: false)
      expect(algebra).not_to be_valid
      expect(algebra.errors).to have_key(:code)
    end

    it 'should be invalid when code has a quota greater than 300' do
      algebra = Course.new(id: 2, code: 751, subject: 'Analisis',
                           teacher: 'Sirne', quota: 301, modality: 'tp',
                           projector: false, laboratory: false)
      expect(algebra).not_to be_valid
      expect(algebra.errors).to have_key(:quota)
    end

    it 'should be invalid when it requests both lab and projector' do
      expect do
        Course.new(id: 2, code: 751, subject: 'Analisis',
                   teacher: 'Sirne', quota: 301, modality: 'tp',
                   projector: true, laboratory: true)
      end.to raise_error(IncompatibleRequestException)
    end

    # it 'should be invalid when title has more than 50 characters' do
    #   algebra = Course.new(id: 2, code: 7513,
    #                        subject: 'Analisis12345678912345678912
    #                                  3456789123456789123456gdfgd7',
    #                        teacher: 'Sirne', quota: 30, modality: 'tp',
    #                        projector: false, laboratory: false)
    #   expect(algebra).not_to be_valid
    #   expect(algebra.errors).to have_key(:subject)
    # end

    # it 'should be invalid when title is not present' do
    #   algebra = Course.new(id: 2, code: 7513,
    #                        subject: nil,
    #                        teacher: 'Sirne',
    #                        quota: 31, modality: 'tp',
    #                        projector: false,
    #                        laboratory: false)
    #   expect(algebra).not_to be_valid
    #   expect(algebra.errors).to have_key(:subject)
    # end
  end
end
# rubocop:enable Metrics/BlockLength
