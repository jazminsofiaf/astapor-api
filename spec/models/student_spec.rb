# frozen_string_literal: true

require 'rspec'
require_relative '../../models/student'
require_relative '../../models/exceptions/duplicated_inscription'

describe 'Student' do
  subject(:student) { Student.new(97_266, 'Jazmin Ferreiro', 'jaz2') }
  describe 'model' do
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:user_name) }
    it { is_expected.to respond_to(:id) }
  end

  course_param = { id: 1, code: 9532, subject: 'Memo',
                   teacher: 'villagra', quota: 30, modality: 'tp' }
  memo = Course.new(course_param)

  describe 'enroll in a course' do
    it 'can enroll in a course' do
      expect(student.inscribe_to(memo)).to be_truthy
    end

    it 'can enroll in a course twice in the same semester' do
      student.inscribe_to(memo)
      expect { student.inscribe_to(memo) }.to raise_error(DuplicatedInscription)
    end
  end
end
