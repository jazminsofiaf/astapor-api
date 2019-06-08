require 'integration_spec_helper'

describe 'Grades repository' do
  subject(:grade2) { Grade.new(id: 2, student_id: 1, code: 9533, grade: 5) }

  let(:repository) { GradesRepository.new }

  let(:grade1) { Grade.new(id: 1, student_id: 1, code: 9532, grade: 10) }

  context 'with a  calification' do
    xit 'can save it ' do
      repository.save(grade1)
    end

    xit 'can get all calification' do
      repository.save(grade1)
      repository.save(grade2)
      repository.find_by_student_id(1)
    end
  end
end
