# frozen_string_literal: true

require_relative '../../models/course'

describe Course do
  describe 'course' do
    it { is_expected.to respond_to(:id) }
    it { is_expected.to respond_to(:code) }
    it { is_expected.to respond_to(:subject) }
    it { is_expected.to respond_to(:teacher) }
    it { is_expected.to respond_to(:quota) }
    it { is_expected.to respond_to(:modality) }
    it { is_expected.to respond_to(:created_on) }
    it { is_expected.to respond_to(:updated_on) }
  end
end
