require 'rspec'
require_relative '../../models/register'
describe 'Register' do
  context "with a student's grade register" do
    subject(:grade2) { Register.new(id: 1, student_username: 1, code: 9532, grade: 10) }

    let(:grade) { Register.new(id: 1, student_username: 1, code: 9532, grade: 10) }

    describe 'model' do
      it { is_expected.to respond_to(:student_username) }
      it { is_expected.to respond_to(:code) }
      it { is_expected.to respond_to(:grade) }
    end

    it 'should return true when both regiters are equal' do
      expect(grade == grade2).to eq true
    end
  end
end
