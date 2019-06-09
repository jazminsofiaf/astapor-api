require 'integration_spec_helper'

describe 'Student repository' do
  subject(:repository) { StudentsRepository.new }

  let(:student) do
    params = { name: 'Jazmin Ferreiro', user_name: 'jaz2' }
    Student.new(params)
  end

  context 'with no inscriptions neither grades' do
    it 'can save it and find it ' do
      repository.save(student)
      student_found = repository.find_by_user_name('jaz2')
      expect(student_found.name).to eq(student.name)
    end
  end

  context 'with an inscription' do
    it 'can save it and find it ' do
      course = Course.new(id: 1, code: 9532, subject: 'Memo',
                          teacher: 'villagra', quota: 30, modality: 'tp')
      student.inscribe_to(course)
      repository.save(student)
      student_found = repository.find_by_user_name('jaz2')
      expect(student_found.name).to eq(student.name)
      expect(student_found.inscriptions).to eq(student.inscriptions)
    end

    it 'if already exist it does not crate new ' do
      course = Course.new(id: 1, code: 9532, subject: 'Memo',
                          teacher: 'villagra', quota: 30, modality: 'tp')
      student.inscribe_to(course)
      repository.save(student)
      params = { name: 'Jazmin Ferreiro', user_name: 'jaz2' }
      student_found = repository.find_or_create(params)
      expect(student_found.name).to eq(student.name)
      expect(student_found.inscriptions).to eq(student.inscriptions)
    end

    it 'create new if doesnt exist ' do
      params = { name: 'Jazmin Ferreiro', user_name: 'jaz2' }
      student_found = repository.find_or_create(params)
      expect(student_found.name).to eq(student.name)
      expect(student_found.inscriptions).to eq([])
    end
  end
end
