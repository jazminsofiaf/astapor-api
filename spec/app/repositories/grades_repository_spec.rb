require 'integration_spec_helper'

describe 'Grades repository' do
  subject(:repository) { GradesRepository.new }

  let(:grade1) { Grade.new(id: 2, student_id: 1, code: 9533) }

  let(:grade2) { Grade.new(id: 1, student_id: 1, code: 9532, grade: 10) }

  context 'with a  calification' do
    it 'can save it ' do
      repository.save(grade1)
    end

    it 'can get all calification' do
      repository.save(grade1)
      repository.save(grade2)
      grades = repository.find_by_student_id(1)
      expect(grades.first.grade).to eq(nil)
      expect(grades[1].grade).to eq(grade2.grade)
    end
  end
end
