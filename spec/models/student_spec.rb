require 'rspec'
require_relative '../../exceptions/student_creation_error'
require_relative '../../models/student'
require_relative '../../app/repositories/students_repository'
require_relative '../../exceptions/duplicated_inscription'
require_relative '../../exceptions/quote_error'

describe 'Student' do
  subject(:student) do
    params = { name: 'Jazmin Ferreiro', user_name: 'jaz2' }
    Student.new(params)
  end

  describe 'model' do
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:user_name) }
    it { is_expected.to respond_to(:id) }
  end

  it 'can be created with inscriptions' do
    params = { name: 'Jazmin Ferreiro', user_name: 'jaz2', inscriptions: [9502] }
    expect { Student.new(params) }.to raise_error StudentCreationError
  end

  describe 'given a student and a cpurse' do
    course_param = { id: 1, code: 9532, subject: 'Memo',
                     teacher: 'villagra', quota: 1, modality: 'tp' }
    memo = Course.new(course_param)
    params = { name: 'Jazmin Ferreiro', user_name: 'jaz2' }
    student = Student.new(params)

    it 'can enroll in a course' do
      student.inscribe_to(memo)
      expect(student.inscriptions).to eq([memo.code])
    end

    it 'cant enroll in a course twice in the same semester' do
      expect { student.inscribe_to(memo) }.to raise_error(DuplicatedInscription)
    end

    describe 'when quote course is 0'

    params2 = { name: 'Jazmin Ferreiro', user_name: 'juana' }
    student2 = Student.new(params2)

    it 'cant enroll in a course with no place' do
      expect { student2.inscribe_to(memo) }.to raise_error(QuoteError)
    end
  end
end
