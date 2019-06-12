require 'rspec'

require_relative '../../models/student'
require_relative '../../models/register'
require_relative '../../app/repositories/students_repository'
require_relative '../../app/repositories/register_repository'
require_relative '../../app/helpers/error/duplicated_inscription_error'
require_relative '../../app/helpers/error/quote_error'
require_relative '../../app/repositories/register_repository'
require_relative '../../models/register'

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

  describe 'given a student and a course' do
    course_param = { id: 1, code: 9532, subject: 'Memo',
                     teacher: 'villagra', quota: 1, modality: 'tp' }
    memo = Course.new(course_param)
    params = { name: 'Jazmin Ferreiro', user_name: 'jaz2' }
    student = Student.new(params)

    let(:body) do
      '{"codigo_materia":"9532",'\
      '"notas":"[8, 9]","username_alumno":"jaz2"}'
    end

    let(:body3) do
      '{"codigo_materia":"9521",'\
      '"notas":"10","username_alumno":"jaz2"}'
    end
    let(:body2) do
      '{"codigo_materia":"9502",'\
      '"notas":"8","username_alumno":"jaz2"}'
    end

    it 'can enroll in a course' do
      student.inscribe_to(memo)
      expect(student.inscriptions).to eq([memo.code])
    end

    it 'cant enroll in a course twice in the same semester' do
      expect { student.inscribe_to(memo) }.to raise_error(DuplicatedInscriptionError)
    end

    describe 'when quote course is 0'

    params2 = { name: 'Jazmin Ferreiro', user_name: 'juana' }
    student2 = Student.new(params2)

    it 'cant enroll in a course with no place' do
      expect { student2.inscribe_to(memo) }.to raise_error(QuoteError)
    end

    describe 'when save grades for the student'

    it 'should have an 8 and 9 on his grades when he is calificated with an 8 and a 9' do
      calification = GradeHelper.new(JSON.parse(body))
      student.add_grade(calification)
      aux = { 9532 => [8, 9] }
      expect(student.grades).to eq aux
    end

    it 'should save every grade on a register' do
      calification = GradeHelper.new(JSON.parse(body))
      student.add_grade(calification)
      reg = RegisterRepository.new.find_by_student_username(calification.username)
      expect(reg.nil?).to eq false
    end

    describe 'when filtering courses by no inscribed'

    params = { name: 'Jazmin Ferreiro', user_name: 'jaz2' }
    student2 = Student.new(params)

    it 'should return empty array when all the courses to offer have been calificated' do
      student2.add_grade(GradeHelper.new(JSON.parse(body2)))
      student2.add_grade(GradeHelper.new(JSON.parse(body3)))
      course1 = { 'nombre': 'Memo', 'codigo': 9502,
                  'docente': 'villagra', 'cupo': 1,
                  'modalidad': 'tp' }
      course2 = { 'nombre': 'Memo2', 'codigo': 9521,
                  'docente': 'paez', 'cupo': 1,
                  'modalidad': 'tp' }
      courses_array = [course1, course2]
      expect(student2.filter_courses_by_no_approved(courses_array).size).to eq 0
    end
  end
end
