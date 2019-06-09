require 'integration_spec_helper'

describe 'Registers repository' do
  subject(:repository) { RegisterRepository.new }

  let(:grade1) { Register.new(id: 2, student_username: 'jaz', code: 9533) }

  let(:grade2) { Register.new(id: 1, student_username: 'jaz', code: 9532, grade: 10) }

  context 'with a  calification' do
    it 'can save it ' do
      repository.save(grade1)
    end

    it 'can get all calification' do
      repository.save(grade1)
      repository.save(grade2)
      grades = repository.find_by_student_username('jaz')
      expect(grades.first.grade).to eq(nil)
      expect(grades[1].grade).to eq(grade2.grade)
    end
  end
end
