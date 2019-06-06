# frozen_string_literal: true

require 'rspec'
require_relative '../../models/student'

describe 'Student' do
  subject(:student) { Student.new(97_266, 'Jazmin Ferreiro', 'jaz2') }
  describe 'model' do
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:user_name) }
    it { is_expected.to respond_to(:id) }
  end
end
