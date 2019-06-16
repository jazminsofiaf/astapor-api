require 'integration_spec_helper'

describe 'Student repository' do
  subject(:repository) { StudentsRepository.new }

  context 'when a student ' do
    params = { name: 'Jazmin Ferreiro', user_name: 'jaz2' }
    student = Student.new(params)

    context 'with no inscriptions neither grades' do
      it 'can save it and find it ' do
        repository.save(student)
        student_found = repository.find_by_user_name('jaz2')
        expect(student_found.name).to eq(student.name)
      end
    end

    context 'when it has an inscription' do
      course = ExamCourse.new(id: 1,
                              code: 9532,
                              subject: 'Memo',
                              teacher: 'villagra',
                              quota: 30,
                              modality: 'tp')
      student.inscribe_to(course)

      it 'can save it and find it ' do
        repository.save(student)
        student_found = repository.find_by_user_name('jaz2')
        expect(student_found.name).to eq(student.name)
        expect(student_found.inscriptions).to eq(student.inscriptions)
      end

      it 'if already exist it does not crate new ' do
        repository.save(student)
        params = { name: 'Jazmin Ferreiro', user_name: 'jaz2' }
        student_found = repository.find_or_create(params)
        expect(student_found.name).to eq(student.name)
        expect(student_found.inscriptions).to eq(student.inscriptions)
      end

      it 'create new if doesnt exist ' do
        params = { name: 'Jazmin Ferreiro', user_name: 'jazmina' }
        student_found = repository.find_or_create(params)
        expect(student_found.name).to eq(student.name)
        expect(student_found.inscriptions).to eq(Set[])
      end

      context 'when a grade is added' do
        grade = GradeHelper.new('codigo_materia' => 9532,
                                'notas' => '8',
                                'username_alumno' => 'jaz2')
        student.add_grade(grade)

        it 'it can be found with grades ' do
          repository.save(student)
          student_found = repository.find_by_user_name('jaz2')
          expect(student_found.name).to eq(student.name)
          expect(student_found.inscriptions).to eq(student.inscriptions)
          expect(student_found.grades).to eq(student.grades)
        end

        it 'if already exist it does not crate new ' do
          repository.save(student)
          params = { name: 'Jazmin Ferreiro', user_name: 'jaz2' }
          student_found = repository.find_or_create(params)
          expect(student_found.name).to eq(student.name)
          expect(student_found.inscriptions).to eq(student.inscriptions)
          expect(student_found.grades).to eq(student.grades)
        end

        it 'create new if doesnt exist ' do
          repository.save(student)
          params = { name: 'Jazmin Ferreiro', user_name: 'jazmina' }
          student_found = repository.find_or_create(params)
          expect(student_found.user_name).to eq('jazmina')
          expect(student_found.name).to eq(student.name)
          expect(student_found.inscriptions).to eq(Set[])
          expect(student_found.grades).to eq({})
        end
      end
    end
  end
end
