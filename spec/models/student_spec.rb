require 'rspec'

require_relative '../../models/student'
require_relative '../../models/register'
require_relative '../../app/repositories/students_repository'
require_relative '../../app/repositories/register_repository'
require_relative '../../app/helpers/error/duplicated_inscription_error'
require_relative '../../app/helpers/error/quote_error'
require_relative '../../app/repositories/register_repository'
require_relative '../../models/register'
require_relative '../../app/helpers/grade_helper'

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

  course_param = { id: 1, code: 9532, subject: 'Memo',
                   teacher: 'villagra', quota: 1, modality: 'tp' }
  memo = Course.new(course_param)
  params = { name: 'Jazmin Ferreiro', user_name: 'jaz2' }
  student = Student.new(params)

  describe 'given a student and a course' do
    it 'can enroll in a course' do
      student.inscribe_to(memo)
      expect(student.inscriptions).to eq([memo.code])
    end

    it 'cant enroll in a course twice in the same semester' do
      expect { student.inscribe_to(memo) }.to raise_error(DuplicatedInscriptionError)
    end
  end

  describe 'when quote course is 0' do
    params2 = { name: 'Jazmin Ferreiro', user_name: 'juana' }
    student2 = Student.new(params2)

    it 'cant enroll in a course with no place' do
      expect { student2.inscribe_to(memo) }.to raise_error(QuoteError)
    end
  end

  describe 'when save grades for the student' do
    memo_grade =
      '{"codigo_materia":"9532",'\
      '"notas":"[8, 9]","username_alumno":"jaz2"}'

    list_grade = GradeHelper.new(JSON.parse(memo_grade))

    aux = { 9532 => [8, 9] }
    it 'should have an 8 and 9 on his grades when he is calificated with an 8 and a 9' do
      student.add_grade(list_grade)
      expect(student.grades).to eq aux
    end

    it 'should save every grade on a register' do
      StudentsRepository.new.save(student)
      student_found = StudentsRepository.new.find_by_user_name(list_grade.username)
      expect(student_found.grades).to eq aux
    end

    algebra_grade =
      '{"codigo_materia":"1705",'\
      '"notas":"[8, 9]","username_alumno":"jaz2"}'

    it 'should raise exception when student isnt inscibed' do
      grade = GradeHelper.new(JSON.parse(algebra_grade))
      expect { student.add_grade(grade) }.to raise_error(StudentNotInscribedError)
    end
  end
end
