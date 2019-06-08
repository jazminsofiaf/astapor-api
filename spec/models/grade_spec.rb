require 'rspec'
require_relative '../../models/grade'
describe 'Grades' do
  context "with a student's grade" do
    subject(:grade) { Grade.new(id: 1, student_id: 1, code: 9532, grade: 10) }

    describe 'model' do
      it { is_expected.to respond_to(:student_id) }
      it { is_expected.to respond_to(:code) }
      it { is_expected.to respond_to(:grade) }
    end
  end
end
