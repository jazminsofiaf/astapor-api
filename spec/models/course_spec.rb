require 'rspec'
require_relative '../../models/course'
require_relative '../../models/student'

describe 'Course' do
  course_param = { id: 1, code: 9532, subject: 'Memo',
                   teacher: 'villagra', quota: 30, modality: 'tp' }
  subject(:memo) { Course.new(course_param) }

  describe 'model' do
    it { is_expected.to respond_to(:code) }
    it { is_expected.to respond_to(:subject) }
    it { is_expected.to respond_to(:teacher) }
    it { is_expected.to respond_to(:quota) }
    it { is_expected.to respond_to(:modality) }
  end

  describe 'when student applies' do
    params = { name: 'Jazmin Ferreiro', user_name: 'jaz2' }
    student = Student.new(params)
    it "the course's quota is one less " do
      student.inscribe_to(memo)
      expect(memo.quota).to equal(29)
    end
  end
end
