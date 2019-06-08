require 'integration_spec_helper'

describe 'Student repository' do
  subject(:repository) { StudentsRepository.new }

  let(:student) { Student.new(id: 97_266, name: 'Jazmin Ferreiro', user_name: 'jaz2') }

  context 'with no inscriptions neither grades' do
    it 'can save it and find it ' do
      repository.save(student)
      repository.find_by_user_name('jaz2')
    end
  end
end
