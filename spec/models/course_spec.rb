require 'rspec'
require_relative '../../models/course'
require_relative '../../models/student'
require_relative '../../exceptions/quote_error'
describe 'Course' do
  course_param = { id: 1, code: 9532, subject: 'Memo',
                   teacher: 'villagra', quota: 1, modality: 'tp' }
  subject(:memo) { Course.new(course_param) }

  describe 'model' do
    it { is_expected.to respond_to(:code) }
    it { is_expected.to respond_to(:subject) }
    it { is_expected.to respond_to(:teacher) }
    it { is_expected.to respond_to(:quota) }
    it { is_expected.to respond_to(:modality) }
  end

  describe 'when student applies' do
    it "the course's quota is one less " do
      params = { name: 'Jazmin Ferreiro', user_name: 'jaz2' }
      student = Student.new(params)
      student.inscribe_to(memo)
      expect(memo.quota).to equal(0)
    end

    it 'the course can accept more student outside quota' do
      params = { name: 'Jazmin Ferreiro', user_name: 'jaz2' }
      student = Student.new(params)
      student.inscribe_to(memo)
      params2 = { name: 'Jazmin Ferreiro', user_name: 'juana' }
      student2 = Student.new(params2)
      expect { student2.inscribe_to(memo) }.to raise_error(QuoteError)
    end
  end
end
