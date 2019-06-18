require 'rspec'
require_relative '../../models/register'
describe 'Register' do
  context "with a student's grade register" do
    subject(:grade2) { Register.new(id: 1, student_username: 1, code: 9532, grade: 10) }

    let(:grade) { Register.new(id: 1, student_username: 1, code: 9532, grade: 10) }
    let(:grade3) { Register.new(id: 1, student_username: 1, code: 9532, grade: 8) }

    describe 'model' do
      it { is_expected.to respond_to(:student_username) }
      it { is_expected.to respond_to(:code) }
      it { is_expected.to respond_to(:grade) }
    end

    it 'should return true when both regiters are equal' do
      expect(grade == grade2).to eq true
    end

    it 'should return false when both regiters are different' do
      expect(grade == grade3).to eq false
    end
  end
end
